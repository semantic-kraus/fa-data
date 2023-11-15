from acdh_tei_pyutils.tei import TeiReader

file = "./data/indices/listperson.xml"
doc = TeiReader(file)

lookup_dict = {
    "WikData": "WikiData",
    "WikiData": "WikiData",
    "sonstiges": "sonstiges",
    "WkiData": "WikiData",
    "WIkiData": "WikiData",
    "PMB": "PMB",
    "VIAF": "VIAF",
    "GND": "GND",
    "URI": "URI",
    "GDN": "GND",
}

idno_values = set()
for x in doc.any_xpath(".//tei:idno[@type]"):
    cur_val = x.attrib["type"]
    new_val = lookup_dict[cur_val]
    x.attrib["type"] = new_val
doc.tree_to_file(file)