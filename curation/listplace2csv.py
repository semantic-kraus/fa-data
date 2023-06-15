import pandas as pd
from acdh_tei_pyutils.tei import TeiReader


doc = TeiReader("./data/indices/listplace.xml")

data = []
for x in doc.any_xpath(".//tei:place[@xml:id]"):
    item = {}
    item["id"] = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    item["checked"] = ""
    full_name = x.xpath("./tei:placeName/text()", namespaces=doc.nsmap)[0]
    full_name = full_name.replace('"', '')
    if "/" in full_name:
        parts = full_name.split("/")
        name = parts[0]
        region = "; ".join(parts[1:])
    elif ", " in full_name:
        parts = full_name.split(", ")
        name = parts[0]
        region = "; ".join(parts[1:])
    else:
        name, region = full_name, ""
    item["name"] = name
    item["region"] = region
    data.append(item)

df = pd.DataFrame(data)
df.to_csv("places.csv", index=False)
