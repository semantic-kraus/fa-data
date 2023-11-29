# bin/bash

echo "delete namedgraphs"
curl -D- -X DELETE "${R_ENDPOINT_V}?c=<https://sk.acdh.oeaw.ac.at/project/fackel>"
sleep 300

echo "upload namedgraphs data.trig"
curl -D- -H 'Content-Type: application/x-turtle; charset=UTF-8' \
    -d @rdf/data.trig \
    -X POST $R_ENDPOINT_V
sleep 300

echo "namedgraphs texts.trig"
curl -D- -H 'Content-Type: application/x-turtle; charset=UTF-8' \
    -d @rdf/texts.trig \
    -X POST $R_ENDPOINT_V
sleep 300

for i in {1..10}
    do
    echo "namedgraphs mentions${i}.trig"
    curl -D- -H 'Content-Type: application/x-turtle; charset=UTF-8' \
        -d @rdf/mentions$i.trig \
        -X POST $R_ENDPOINT_V
    sleep 300
    done