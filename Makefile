.SILENT:

SRC=src/content
TEMP=temp
DIST=.
XSLT=src/templates/index.xsl

all:
	sh src/scripts/build.sh $(SRC) $(TEMP) $(DIST) $(XSLT)
