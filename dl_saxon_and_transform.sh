#!/bin/bash
echo "downloading saxon"
wget https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12-1J.zip && unzip SaxonHE12-1J.zip -d saxon && rm -rf SaxonHE12-1J.zip

echo "split mentions"
java -jar saxon/saxon-he-12.1.jar -s:'data/indices/mentions.xml' -xsl:'data/xsl/split_mentions.xsl' -o:'rdf/to_remove.xml'
rm -rf rdf/to_remove.xml

echo "transform mentions 1"
java -jar saxon/saxon-he-12.1.jar -s:'data/indices/mentions1.xml' -xsl:'data/xsl/fackel_mentions_rdf.xsl' -o:'rdf/mentions1.ttl'

echo "transform mentions 2"
java -jar saxon/saxon-he-12.1.jar -s:'data/indices/mentions2.xml' -xsl:'data/xsl/fackel_mentions_rdf.xsl' -o:'rdf/mentions2.ttl'

echo "transform fackel rdf"
java -jar saxon/saxon-he-12.1.jar -s:'data/indices/fackelTexts_cascaded.xml' -xsl:'data/xsl/fackel_rdf.xsl' -o:'rdf/texts.ttl'

echo "done"

rm -rf saxon
