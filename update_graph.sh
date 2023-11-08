# bin/bash

echo "delete namedgraphs"
curl -D- -X DELETE \
    -u $R_USER \
    'https://sk-blazegraph.acdh-dev.oeaw.ac.at/blazegraph/sparql?c=<https://sk.acdh.oeaw.ac.at/project/fackel>&c=<https://sk.acdh.oeaw.ac.at/provenance>&c=<https://sk.acdh.oeaw.ac.at/model>&c=<https://sk.acdh.oeaw.ac.at/general>'
sleep 60

echo "upload namedgraphs data.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/data.trig
sleep 60

echo "namedgraphs texts.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/texts.trig
sleep 60

echo "namedgraphs mentions1.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/mentions1.trig
sleep 60

echo "namedgraphs mentions2.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/mentions2.trig
sleep 60

echo "namedgraphs mentions3.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/mentions3.trig