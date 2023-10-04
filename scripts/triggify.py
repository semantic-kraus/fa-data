from acdh_cidoc_pyutils.namespaces import CIDOC, FRBROO
from rdflib import Graph, Namespace, URIRef, plugin, ConjunctiveGraph
from rdflib.namespace import VOID, DCTERMS
from rdflib.store import Store


domain = "https://sk.acdh.oeaw.ac.at/"
SK = Namespace(domain)
FA = Namespace("https://sk.acdh.oeaw.ac.at/project/fackel")

store = plugin.get("Memory", Store)()
project_store = plugin.get("Memory", Store)()

project_uri = URIRef(f"{FA}")

g = Graph(identifier=project_uri, store=project_store)
g.bind("cidoc", CIDOC)
g.bind("frbroo", FRBROO)
g.bind("sk", SK)
g.bind("fa", FA)

try:
    g.parse("./html/texts.ttl")
except Exception as e:
    print(e)

g_all = ConjunctiveGraph(store=project_store)
g_all.serialize("./html/texts.trig", format="trig")

store = plugin.get("Memory", Store)()
project_store = plugin.get("Memory", Store)()

project_uri = URIRef(f"{DW}")

g = Graph(identifier=project_uri, store=project_store)
g.bind("cidoc", CIDOC)
g.bind("frbroo", FRBROO)
g.bind("sk", SK)
g.bind("dw", DW)

try:
    g.parse("./html/mentions.ttl")
except Exception as e:
    print(e)

g_all = ConjunctiveGraph(store=project_store)
g_all.serialize("./html/mentions.trig", format="trig")
