#!/bin/bash
echo "downloading saxon"
wget https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12-1J.zip && unzip SaxonHE12-1J.zip -d saxon && rm -rf SaxonHE12-1J.zip

echo "fixtures in listperson.xml"
java -jar saxon/saxon-he-12.1.jar -s:'data/indices/listperson.xml' -xsl:'data/xsl/fixtures.xsl' -o:'data/indices/listperson.xml'

# echo "split mentions"
# java -jar saxon/saxon-he-12.1.jar -s:'data/indices/mentions.xml' -xsl:'data/xsl/split_mentions.xsl' -o:'rdf/to_remove.xml'
# rm -rf rdf/to_remove.xml

# for i in {1..10}
#     do
#     echo "transform mentions ${i}"
#     java -jar saxon/saxon-he-12.1.jar -s:"data/indices/mentions${i}.xml" -xsl:"data/xsl/fackel_mentions_rdf.xsl" -o:"rdf/mentions${i}.ttl"
#     done

echo "transform fackel rdf"
java -jar saxon/saxon-he-12.1.jar -s:'data/indices/fackelTexts_cascaded.xml' -xsl:'data/xsl/fackel_rdf.xsl' -o:'rdf/texts.ttl'

echo "done"

rm -rf saxon
