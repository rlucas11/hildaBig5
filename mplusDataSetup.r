######################################################################
##Mplus Data Setup 
######################################################################
h <- read.csv("~/Documents/Datasets/HILDA09/Cleaned/hildaItems.csv",header=FALSE,na.strings="-9")
## hildaItemNames <- c(c("id","hid","age05",
##                       paste(c("y05e","y05a","y05c","y05n","y05o"),
##                             rep(1:7,each=5),sep=""),"y05e8","weight"),
##                     c("age09",paste(c("y09e","y09a","y09c","y09n","y09o"),
##                                     rep(1:7,each=5),sep=""),"y09e8"),
##                     c("female","agecat","agecat2","agecat5","agecat5b","ageSexCat"))

hildaItems <- c(eItems[c(-2,-7)],aItems[c(-2,-5,-7)],cItems[-7],nItems[-7],oItems[-7])
hildaItems9 <- c(eItems9[c(-2,-7)],aItems9[c(-2,-5,-7)],cItems9[-7],nItems9[-7],oItems9[-7])

hildaItemNames <- c("id","age05","hid","weight",hildaItems,"age09",hildaItems9,
                    "female","agecat","agecat2","agecat5","agecat5b")
names(h) <- hildaItemNames

###Parcels for CFA
eItems <- paste("y05e",1:8,sep="")
aItems <- paste("y05a",1:7,sep="")
cItems <- paste("y05c",1:7,sep="")
nItems <- paste("y05n",1:7,sep="")
oItems <- paste("y05o",1:7,sep="")
eItems9 <- paste("y09e",1:8,sep="")
aItems9 <- paste("y09a",1:7,sep="")
cItems9 <- paste("y09c",1:7,sep="")
nItems9 <- paste("y09n",1:7,sep="")
oItems9 <- paste("y09o",1:7,sep="")

source("lib/parcels.r")
finalE <- c(eItems[c(-2,-7)],eItems9[c(-2,-7)])
finalA <- c(aItems[c(-2,-5,-7)],aItems9[c(-2,-5,-7)])
finalC <- c(cItems[-7],cItems9[-7])
finalN <- c(nItems[-7],nItems9[-7])
finalO <- c(oItems[-7],oItems9[-7])

eParcels <- cbind(h$id,h$hid,h$weight,h$agecat5b,parcel(h[,finalE],6,2,c(2,2,2)))
aParcels <- cbind(h$id,h$hid,h$weight,h$agecat5b,parcel(h[,finalA],4,2,c(2,1,1)))
cParcels <- cbind(h$id,h$hid,h$weight,h$agecat5b,parcel(h[,finalC],6,2,c(2,2,2)))
nParcels <- cbind(h$id,h$hid,h$weight,h$agecat5b,parcel(h[,finalN],6,2,c(2,2,2)))
oParcels <- cbind(h$id,h$hid,h$weight,h$agecat5b,parcel(h[,finalO],6,2,c(2,2,2)))

## Select those who participated in 2005
## Only run this to check missing data
eParcels <- eParcels[which(is.na(eParcels$parcelW1P1)==F|is.na(eParcels$parcelW1P2)==F|is.na(eParcels$parcelW1P3)==F),]
aParcels <- aParcels[which(is.na(aParcels$parcelW1P1)==F|is.na(aParcels$parcelW1P2)==F|is.na(aParcels$parcelW1P3)==F),]
cParcels <- cParcels[which(is.na(cParcels$parcelW1P1)==F|is.na(cParcels$parcelW1P2)==F|is.na(cParcels$parcelW1P3)==F),]
nParcels <- nParcels[which(is.na(nParcels$parcelW1P1)==F|is.na(nParcels$parcelW1P2)==F|is.na(nParcels$parcelW1P3)==F),]
oParcels <- oParcels[which(is.na(oParcels$parcelW1P1)==F|is.na(oParcels$parcelW1P2)==F|is.na(oParcels$parcelW1P3)==F),]



prepareMplusData(eParcels,"~/Documents/Datasets/HILDA09/Cleaned/eParcels.dat")
prepareMplusData(aParcels,"~/Documents/Datasets/HILDA09/Cleaned/aParcels.dat")
prepareMplusData(cParcels,"~/Documents/Datasets/HILDA09/Cleaned/cParcels.dat")
prepareMplusData(nParcels,"~/Documents/Datasets/HILDA09/Cleaned/nParcels.dat")
prepareMplusData(oParcels,"~/Documents/Datasets/HILDA09/Cleaned/oParcels.dat")
