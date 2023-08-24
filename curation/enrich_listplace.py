import pandas as pd
import requests
import lxml.etree as ET
from io import BytesIO
from acdh_tei_pyutils.tei import TeiReader
from AcdhArcheAssets.uri_norm_rules import get_normalized_uri


def gsheet_to_df(sheet_id):
    GDRIVE_BASE_URL = "https://docs.google.com/spreadsheet/ccc?key="
    url = f"{GDRIVE_BASE_URL}{sheet_id}&output=csv"
    r = requests.get(url)
    print(r.status_code)
    data = r.content
    df = pd.read_csv(BytesIO(data))
    return df


sheet_id = "1LRXdIOp4u0Pheb8g_XYIAZpF3VmhsoVd-56xdNOpMvI"

index_file = "data/indices/listplace.xml"
gsheet_to_df(sheet_id).to_csv("places.csv", index=False)
df = pd.read_csv("./places.csv", index_col=0).fillna("")
df = df.astype(str)
doc = TeiReader(index_file)
for bad in doc.any_xpath(".//tei:idno"):
    bad.getparent().remove(bad)
nsmap = doc.nsmap
pmb_url = "https://pmb.acdh.oeaw.ac.at/entity"

for x in doc.any_xpath(".//tei:place"):
    entity_id = x.attrib["{http://www.w3.org/XML/1998/namespace}id"]
    try:
        name = df.loc[entity_id]["name"]
    except KeyError:
        continue
    try:
        pmb_id = int(df.loc[entity_id]["pmb_id"].split(",")[0])
    except:
        pmb_id = False
    if pmb_id:
        idno = ET.Element("{http://www.tei-c.org/ns/1.0}idno")
        idno.attrib["type"] = "URL"
        idno.attrib["subtype"] = "pmb"
        idno.text = f"{pmb_url}/{pmb_id}".strip()
        x.append(idno)
    geonames_df_value = df.loc[entity_id]["geonames"]
    if "geonames" in geonames_df_value:
        geonames_url = get_normalized_uri(geonames_df_value)
        idno = ET.Element("{http://www.tei-c.org/ns/1.0}idno")
        idno.attrib["type"] = "URL"
        idno.attrib["subtype"] = "geonames"
        idno.text = geonames_url
        x.append(idno)
    if "gnd" in geonames_df_value:
        geonames_url = get_normalized_uri(geonames_df_value)
        idno = ET.Element("{http://www.tei-c.org/ns/1.0}idno")
        idno.attrib["type"] = "URL"
        idno.attrib["subtype"] = "gnd"
        idno.text = geonames_url
        x.append(idno)

doc.tree_to_file(index_file)
