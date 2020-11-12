import os,sys
import sqlite3
import sqlalchemy as sa
import rdflib as rdf

from rdflib import Graph, Literal, RDF
from rdflib.namespace import XSD, SKOS, OWL

nameFile= "snds_2235.db"

engine = sa.create_engine("sqlite:///"+os.path.join(os.getcwd(),nameFile))

connection = engine.connect()
metadata = sa.MetaData()
IR_NAT_V = sa.Table('IR_NAT_V', metadata, autoload=True, autoload_with=engine)

# inialisation graphe
graph = rdf.Graph()
# Création du namespace
irNat = rdf.Namespace('http://snds.fr/irnat#')
# Ajout des préfixes
graph.bind("owl", OWL)
graph.bind("skos", SKOS)
graph.bind("irnat", irNat)

#parcourir la table IR_NAT_V
query = sa.select([IR_NAT_V])
ResultProxy = connection.execute(query)

#Parcourir 50 lignes par 50 lignes pour eviter la surcharge mémoire
while True:
    chunk = ResultProxy.fetchmany(50)
    if not chunk:
        break
    for row in chunk:
        #Creer une classe par id PRS_NAT et ajout attribut libellé
        prsNat = irNat[str(row["PRS_NAT"])]
        graph.add((prsNat, RDF.type, OWL.Class))
        graph.add((prsNat, SKOS.notation, Literal(row["PRS_NAT"], datatype=XSD.int)))
        graph.add((prsNat, SKOS.prefLabel, Literal(row["PRS_NAT_LIB"], datatype=XSD.string)))

ResultProxy.close()

#Export fichier RDF en .ttl
graph.serialize(destination="export.ttl", format="turtle")