######################################################################
##Mplus Data Setup 
######################################################################
h <- read.csv("~/Documents/Datasets/HILDA09/Cleaned/hildaItems.csv",header=FALSE,na.strings="-9")
names(h) <- hildaItemsNames

###Parcels for CFA
source("lib/parcels.r")
finalE <- c(eItems[c(-2,-7)],eItems9[c(-2,-7)])
finalA <- c(aItems[c(-2,-5,-7)],aItems9[c(-2,-5,-7)])
finalC <- c(cItems[-7],cItems9[-7])
finalN <- c(nItems[-7],nItems9[-7])
finalO <- c(oItems[-7],oItems9[-7])

eParcels <- cbind(h$id,h$hid,h$weight,h$agecat5,parcel(h[,finalE],6,2,c(2,2,2)))
aParcels <- cbind(h$id,h$hid,h$weight,h$agecat5,parcel(h[,finalA],4,2,c(2,1,1)))
cParcels <- cbind(h$id,h$hid,h$weight,h$agecat5,parcel(h[,finalC],6,2,c(2,2,2)))
nParcels <- cbind(h$id,h$hid,h$weight,h$agecat5,parcel(h[,finalN],6,2,c(2,2,2)))
oParcels <- cbind(h$id,h$hid,h$weight,h$agecat5,parcel(h[,finalO],6,2,c(2,2,2)))

prepareMplusData(eParcels,"~/Documents/Datasets/HILDA09/Cleaned/eParcels.dat")
prepareMplusData(aParcels,"~/Documents/Datasets/HILDA09/Cleaned/aParcels.dat")
prepareMplusData(cParcels,"~/Documents/Datasets/HILDA09/Cleaned/cParcels.dat")
prepareMplusData(nParcels,"~/Documents/Datasets/HILDA09/Cleaned/nParcels.dat")
prepareMplusData(oParcels,"~/Documents/Datasets/HILDA09/Cleaned/oParcels.dat")
