import os
from tqdm import tqdm
from acdh_cidoc_pyutils import (
    make_appellations,
    make_e42_identifiers,
    make_birth_death_entities,
    make_occupations,
    make_entity_label,
)
from utils.utilities import (
    make_e42_identifiers_utils,
    create_triple_from_node,
    create_birth_death_settlement_graph
)
from acdh_cidoc_pyutils.namespaces import CIDOC, FRBROO
from acdh_tei_pyutils.tei import TeiReader
from rdflib import Graph, Namespace, URIRef, plugin, ConjunctiveGraph
from rdflib.namespace import RDF
from rdflib.store import Store


FA = Namespace("https://sk.acdh.oeaw.ac.at/project/fackel")

store = plugin.get("Memory", Store)()
project_store = plugin.get("Memory", Store)()

if os.environ.get("NO_LIMIT"):
    LIMIT = False
    print("no limit")
else:
    LIMIT = 100

rdf_dir = "./rdf"
os.makedirs(rdf_dir, exist_ok=True)
domain = "https://sk.acdh.oeaw.ac.at/"
SK = Namespace(domain)

project_uri = URIRef(f"{SK}project/fackel")
g = Graph(identifier=project_uri, store=project_store)
g.bind("cidoc", CIDOC)
g.bind("frbroo", FRBROO)
g.bind("sk", SK)

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
    name_node = x.xpath(".//tei:persName", namespaces=nsmap)
    item_label = make_entity_label(name_node[0])[0]
    g.add((subj, RDF.type, CIDOC["E21_Person"]))
    g += make_e42_identifiers(subj, x, type_domain=f"{SK}types", default_lang="und", same_as=False)
    # g += make_appellations(subj, x, type_domain=f"{SK}types", default_lang="und")
    # create appellations
    g += create_triple_from_node(
        node=x,
        subj=subj,
        subj_suffix="appellation",
        pred=CIDOC["P2_has_type"],
        sbj_class=CIDOC["E33_E41_Linguistic_Appellation"],
        obj_class=CIDOC["E55_Type"],
        obj_node_xpath="./tei:persName",
        obj_node_value_xpath="./@type",
        obj_node_value_alt_xpath_or_str="pref",
        obj_prefix=f"{SK}types",
        default_lang="und",
        value_literal=True,
        identifier=CIDOC["P1_is_identified_by"]
    )
    # add additional type for appellations
    g += create_triple_from_node(
        node=x,
        subj=subj,
        subj_suffix="appellation",
        pred=CIDOC["P2_has_type"],
        obj_class=CIDOC["P2_has_type"],
        obj_node_xpath="./tei:persName",
        obj_node_value_xpath="./@sex",
        obj_node_value_alt_xpath_or_str="./parent::tei:person/tei:sex/@value",
        obj_prefix=f"{SK}types",
        skip_value="not-set"
    )
    # g += make_occupations(subj, x, default_lang="de")[0]
    # add occupations
    g += create_triple_from_node(
        node=x,
        subj=subj,
        subj_suffix="occupation",
        pred=CIDOC["None"],
        sbj_class=FRBROO["F51_Pursuit"],
        obj_node_xpath="./tei:occupation",
        obj_process_condition="./@type='sk'",
        default_lang="en",
        label_prefix="works for: ",
        identifier=CIDOC["P14i_performed"]
    )
    # create birth and death
    if x.xpath("./tei:birth", namespaces=nsmap):
        try:
            date_node = x.xpath("./tei:birth/tei:date[@type]", namespaces=nsmap)[0]
        except IndexError:
            date_node = None
        if date_node is not None:
            date_type = date_node.attrib["type"]
            if date_type == "approx":
                date_type_uri = URIRef(f"{SK}types/date/{date_type}")
        else:
            date_type_uri = False
        birth_g, birth_uri, birth_timestamp = make_birth_death_entities(
            subj,
            x,
            domain=SK,
            event_type="birth",
            type_uri=date_type_uri,
            verbose=False,
            default_prefix="Birth of",
            default_lang="en",
            date_node_xpath="/self::tei:birth",
            place_id_xpath="//tei:settlement[1]/@key",
        )
        g += birth_g
    if x.xpath("./tei:birth[./tei:settlement]", namespaces=nsmap):
        try:
            birth_place_node = x.xpath(
                "./tei:birth/tei:settlement", namespaces=nsmap
            )[0]
        except IndexError:
            birth_place_node = None
        if birth_place_node is not None:
            g += create_birth_death_settlement_graph(
                node=birth_place_node,
                namespaces=nsmap,
                uri_prefix=SK,
                node_attrib="key"
            )
    if x.xpath("./tei:death", namespaces=nsmap):
        try:
            date_node = x.xpath("./tei:death/tei:date[@type]", namespaces=nsmap)[0]
        except IndexError:
            date_node = None
        if date_node is not None:
            date_type = date_node.attrib["type"]
            if date_type == "approx":
                date_type_uri = URIRef(f"{SK}types/date/{date_type}")
        else:
            date_type_uri = False
        death_g, death_uri, death_timestamp = make_birth_death_entities(
            subj,
            x,
            domain=SK,
            event_type="death",
            type_uri=date_type_uri,
            verbose=False,
            default_prefix="Death of",
            default_lang="en",
            date_node_xpath="/tei:date[1]",
            place_id_xpath="//tei:settlement[1]/@key",
        )
        g += death_g
    if x.xpath("./tei:death[./tei:settlement]", namespaces=nsmap):
        try:
            death_place_node = x.xpath(
                "./tei:death/tei:settlement", namespaces=nsmap
            )[0]
        except IndexError:
            death_place_node = None
        if death_place_node is not None:
            g += create_birth_death_settlement_graph(
                node=death_place_node,
                namespaces=nsmap,
                uri_prefix=SK,
                node_attrib="key"
            )
    # birth_g, birth_uri, birth_timestamp = make_birth_death_entities(
    #     subj,
    #     x,
    #     domain=SK,
    #     event_type="birth",
    #     verbose=True,
    #     place_id_xpath="//tei:placeName/@key",
    # )
    # if bool(birth_uri and birth_timestamp):
    #     g += birth_g
    # death_g, death_uri, death_timestamp = make_birth_death_entities(
    #     subj,
    #     x,
    #     domain=SK,
    #     event_type="death",
    #     default_prefix="Tod von",
    #     verbose=True,
    #     place_id_xpath="//tei:placeName/@key",
    # )
    # if bool(death_uri and death_timestamp):
    #     g += death_g

# entity_type = "place"
# index_file = f"./data/indices/list{entity_type}.xml"
# doc = TeiReader(index_file)
# nsmap = doc.nsmap
# items = doc.any_xpath(f".//tei:{entity_type}")
# if LIMIT:
#     items = items[:LIMIT]

# print(f"converting {entity_type}s derived from {index_file}")
# for x in tqdm(items, total=len(items)):
#     xml_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
#     item_id = f"{SK}{xml_id}"
#     subj = URIRef(item_id)
#     g.add((subj, RDF.type, CIDOC["E53_Place"]))
#     g += make_e42_identifiers(subj, x, type_domain=f"{SK}types", default_lang="und", same_as=False)
#     g += make_appellations(subj, x, type_domain=f"{SK}types", default_lang="und")

g_all = ConjunctiveGraph(store=project_store)
g_all.serialize(f"{rdf_dir}/data.trig", format="trig")
g_all.serialize(f"{rdf_dir}/data.ttl", format="ttl")
