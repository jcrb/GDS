
# Degré Kelvin
Tk <- function(t){
  return(t + 273.15)
}

# Constante de dissociation de l'eau PURE
#'@name kw
#'@references Stewart p.50
#'@param t température en degrés Kelvin
#'@return constante de dissociation de l'eau à la température donnée. 
#'        par défaut retourne kw à 37°C
#'@usage kw(37) # 2.411211e-14
#'
kw <- function(t = 37){
  t <- Tk(t)
  return(8.754 * 10^-10 * exp(-1.01 * 10^6 / (t * t)))
}

# Calcul du pH à partir de la [H+]
#'@name pH
#'@usage pH(sqrt(kw(37))) # pH de l'eau pure à 37° =  6.808882

pH <- function(h){
  return(-log10(h))
}

# Calcul du SID normal = Na - Cl = 40 meq = 0.04 eq/l

sid <- function(){
  
}

# A REVOIR BOUCLE INFINIE
#------------------------
# calcul de la [h+] à  partir du SID, 
#'@references Stewart p 50
#'@param akw constante de dissociation du plasma à 37°C
#'@param aka constante de dissociation des acides faibles
#'@param atot acidité totale du plasma
#'
eq_5A11 <- function(asid = 40, akw = 4.4e-14, aka = 2e-7, atot = 0.02){
  # set value par défaut de H-
  hi <- 1.0
  ho <- 4.4e-14
  crit <- 1e-6
  fh <- 1
  
  while(abs(fh) > crit){
    h <- sqrt(hi * ho)
    oh <- akw / h
    a <- aka * atot / (aka + h)
    fh <- asid + h -oh -a
    if( fh > 0) hi = h
    else lo = h
    print(fh)
  }
  
  return(h)
}