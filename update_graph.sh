# bin/bash

echo "delete namedgraphs"
curl -D- -X DELETE \
    "${R_ENDPOINT_V}?c=<https://sk.acdh.oeaw.ac.at/project/fackel>"
sleep 300

echo "upload namedgraphs data.ttl"
curl "${R_ENDPOINT_V}?context-uri=https://sk.acdh.oeaw.ac.at/project/fackel" \
    -H 'Content-Type: application/x-turtle; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/data.ttl
sleep 300

echo "namedgraphs texts.ttl"
curl "${R_ENDPOINT_V}?context-uri=https://sk.acdh.oeaw.ac.at/project/fackel" \
    -H 'Content-Type: application/x-turtle; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/texts.ttl
sleep 300

for i in {1..10}
    do
    echo "namedgraphs mentions${i}.ttl"
    curl "${R_ENDPOINT_V}?context-uri=https://sk.acdh.oeaw.ac.at/project/fackel" \
        -H 'Content-Type: application/x-turtle; charset=UTF-8' \
        -H 'Accept: text/boolean' \
        -d @rdf/mentions$i.ttl
    sleep 300
    done