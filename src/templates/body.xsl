<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="footnotes.xsl"/>

	<xsl:template match="*" mode="main-content">
		<xsl:apply-templates/>
	</xsl:template>


	<xsl:template match="root[@lang='fr']" mode="noscript">
		<p lang="fr">Le javascript est désactivé. Veuillez vous rendre <a href="full.html">ici</a> pour accéder au contenu complet.</p>
	</xsl:template>
	<xsl:template match="root[@lang='en']" mode="noscript">
		<p lang="en">JavaScript is disabled. Please go <a href="full.html">here</a> to access the full content.</p>
	</xsl:template>

	<xsl:template match="root" mode="body" name="body">
		<body ontouchstart="">
			<xsl:if test="$script">
				<noscript>
					<xsl:apply-templates select="." mode="noscript"/>
				</noscript>
			</xsl:if>
			<header id="entete-principal">
				<h1 class="signature">Allocation <em>Québec</em></h1>
			</header>
			<nav id="navigation-principale">
				<h2 class="is-invisible">Navigation principale</h2>
				<div>
					<div class="menu-deroulant">
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
					<div class="menu-deroulant">
						<h3 class="h5">Pour qui ?</h3>
						<div>
							<a href="/fr/roles/travailleurs">Travailleur•es</a>
							<a href="/fr/roles/consommateurs">Consommateur•rices</a>
							<a href="/fr/roles/artistes">Artistes</a>
							<a href="/fr/roles/entrepreneurs">Entrepreneur•es</a>
							<a href="/fr/roles/parents">Parents</a>
							<a href="/fr/roles/etudiants">Étudiant•es</a>
						</div>
					</div>
					<div class="menu-deroulant">
						<h3 class="h5">Comment ?</h3>
						<div>
							<a href="/fr/moyens/abolition">Abolition de programmes</a>
							<a href="/fr/moyens/etat">Rôle de l'État</a>
							<a href="/fr/moyens/financement">Financement</a>
							<a href="/fr/moyens/deploiement">Déploiement progressif</a>
							<a href="/fr/moyens/plan">Plan complet</a>
						</div>
					</div>
					<div class="menu-deroulant">
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
			<footer id="pied-site" class="full secondary dark">
				<article>
					<h2 class="is-invisible">Mission</h2>
					<strong class="signature grande">Allocation <em>Québec</em></strong>
					<p>invite les québécois.es à réfléchir collectivement à la création d’une allocation de subsistance, un projet de société porteur pour le XXI<sup>e</sup> siècle et dont les retombées positives bénéficieraient à tous et toutes.</p>
				</article>
				<section id="plan-site">
					<h2 class="is-invisible">Plan du site</h2>
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
							<a href="/fr/roles/travailleurs">Travailleur•es</a>
							<a href="/fr/roles/consommateurs">Consommateur•rices</a>
							<a href="/fr/roles/artistes">Artistes</a>
							<a href="/fr/roles/entrepreneurs">Entrepreneur•es</a>
							<a href="/fr/roles/parents">Parents</a>
							<a href="/fr/roles/etudiants">Étudiant•es</a>
						</section>
						<section>
							<h3 class="h4">Comment ?</h3>
							<a href="/fr/moyens/abolition">Abolition de programmes</a>
							<a href="/fr/moyens/etat">Rôle de l'État</a>
							<a href="/fr/moyens/financement">Financement</a>
							<a href="/fr/moyens/deploiement">Déploiement progressif</a>
							<a href="/fr/moyens/plan">Plan complet</a>
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
				</section>
				<p>2025 <span style="transform: scaleX(-1); display: inline-block;">© </span> Gauche d'auteur</p>
			</footer>
		</body>
	</xsl:template>
</xsl:stylesheet>

