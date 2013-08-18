Gaz du sang (GDS)
========================================================

Transformer .md en .pdf
-----------------------
FILE<-"cas cliniques"
system(paste("pandoc -o ", FILE, ".pdf ", FILE, ".md", sep=""))

Initialisation
--------------

```r
source("gds.R")
```



Généralités
-----------
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

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 



http://weather.noaa.gov/pub/data/observations/metar/stations/LFST.TXT

archives METAR: 
- http://www.ogimet.com/metars.phtml.en (depuis 2005)
- http://www.navlost.eu/aero/metar/?icao=LFST&dt0=2013-01-01&c=365&rt=metar

traduction d'un metar: http://www.metarreader.com/

