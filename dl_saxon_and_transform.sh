#!/bin/bash
echo "downloading saxon"
wget https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12-1J.zip && unzip SaxonHE12-1J.zip -d saxon && rm -rf SaxonHE12-1J.zip

echo "transform"

java -jar saxon/saxon-he-12.1.jar -s:'data/mentions.xml' -xsl:'xsl/fackel_mentions_rdf.xsl' -o:'html/mentions.ttl'
java -jar saxon/saxon-he-12.1.jar -s:'data/fackelTexts_cascaded.xml' -xsl:'xsl/fackel_rdf.xsl' -o:'html/texts.ttl'

rm -rf saxon
