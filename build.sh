rm -rf html
mkdir html
touch html/.nojekyll

python scripts/make_rdf.py
# python scripts/make_texts.py
# python scripts/make_listwork.py

python scripts/make_index.py
cp rdf/*.ttl html/