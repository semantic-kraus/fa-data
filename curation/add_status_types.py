from acdh_tei_pyutils.tei import TeiReader


index_file = "./data/indices/listperson.xml"
break_id = "p_46270" # matches line nr. 95876, see https://github.com/semantic-kraus/fa-data/commit/64f154275403317bb040e3166d1dd3f8389dc1b6

doc = TeiReader(index_file)

for x in doc.any_xpath(".//tei:listPerson/tei:person[@xml:id]"):
    entity_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    if entity_id == break_id:
        x.attrib["status"] = "checked"
    else:
        x.attrib["status"] = "todo"
doc.tree_to_file(index_file)