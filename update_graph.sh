# bin/bash

echo "delete namedgraphs"
curl -D- -X DELETE \
    -u $R_USER \
    'https://sk-blazegraph.acdh-dev.oeaw.ac.at/blazegraph/sparql?c=<https://sk.acdh.oeaw.ac.at/project/fackel>&c=<https://sk.acdh.oeaw.ac.at/provenance>&c=<https://sk.acdh.oeaw.ac.at/model>&c=<https://sk.acdh.oeaw.ac.at/general>'
sleep 300

echo "upload namedgraphs data.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/data.trig
sleep 600

echo "namedgraphs texts.trig"
curl -u $R_USER \
    $R_ENDPOINT \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/texts.trig
sleep 600

for i in {1..10}
    do
    echo "namedgraphs mentions${i}.trig"
    curl -u $R_USER \
        $R_ENDPOINT \
        -H 'Content-Type: application/x-trig; charset=UTF-8' \
        -H 'Accept: text/boolean' \
        -d @rdf/mentions$i.trig
    sleep 600
    done
