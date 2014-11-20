
# Fonction multi-tache

#'@usage gds(cH = 40E-9) # 7.39794
#'@usage gds(pH = 7.4)
#'@usage gds(bic=25, pCO2=40) # 7.415873
#'@usage gds(bic=25, pH = 7.4) # 41.48901
#'@usage gds(pCO2 = 40, pH = 7.4) # 24.10277

gds<-function(bic=NA,pCO2=NA,pH=NA,cH=NA){
  if(!is.na(cH)){
    return(-log10(cH))
  }
  if(!is.na(bic)&!is.na(pCO2)){
    return(6.1+log10(bic/(0.0302*pCO2)))
  }
  if(!is.na(bic)&!is.na(pH)){
    return(10^-(pH-6.1-log10(bic))/0.0302)
  }
  if(!is.na(pCO2)&!is.na(pH)){
    return(10^(pH-6.1+log10(0.0302*pCO2)))
  }
  if(!is.na(pH)){
    return(return(10^-pH))
  }
}

# Courbe de Davenport

courbe<-function(){
  ph<-seq(6.8,7.8,0.01)
  n<-1
  bic=1:length(ph)
  for(i in ph){
    bic[n]=gds(pH=i,pCO2=40);
    n=n+1
  }
  plot(ph,bic,type="l",xlab="pH",ylab="Bicarbonates (mmoles/L",main="Diagramme de Davenport")
  text(7.64, 55, "pCO2 = 40 mmHg")

}

# anion.gap

# Calcul simplifié du trou anionique (TA). Par défaut la fonction retourene le TA normal.

anion.gap <- function(na=140, cl=100, bic=24){
  return (na - cl - bic)
}

# balance
#'@source: NEJM
#'@param TA trou anionique (voir anion.gap)
#'@param bic taux de bicarbinates (mmoles/l)

balance <- function(TA = 16, bic = 24){
  return((TA - 12)/(25 - bic))
}

#'@name formule de Winters
#'@description calcule la compensation respiratoire d'une acidose métabolique
#'@param bic taux de bicarbinates (mmoles/l)
#'@return pCO2 théorique (+/- 2 mmHg)
#'
winters <- function(bic = 24){
  return(1.5 * bic + 8)
}