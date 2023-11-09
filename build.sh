# bin/bash

rm -rf html
mkdir html
touch html/.nojekyll

python scripts/make_rdf.py