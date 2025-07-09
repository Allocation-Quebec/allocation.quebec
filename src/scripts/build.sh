#!/bin/sh

# Vérifier si suffisamment d'arguments sont fournis
if [ "$#" -lt 3 ] || [ "$#" -gt 4 ]; then
    echo "Usage: $0 dossier_source dossier_temp dossier_destination [fichier_xslt]"
    exit 1
fi

# Récupérer les arguments
SRC_DIR="$1"    # Dossier contenant les fichiers .txt et .xml d'origine
TEMP_DIR="$2"   # Dossier temporaire où seront placés les HTML intermédiaires
DEST_DIR="$3"   # Dossier final où seront placés les HTML transformés par XSLT
XSLT_FILE="$4"  # Fichier XSLT optionnel

# Vérifier si le dossier source existe
if [ ! -d "$SRC_DIR" ]; then
    echo "Le dossier source spécifié n'existe pas: $SRC_DIR"
    exit 1
fi

# Créer les dossiers TEMP et DEST s'ils n'existent pas
mkdir -p "$TEMP_DIR"
mkdir -p "$DEST_DIR"

# === 1️⃣ Phase 1 : Transformer les fichiers TXT en HTML avec Pandoc ===
echo "📄 Phase 1: Conversion TXT → HTML dans $TEMP_DIR"
find "$SRC_DIR" -type f -name "*.txt" | while read -r txt_file; do
    relative_path="${txt_file#$SRC_DIR/}"
    relative_dir=$(dirname "$relative_path")
    filename=$(basename "$txt_file" .txt)

    output_subdir="$TEMP_DIR/$relative_dir"
    output_file="$output_subdir/$filename.html"

    mkdir -p "$output_subdir"

    # MODIFIÉ : ne reconvertir que si nécessaire
    if [ ! -f "$output_file" ] || [ "$txt_file" -nt "$output_file" ]; then
        pandoc "$txt_file" -o "$output_file" --wrap=none
        if [ $? -eq 0 ]; then
            echo "✅ TXT → HTML : $txt_file → $output_file"
        else
            echo "❌ Échec de conversion TXT → HTML : $txt_file"
        fi
    else
        echo "⏩ TXT inchangé : $txt_file"
    fi
done

# === 2️⃣ Phase 2 : Insérer le HTML généré dans un modèle XML ===
echo "📄 Phase 2: Génération des fichiers XML avec le contenu HTML"
find "$TEMP_DIR" -type f -name "*.html" | while read -r html_file; do
    relative_path="${html_file#$TEMP_DIR/}"
    relative_dir=$(dirname "$relative_path")
    filename=$(basename "$html_file" .html)

    # Déterminer la langue (fr/en) à partir du dossier parent
    if echo "$relative_path" | grep -q "^fr/"; then
        LANG="fr"
    elif echo "$relative_path" | grep -q "^en/"; then
        LANG="en"
    else
        echo "⚠️ Impossible de déterminer la langue pour : $html_file"
        continue
    fi

    # Copier le modèle XML correspondant
    xml_template="src/includes/$LANG.xml"
    xml_output="$TEMP_DIR/$relative_dir/$filename.xml"

    if [ ! -f "$xml_template" ]; then
        echo "❌ Modèle XML introuvable : $xml_template"
        continue
    fi

    mkdir -p "$(dirname "$xml_output")"

    # MODIFIÉ : ne réinsérer que si le HTML ou le modèle est plus récent
    if [ ! -f "$xml_output" ] || [ "$html_file" -nt "$xml_output" ] || [ "$xml_template" -nt "$xml_output" ]; then
        cp "$xml_template" "$xml_output"
        gsed -i "/<root lang=\"$LANG\">/,/<\/root>/!b;//!d;/<root lang=\"$LANG\">/r $html_file" "$xml_output"
        echo "✅ Insertion : $html_file → $xml_output"
    else
        echo "⏩ Insertion inchangée : $html_file"
    fi
done

# === 3️⃣ Phase 3 : Transformer les fichiers XML avec xsltproc ===
echo "📄 Phase 3: Transformation XML → HTML avec XSLT dans $DEST_DIR"
find "$TEMP_DIR" -type f -name "*.xml" | while read -r xml_file; do
    relative_path="${xml_file#$TEMP_DIR/}"
    relative_dir=$(dirname "$relative_path")
    filename=$(basename "$xml_file" .xml)

    output_subdir="$DEST_DIR/$relative_dir"
    output_file="$output_subdir/$filename.html"

    mkdir -p "$output_subdir"

    # MODIFIÉ : ne transformer que si le XML ou le XSLT est plus récent
    if [ ! -f "$output_file" ] || [ "$xml_file" -nt "$output_file" ] || { [ -n "$XSLT_FILE" ] && [ "$XSLT_FILE" -nt "$output_file" ]; }; then
        if [ -n "$XSLT_FILE" ]; then
            xsltproc "$XSLT_FILE" "$xml_file" > "$output_file"
        else
            xsltproc "$xml_file" > "$output_file"
        fi
        if [ $? -eq 0 ]; then
            echo "✅ XSLT : $xml_file → $output_file"
        else
            echo "❌ Échec XSLT : $xml_file"
        fi
    else
        echo "⏩ XSLT inchangé : $xml_file"
    fi
done
