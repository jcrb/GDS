Gaz du sang (GDS)
========================================================

log = logarithme népérien
log10 = log(x,10) = logarithme décimal

On appelle pH le -log10[H+] = log10[1/H+]


```r
pH1 <- function(x) {
    return(-log10(x))
}
pH1(4e-08)
```

```
## [1] 7.398
```

```r

cH <- function(pH) {
    return(10^-pH)
}
cH(7.39794)
```

```
## [1] 4e-08
```

Equation de Henderson-Hasselbalch

pH = 6.1 + log10(bicar)/(0.302 * pCO2)


```r
pH <- function(bic = 0, pCO2 = 0, cH = 0) {
    if (cH != 0) {
        return(-log10(cH))
    } else {
        if (bic == 0) 
            stop("il manque les bicarbonates")
        if (pCO2 == 0) 
            stop("il manque la pCO2")
        return(6.1 + log10(bic/(0.0302 * pCO2)))
    }
}

pH(25, 40)
```

```
## [1] 7.416
```

```r
pH(cH = 4e-08)
```

```
## [1] 7.398
```

```r
pH(10, 20)
```

```
## [1] 7.319
```

Fonction multi-tache

```r
gds <- function(bic = NA, pCO2 = NA, pH = NA, cH = NA) {
    if (!is.na(cH)) {
        return(-log10(cH))
    }
    if (!is.na(bic) & !is.na(pCO2)) {
        return(6.1 + log10(bic/(0.0302 * pCO2)))
    }
    if (!is.na(bic) & !is.na(pH)) {
        return(10^-(pH - 6.1 - log10(bic))/0.0302)
    }
    if (!is.na(pCO2) & !is.na(pH)) {
        return(10^(pH - 6.1 + log10(0.0302 * pCO2)))
    }
    if (!is.na(pH)) {
        return(return(10^-pH))
    }
}

gds(25, 40)
```

```
## [1] 7.416
```

```r
gds(pH = 7.42)
```

```
## [1] 3.802e-08
```

```r
gds(pH = 7.42, bic = 25)
```

```
## [1] 39.62
```

```r
gds(pH = 7.42, pCO2 = 40)
```

```
## [1] 25.24
```

```r
gds(cH = 4e-08)
```

```
## [1] 7.398
```

Courbe

```r
ph <- seq(6.8, 7.8, 0.01)
n <- 1
bic = 1:length(ph)
for (i in ph) {
    bic[n] = gds(pH = i, pCO2 = 40)
    n = n + 1
}
plot(ph, bic, type = "l", xlab = "pH", ylab = "Bicarbonates (mmoles/L", main = "Diagramme de Davenport")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

Troubles hydro-electrolytiques
==============================

soluté de réhydratation de l'OMS
--------------------------------
- glucose: 75 mmol soit 75 * 180 / 1000 = 13.5g
- sodium: 75 soit 140 mmlo de nacl soit 58.5 * 140 / 1000 = 8.2 g
- chlore: 65
- potassium: 20
- citrate: 10
soit au total 250 mosm/L

fabrication approchée:
- 2.5 morceaux de sucre soit 12.5g soit 12.5/180 = 0.0695 mole ou environ 70 mosm
- 1 cu à café de sel (1 cu café de sel = 5g) 5g/58.5g = 0.085 mmol de nacl qui donne 170 mosm de substances dissoutes (na + cl)
- l'ensemble fait 170 + 70 = 240 mosm

situation: deshydratation globale  
mécanisme: perte d'eau et de sel où la perte d'eau > perte de sel
cas clinique: Nourisson de 9 mois avec diarrhées profuses


http://weather.noaa.gov/pub/data/observations/metar/stations/LFST.TXT

archives METAR: 
- http://www.ogimet.com/metars.phtml.en (depuis 2005)
- http://www.navlost.eu/aero/metar/?icao=LFST&dt0=2013-01-01&c=365&rt=metar

traduction d'un metar: http://www.metarreader.com/

Syndrome des buveurs de bière
-----------------------------
ref: le syndrome des buveurs de bière. Ory J.P. et coll. Le concours médeical 1984-06-16 pp2271

H 50 ans amené par ambulance pour crise convulsive inaugurale. Homme de 50 ans, confus, présentant un tremblement au repos. Connu pour être un buveur de bière (plus de 5 litres par jour). En dehors d'une hépatomégalie, l'examen clinique est normal. 
temp: 36°C
PA: 120/70
fc: 90
Une gazométrie et un ionogramme sont prélevés:
- sodium: 110 mmoles/L
- potassium: 2,5 mmols/L
- chlore: 90 mmoles/L
- glycémie: 5,5 mmoles/L

- pH: 7,5
- bic: 30

```r
pCO2 <- gds(pH = 7.5, bic = 30)
pCO2
```

```
## [1] 39.55
```

Hyperhydratation intracellulaire et hydratation extracellulaire normale:  
C'est une augmentation du volume intracellulaire due à un mouvement d'eau de compartiment extracellulire vers les cellules du fait d'une diminution initiale de la pression osmotique extracellulaire.  
Sur le plan biologique:
- osmolarité extra-cellulaire < 280 mosm/L
- hyponatrémie < 135 mmloles/L
signes cliniques:
- dégout de l'eau, nausées puis vomissements (perte d'acide)
- sillon linguo-gingival rest humide
- signes neuro-psy sont les plus caractéristiques:
  - subresauts musculaires, crampes
  - torpeur, confusion, délire, agitation, coma (Na<115)
Mécanisme: perte d'eau et de Na mais soit la perte de Na > perte d'eau (deshydratation extra-cellulaire associée), soit la perte d'eau est compensée (buveur de bière)
Traitement:
- restriction hydrique
