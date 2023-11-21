from acdh_cidoc_pyutils.namespaces import CIDOC, FRBROO
from rdflib import Graph, Namespace, URIRef, plugin, ConjunctiveGraph
from rdflib.store import Store
import glob


domain = "https://sk.acdh.oeaw.ac.at/"
SK = Namespace(domain)
FA = Namespace("https://sk.acdh.oeaw.ac.at/project/fackel")
project_uri = URIRef(f"{FA}")

store = plugin.get("Memory", Store)()
project_store = plugin.get("Memory", Store)()

g = Graph(identifier=project_uri, store=project_store)
g.bind("cidoc", CIDOC)
g.bind("frbroo", FRBROO)
g.bind("sk", SK)
g.bind("fa", FA)

try:
    g.parse("./rdf/texts.ttl")
except Exception as e:
    print(e)

g_all = ConjunctiveGraph(store=project_store)
g_all.serialize("./rdf/texts.trig", format="trig")

mentions = glob.glob("./rdf/mentions*.ttl")

for x in mentions:
    store = plugin.get("Memory", Store)()
    project_store = plugin.get("Memory", Store)()

    g = Graph(identifier=project_uri, store=project_store)
    g.bind("cidoc", CIDOC)
    g.bind("frbroo", FRBROO)
    g.bind("sk", SK)
    g.bind("fa", FA)
    try:
        g.parse(x)
    except Exception as e:
        print(e)
    filepath = x.replace(".ttl", ".trig")
    g_all = ConjunctiveGraph(store=project_store)
    g_all.serialize(filepath, format="trig")
