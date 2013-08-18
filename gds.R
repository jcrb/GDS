
# Fonction multi-tache

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

# Courbe

courbe<-function(){
  ph<-seq(6.8,7.8,0.01)
  n<-1
  bic=1:length(ph)
  for(i in ph){
    bic[n]=gds(pH=i,pCO2=40);
    n=n+1
  }
  plot(ph,bic,type="l",xlab="pH",ylab="Bicarbonates (mmoles/L",main="Diagramme de Davenport")
}

