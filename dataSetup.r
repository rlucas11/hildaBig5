## September 12 Corrections: Fix merge so All=T

#################################################################
##Get 2005 Data (including HID & cross-sectional weight)
#################################################################
###All raw data should be stored in 'Documents/Datasets/HILDA09'.
###All processed data should be stored in 'Documents/Datasets/HILDA09/Cleaned'
y05 <- read.dta("~/Documents/Datasets/HILDA09/Rperson_e90c.dta")
y05p <- y05[,c(1,2,8,2615:2650,3181)]
names(y05p) <- c("id","hid","age05",paste(c("y05e","y05a","y05c","y05n","y05o"),
                                          rep(1:7,each=5),sep=""),"y05e8","weight")
####Recode Missing
y05p[y05p<0] <- NA
####Recode Reverse-Scored Items
recodes <- c("y05e2","y05e3","y05e4","y05e6","y05a2","y05a5","y05a7","y05c3",
             "y05c4","y05c5","y05c7","y05n7","y05o7")
for(i in recodes) {
  y05p[,i] <- recode(y05p[,i],"1=7;2=6;3=5;4=4;5=3;6=2;7=1")
}
####List Items
eItems <- paste("y05e",1:8,sep="")
aItems <- paste("y05a",1:7,sep="")
cItems <- paste("y05c",1:7,sep="")
nItems <- paste("y05n",1:7,sep="")
oItems <- paste("y05o",1:7,sep="")
####Select Items that HILDA Recommends
hildaItems <- c(eItems[c(-2,-7)],aItems[c(-2,-5,-7)],cItems[-7],nItems[-7],oItems[-7])
####Calculate Alphas
alpha(y05p[,eItems])
alpha(y05p[,aItems])
alpha(y05p[,cItems])
alpha(y05p[,nItems])
alpha(y05p[,oItems])

###################################################################
##Get 2009 Data (No HID or weight needed)
###################################################################
y09 <- read.dta("~/Documents/Datasets/HILDA09/Rperson_i90c.dta")
y09p <- y09[,c(1,8,2638:2673)]
names(y09p) <- c("id","age09",paste(c("y09e","y09a","y09c","y09n","y09o"),rep(1:7,each=5),sep=""),"y09e8")
####Recode Missing
y09p[y09p<0] <- NA
####Recode Reverse-Scored Items
recodes9 <- c("y09e2","y09e3","y09e4","y09e6","y09a2","y09a5","y09a7","y09c3","y09c4","y09c5","y09c7",
             "y09n7","y09o7")
for(i in recodes9) {
  y09p[,i] <- recode(y09p[,i],"1=7;2=6;3=5;4=4;5=3;6=2;7=1")
}
####List Items
eItems9 <- paste("y09e",1:8,sep="")
aItems9 <- paste("y09a",1:7,sep="")
cItems9 <- paste("y09c",1:7,sep="")
nItems9 <- paste("y09n",1:7,sep="")
oItems9 <- paste("y09o",1:7,sep="")
####Select Items that HILDA Recommends
hildaItems9 <- c(eItems9[c(-2,-7)],aItems9[c(-2,-5,-7)],cItems9[-7],nItems9[-7],oItems9[-7])
####Calculate Alphas
alpha(y09p[,eItems9])
alpha(y09p[,aItems9])
alpha(y09p[,cItems9])
alpha(y09p[,nItems9])
alpha(y09p[,oItems9])

####################################################################
##Merge 2005 and 2009 Data
####################################################################
y05pSelect <- y05p[,c("id","age05","hid","weight",hildaItems)]
y09pSelect <- y09p[,c("id","age09",hildaItems9)]
final <- merge(y05pSelect,y09pSelect,by="id",all=T)

####################################################################
##Pull Sex Variable from Master
####################################################################
m <- read.dta("~/Documents/Datasets/HILDA09/Master_i90c.dta")
m2 <- m[,c("xwaveid","sex")]
names(m2) <- c("id","sex")
####Merge
final <- merge(final,m2,by="id")
final$female <- NA
final[which(final$sex=="[1] Male"),"female"] <- 0
final[which(final$sex=="[2] Female"),"female"] <- 1
final$sex <- NULL


## Create agecat variables
final[which(is.na(final$age05)),"age05"] <- final[which(is.na(final$age05)),"age09"]-4
final$agecat <- cut(as.numeric(final$age05),breaks=seq(14,82,by=4),labels=seq(1:17))
final$agecat2 <- cut(as.numeric(final$age05),breaks=c(seq(14,74,by=4),100),labels=seq(1:16))
final$agecat5 <- cut(as.numeric(final$age05),breaks=c(seq(14,79,by=5),100),labels=seq(1:14))
final$agecat5b <- cut(as.numeric(final$age05),breaks=c(seq(14,84,by=5)),labels=seq(1:14))
####Output in format for Mplus
write.table(final,"~/Documents/Datasets/HILDA09/Cleaned/hildaItems.csv",na="-9",sep=",",row.names=F,col.names=F)


####################################################################
## Find who participated in each wave
####################################################################

master <- read.dta("~/Documents/Datasets/HILDA09/Master_i90c.dta")
master <- master[,c("xwaveid","efstatus","ifstatus")]

## 10548 of the 12759 respondents from 2005 participated in 2009

h <- read.csv("~/Documents/Datasets/HILDA09/Cleaned/hildaItems.csv",header=FALSE,na.strings="-9")
## hildaItemNames <- c(c("id","age05","hid","weight",
##                       paste(c("y05e","y05a","y05c","y05n","y05o"),
##                             rep(1:7,each=5),sep=""),"y05e8"),
##                     c("age09",paste(c("y09e","y09a","y09c","y09n","y09o"),
##                                     rep(1:7,each=5),sep=""),"y09e8"),
##                     c("female","agecat","agecat2","agecat5","agecat5b"))
## names(h) <- hildaItemsNames

names(h) <- names(final)

temp05 <- sapply(h[,5:32],is.na)
y05Miss <- rowMeans(temp05)
temp09 <- sapply(h[,34:61],is.na)
y09Miss <- rowMeans(temp09)
miss <- as.data.frame(cbind(y05Miss,y09Miss))
miss[which(miss$y05Miss<1),"y05Miss"] <- 0
miss[which(miss$y09Miss<1),"y09Miss"] <- 0

## 9557 non-missing personality reports in 2005; 8696 (90%) in 2009
