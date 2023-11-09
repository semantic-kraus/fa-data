# bin/bash

python scripts/make_index.py
cp rdf/*.ttl html/
cp rdf/*.trig html/
cd html
zip -r mentions.zip mentions*
rm mentions*.t*