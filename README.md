GDS
===

Routines pour explorer les troubles hydro-électrolytiques et acido-basiques avec R

Transformer .md en .pdf
-----------------------
FILE<-"cas cliniques"
system(paste("pandoc -o ", FILE, ".pdf ", FILE, ".md", sep=""))

Présentation
------------

source: EqulbreAB.Rpres

La version EqulbreAB.md peut être transformée en PDF:
- changer _author_ en _auteur_
- les images imprtées doivent être au format .png (svg non supporté)

Permet d'avoir une version PDF de bonne qualité du diaporama.
