<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="footnotes.xsl"/>

	<xsl:template match="*" mode="main-content">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="meta"/>

	<xsl:template match="/root/header">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="@class">
					<xsl:attribute name="class">
						<xsl:value-of select="concat(@class, ' as-fullbleed with-scheme-secondary')"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">as-fullbleed with-scheme-secondary</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="@*[name() != 'class']"/>
			<div>
				<xsl:apply-templates select="node()"/>
			</div>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[@class='footnote-ref']">
		<xsl:copy>
			<xsl:attribute name="class">as-footnote-ref</xsl:attribute>
			<xsl:apply-templates select="@*[name() != 'class']"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[@class='tile'][text()[normalize-space() != '']]">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<span>
				<xsl:apply-templates select="node()"/>
			</span>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[@class='insert'][generate-id() = generate-id(//*[@class='insert'][1])]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<link rel="stylesheet" href="/assets/css/6.components/insert.css"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[@class='tile'][generate-id() = generate-id(//*[@class='tile'][1])]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<link rel="stylesheet" href="/assets/css/6.components/tile.css"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/root/section/p[count(preceding-sibling::p)=0 and count(following-sibling::p)=0]">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="@class">
					<xsl:attribute name="class">
						<xsl:value-of select="concat(@class, ' as-tagline')"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">as-tagline</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="@*[name() != 'class']"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:variable name="theme">
		<xsl:value-of select="//meta/@theme"/>
	</xsl:variable>

	<xsl:template match="root[@lang='fr']" mode="noscript">
		<p lang="fr">Le javascript est désactivé. Veuillez vous rendre <a href="full.html">ici</a> pour accéder au contenu complet.</p>
	</xsl:template>
	<xsl:template match="root[@lang='en']" mode="noscript">
		<p lang="en">JavaScript is disabled. Please go <a href="full.html">here</a> to access the full content.</p>
	</xsl:template>

	<xsl:template match="root" mode="body" name="body">
		<body ontouchstart="" class="{$theme} with-line-and-icons">
			<link rel="stylesheet" href="/assets/css/4.regions/body.css"/>
			<xsl:if test="$script">
				<noscript>
					<xsl:apply-templates select="." mode="noscript"/>
				</noscript>
			</xsl:if>
			<link rel="stylesheet" href="/assets/css/4.regions/header.css"/>
			<header id="header">
				<h1 class="signature">Allocation <em>Québec</em></h1>
			</header>
			<link rel="stylesheet" href="/assets/css/4.regions/nav.css"/>
			<nav id="nav">
				<h2 class="as-invisible">Navigation principale</h2>
				<div>
					<div class="__dropdown">
						<h3 class="h5">Pourquoi ?</h3>
						<div>
							<section>
								<h4 class="h5">Valeurs</h4>
								<a href="/fr/valeurs/liberte">Liberté</a>
								<a href="/fr/valeurs/dignite">Dignité</a>
								<a href="/fr/valeurs/ecologie">Écologie</a>
								<a href="/fr/valeurs/equite">Équité</a>
								<a href="/fr/valeurs/securite">Securité</a>
								<a href="/fr/valeurs/solidarite">Solidarité</a>
							</section>
							<section>
								<h4 class="h5">Bienfaits</h4>
								<a href="/fr/bienfaits/bureaucratie">Bureaucratie</a>
								<a href="/fr/bienfaits/dereglementation">Déréglementation</a>
								<a href="/fr/bienfaits/innovation">Innovation</a>
								<a href="/fr/bienfaits/efficacite">Efficacité</a>
								<a href="/fr/bienfaits/productivite">Productivité</a>
							</section>
						</div>
					</div>
					<div class="__dropdown">
						<h3 class="h5">Pour qui ?</h3>
						<div>
							<a href="/fr/classes/travailleurs">Travailleur·es</a>
							<a href="/fr/classes/consommateurs">Consommateur·rices</a>
							<a href="/fr/classes/artistes">Artistes</a>
							<a href="/fr/classes/entrepreneurs">Entrepreneur·es</a>
							<a href="/fr/classes/parents">Parents</a>
							<a href="/fr/classes/retraites">Retraité·es</a>
							<a href="/fr/classes/etudiants">Étudiant·es</a>
						</div>
					</div>
					<div class="__dropdown">
						<h3 class="h5">Comment ?</h3>
						<div>
							<a href="/fr/comment/programme">Programme économique</a>
							<a href="/fr/comment/plan">Plan de déploiement</a>
							<a href="/fr/comment/etat">Rôle de l'État</a>
						</div>
					</div>
					<div class="__dropdown">
						<h3 class="h5">En savoir plus</h3>
						<div>
							<a href="/fr/plus/appellation">Pourquoi cette appellation ?</a>
							<a href="/fr/plus/mythes">Mythes persistants</a>
							<a href="/fr/plus/partisans">Panthéon des partisans</a>
							<a href="/fr/plus/considerations">Considérations pratiques</a>
							<a href="/fr/plus/theorie">Fondements théoriques</a>
							<a href="/fr/plus/faq">Foire aux questions</a>
						</div>
					</div>
					<a class="h5" href="/fr/impliquez-vous">Impliquez-vous !</a>
				</div>
			</nav>
			<main>
				<xsl:apply-templates mode="main-content" />
			</main>
			<footer id="footer">
				<link rel="stylesheet" href="/assets/css/4.regions/footer.css"/>
				<article>
					<h2 class="as-invisible">Mission</h2>
					<strong class="signature as-big">Allocation <em>Québec</em></strong>
					<p>invite les québécois.es à réfléchir collectivement à la création d’une allocation de subsistance, un projet de société porteur pour le XXI<sup>e</sup> siècle et dont les retombées positives bénéficieraient à tous et toutes.</p>
				</article>
				<nav id="sitemap">
					<link rel="stylesheet" href="/assets/css/4.regions/sitemap.css"/>
					<h2 class="as-invisible">Plan du site</h2>
					<div>
						<section>
							<h3 class="h4">Pourquoi ?</h3>
							<div>
								<section>
									<h4 class="h5">Valeurs</h4>
									<a href="/fr/valeurs/liberte">Liberté</a>
									<a href="/fr/valeurs/dignite">Dignité</a>
									<a href="/fr/valeurs/ecologie">Écologie</a>
									<a href="/fr/valeurs/equite">Équité</a>
									<a href="/fr/valeurs/securite">Securité</a>
									<a href="/fr/valeurs/solidarite">Solidarité</a>
								</section>
								<section>
									<h4 class="h5">Bienfaits</h4>
									<a href="/fr/bienfaits/bureaucratie">Bureaucratie</a>
									<a href="/fr/bienfaits/dereglementation">Déréglementation</a>
									<a href="/fr/bienfaits/innovation">Innovation</a>
									<a href="/fr/bienfaits/efficacite">Efficacité</a>
									<a href="/fr/bienfaits/productivite">Productivité</a>
								</section>
							</div>
						</section>
						<section>
							<h3 class="h4">Pour qui ?</h3>
							<a href="/fr/classes/travailleurs">Travailleur·es</a>
							<a href="/fr/classes/consommateurs">Consommateur·rices</a>
							<a href="/fr/classes/artistes">Artistes</a>
							<a href="/fr/classes/entrepreneurs">Entrepreneur·es</a>
							<a href="/fr/classes/parents">Parents</a>
							<a href="/fr/classes/retraites">Retraité·es</a>
							<a href="/fr/classes/etudiants">Étudiant·es</a>
						</section>
						<section>
							<h3 class="h4">Comment ?</h3>
							<a href="/fr/comment/programme">Programme économique</a>
							<a href="/fr/comment/plan">Plan de déploiement</a>
							<a href="/fr/comment/etat">Rôle de l'État</a>
						</section>
						<section>
							<h3 class="h4">En savoir plus</h3>
							<a href="/fr/plus/appellation">Pourquoi cette appellation ?</a>
							<a href="/fr/plus/mythes">Mythes persistants</a>
							<a href="/fr/plus/partisans">Panthéon des partisans</a>
							<a href="/fr/plus/considerations">Considérations pratiques</a>
							<a href="/fr/plus/theorie">Fondements théoriques</a>
							<a href="/fr/plus/faq">Foire aux questions</a>
						</section>
					</div>
				</nav>
				<p>2025 <span style="transform: scaleX(-1); display: inline-block;">© </span> Gauche d'auteur</p>
			</footer>
		</body>
	</xsl:template>
</xsl:stylesheet>

