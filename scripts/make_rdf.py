import os
from tqdm import tqdm
from acdh_cidoc_pyutils import (
    make_appellations,
    make_e42_identifiers,
    make_birth_death_entities,
    make_occupations,
    make_entity_label,
)
from acdh_cidoc_pyutils.namespaces import CIDOC
from acdh_tei_pyutils.tei import TeiReader
from rdflib import Graph, Namespace, URIRef
from rdflib.namespace import RDF

if os.environ.get("NO_LIMIT"):
    LIMIT = False
else:
    LIMIT = 100

rdf_dir = "./rdf"
os.makedirs(rdf_dir, exist_ok=True)
domain = "https://sk.acdh.oeaw.ac.at/"
SK = Namespace(domain)
g = Graph()
entity_type = "person"
index_file = f"./data/indices/list{entity_type}.xml"
doc = TeiReader(index_file)
nsmap = doc.nsmap
items = doc.any_xpath(f".//tei:{entity_type}")
if LIMIT:
    items = items[:LIMIT]
print(f"converting {entity_type}s derived from {index_file}")
for x in tqdm(items, total=len(items)):
    xml_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    item_id = f"{SK}{xml_id}"
    subj = URIRef(item_id)
    name_node = x.xpath(".//tei:persName", namespaces=nsmap)[0]
    item_label = make_entity_label(name_node)[0]
    g.add((subj, RDF.type, CIDOC["E21_Person"]))
    g += make_e42_identifiers(subj, x, type_domain=f"{SK}types", default_lang="und", same_as=False)
    g += make_appellations(subj, x, type_domain=f"{SK}types", default_lang="und")
    g += make_occupations(subj, x, default_lang="de")[0]
    birth_g, birth_uri, birth_timestamp = make_birth_death_entities(
        subj,
        x,
        domain=SK,
        event_type="birth",
        verbose=True,
        place_id_xpath="//tei:placeName/@key",
    )
    if bool(birth_uri and birth_timestamp):
        g += birth_g
    death_g, death_uri, death_timestamp = make_birth_death_entities(
        subj,
        x,
        domain=SK,
        event_type="death",
        default_prefix="Tod von",
        verbose=True,
        place_id_xpath="//tei:placeName/@key",
    )
    if bool(death_uri and death_timestamp):
        g += death_g

entity_type = "place"
index_file = f"./data/indices/list{entity_type}.xml"
doc = TeiReader(index_file)
nsmap = doc.nsmap
items = doc.any_xpath(f".//tei:{entity_type}")
if LIMIT:
    items = items[:LIMIT]
print(f"converting {entity_type}s derived from {index_file}")
for x in tqdm(items, total=len(items)):
    xml_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    item_id = f"{SK}{xml_id}"
    subj = URIRef(item_id)
    g.add((subj, RDF.type, CIDOC["E53_Place"]))
    g += make_e42_identifiers(subj, x, type_domain=f"{SK}types", default_lang="und", same_as=False)
    g += make_appellations(subj, x, type_domain=f"{SK}types", default_lang="und")
g.serialize(f"{rdf_dir}/data.ttl")
