from acdh_tei_pyutils.tei import TeiReader
from AcdhArcheAssets.uri_norm_rules import get_norm_id

file = "./data/indices/listperson.xml"
doc = TeiReader(file)

# lookup_dict = {
#     "WikData": "WikiData",
#     "WikiData": "WikiData",
#     "sonstiges": "sonstiges",
#     "WkiData": "WikiData",
#     "WIkiData": "WikiData",
#     "PMB": "PMB",
#     "VIAF": "VIAF",
#     "GND": "GND",
#     "URI": "URI",
#     "GDN": "GND",
# }

# idno_values = set()
# for x in doc.any_xpath(".//tei:idno[@type]"):
#     cur_val = x.attrib["type"]
#     new_val = lookup_dict[cur_val]
#     x.attrib["type"] = new_val
# doc.tree_to_file(file)


for x in doc.any_xpath(".//tei:idno[@type='GND' or @type='WikiData']"):
    cur_val = x.text
    if cur_val.startswith("http"):
        new_val = get_norm_id(cur_val)
        print(cur_val, new_val)
        x.text = new_val
doc.tree_to_file(file)
