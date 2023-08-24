from acdh_tei_pyutils.tei import TeiReader


index_file = "./data/indices/listperson.xml"
break_id = "p_46555"
# see https://github.com/semantic-kraus/fa-data/commit/e279e4ad182c14e15a03825ed3e32e1d327614e5

doc = TeiReader(index_file)
nsmap = doc.nsmap

for x in doc.any_xpath(".//tei:listPerson/tei:person[@xml:id]"):
    entity_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    x.attrib["status"] = "todo"

for x in doc.any_xpath(".//tei:listPerson/tei:person[@xml:id]"):
    entity_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    x.attrib["status"] = "checked"
    if entity_id == break_id:
        break

for x in doc.any_xpath(".//tei:listPerson/tei:person[@status='todo']"):
    if x.xpath('./tei:idno[@type="GND" or @type="WikiData"]', namespaces=nsmap):
        entity_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
        x.attrib["status"] = "checked"

doc.tree_to_file(index_file)
