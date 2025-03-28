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
		<body>
			<xsl:if test="$script">
				<noscript>
					<xsl:apply-templates select="." mode="noscript"/>
				</noscript>
			</xsl:if>
			<header>
				<div>
					<h1>Allocation <em>Québec</em></h1>
					<nav id="navigation-principale">
						<h2 hidden="">Navigation principale</h2>
						<div class="menu-deroulant">
							<h3 class="h5">Pourquoi ?</h3>
							<div>
								<section>
									<h4 class="h5">Valeurs</h4>
									<a href="/valeurs/liberte">Liberté</a>
									<a href="/valeurs/dignite">Dignité</a>
									<a href="/valeurs/ecologie">Écologie</a>
									<a href="/valeurs/securite">Securité</a>
									<a href="/valeurs/solidarite">Solidarité</a>
								</section>
								<section>
									<h4 class="h5">Bienfaits</h4>
									<a href="/bienfaits/bureaucratie">Bureaucratie</a>
									<a href="/bienfaits/dereglementation">Déréglementation</a>
									<a href="/bienfaits/innovation">Innovation</a>
									<a href="/bienfaits/efficacite">Efficacité</a>
									<a href="/bienfaits/productivite">Productivité</a>
								</section>
							</div>
						</div>
						<div class="menu-deroulant">
							<h3 class="h5">Pour qui ?</h3>
							<div>
								<a href="/roles/travailleurs">Travailleur•es</a>
								<a href="/roles/consommateurs">Consommateur•rices</a>
								<a href="/roles/artistes">Artistes</a>
								<a href="/roles/entrepreneurs">Entrepreneur•es</a>
								<a href="/roles/parents">Parents</a>
								<a href="/roles/etudiants">Étudiant•es</a>
								<a href=""></a>
							</div>
						</div>
						<div>
							<h3 class="h5">Comment ?</h3>
						</div>
						<div class="menu-deroulant">
							<h3 class="h5">En savoir plus</h3>
							<div>
								<a href="/plus/appellation">Pourquoi cette appellation ?</a>
								<a href="/plus/mythes">Mythes persistants</a>
								<a href="/plus/partisans">Panthéon des partisans</a>
								<a href="/plus/considerations">Considérations pratiques</a>
								<a href="/plus/theorie">Fondements théoriques</a>
								<a href="/plus/faq">Foire aux questions</a>
							</div>
						</div>
						<a class="h5" href="/impliquez-vous">Impliquez-vous !</a>
					</nav>
				</div>
			</header>
			<main>
				<xsl:apply-templates mode="main-content" />
			</main>
		</body>
	</xsl:template>
</xsl:stylesheet>

