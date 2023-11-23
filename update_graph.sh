# bin/bash

echo "delete namedgraphs"
curl -D- -X DELETE \
    "${R_ENDPOINT_V}?c=<https://sk.acdh.oeaw.ac.at/project/fackel>"
sleep 300

echo "upload namedgraphs data.trig"
curl $R_ENDPOINT_V \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/data.trig
sleep 300

echo "namedgraphs texts.trig"
curl $R_ENDPOINT_V \
    -H 'Content-Type: application/x-trig; charset=UTF-8' \
    -H 'Accept: text/boolean' \
    -d @rdf/texts.trig
sleep 300

for i in {1..10}
    do
    echo "namedgraphs mentions${i}.trig"
    curl $R_ENDPOINT_V \
        -H 'Content-Type: application/x-trig; charset=UTF-8' \
        -H 'Accept: text/boolean' \
        -d @rdf/mentions$i.trig
    sleep 300
    done