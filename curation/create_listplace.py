import lxml.etree as ET
from acdh_tei_pyutils.tei import TeiReader

stub = """<TEI xmlns="http://www.tei-c.org/ns/1.0"><listPlace></listPlace></TEI>"""
index_file = "./data/indices/listperson.xml"
out_file = "./data/indices/listplace.xml"
new_doc = TeiReader(stub)
list_place_node = new_doc.any_xpath('./tei:listPlace')[0]
doc = TeiReader(index_file)
print("lets create some place keys")
place_names = set()
for x in doc.any_xpath('.//tei:person//tei:placeName'):
    place_names.add(x.text)
place_names = list(place_names)

done = set()
for x in doc.any_xpath('.//tei:person//tei:placeName'):
    n = place_names.index(x.text)
    place_name_id = f"fa_place{n:05}"
    x.attrib["key"] = f"#{place_name_id}"
    if x.text in done:

        continue
    else:
        done.add(x.text)
        pl_node = ET.Element("{http://www.tei-c.org/ns/1.0}place")
        pl_node.attrib["{http://www.w3.org/XML/1998/namespace}id"] = place_name_id
        pl_name_node = ET.Element("{http://www.tei-c.org/ns/1.0}placeName")
        pl_name_node.text = x.text
        pl_node.append(pl_name_node)
        list_place_node.append(pl_node)
doc.tree_to_file(index_file)
new_doc.tree_to_file(out_file)
