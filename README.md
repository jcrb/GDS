GDS
===

Routines pour explorer les troubles hydro-électrolytiques et acido-basiques avec R.

Dossier source: /home/jcb/Documents/Cours 2014/Brumath/IFSI Brumath/GDS

Transformer .md en .pdf
-----------------------
FILE<-"cas cliniques"
system(paste("pandoc -o ", FILE, ".pdf ", FILE, ".md", sep=""))

Présentation
------------

source: EqulbreAB.Rpres

La version EquilbreAB.md peut être transformée en PDF:
- changer _author_ en _auteur_
- les images imprtées doivent être au format .png (svg non supporté)

Permet d'avoir une version PDF de bonne qualité du diaporama.

FILE<-"EqulibreAB"
system(paste("pandoc -o ", FILE, ".pdf ", FILE, ".md", sep=""))

Une dernière remarque: si une présentation fait usage de __MathJax__ pour les équations LaTeX, alors les fichiers requis par MathJax sont copiés dans un dossier qui doit être distribué avec le fichier présentation HTML. Par exemple, si la présentation est nommée __MyPresentation.html__ alors le répertoire __MyPresentation_files__ contient les fichiers de support MathJax.

Eléments de présentation à emporter (2015)
------------------------------------------

- EqulibreAB_2015_files
- EqulibreAB_2015.html
- EqulibreAB.pdf
- cas_cliniques.pdf

Physiologie de l'eau
--------------------

Contient les formules de calcul pour le diagramme de Darrow.