#################################################################
## Calculate alphas
#################################################################
h <- read.csv("~/Documents/Datasets/HILDA09/Cleaned/hildaItems.csv",header=FALSE,na.strings="-9")
hildaItemNames <- c(c("id","hid","age05",
                      paste(c("y05e","y05a","y05c","y05n","y05o"),
                            rep(1:7,each=5),sep=""),"y05e8","weight"),
                    c("age09",paste(c("y09e","y09a","y09c","y09n","y09o"),
                                    rep(1:7,each=5),sep=""),"y09e8"),
                    c("female","agecat","agecat2","agecat5","agecat5b","ageSexCat"))
names(h) <- hildaItemsNames

eItems <- paste("y05e",1:8,sep="")
aItems <- paste("y05a",1:7,sep="")
cItems <- paste("y05c",1:7,sep="")
nItems <- paste("y05n",1:7,sep="")
oItems <- paste("y05o",1:7,sep="")
####Select Items that HILDA Recommends
hildaItems <- c(eItems[c(-2,-7)],aItems[c(-2,-5,-7)],cItems[-7],nItems[-7],oItems[-7])
####Calculate Alphas
e1 <- alpha(h[,eItems[c(-2,-7)]])
a1 <- alpha(h[,aItems[c(-2,-5,-7)]])
c1 <- alpha(h[,cItems[c(-7)]])
n1 <- alpha(h[,nItems[c(-7)]])
o1 <- alpha(h[,oItems[c(-7)]])
####2009 Items
eItems9 <- paste("y09e",1:8,sep="")
aItems9 <- paste("y09a",1:7,sep="")
cItems9 <- paste("y09c",1:7,sep="")
nItems9 <- paste("y09n",1:7,sep="")
oItems9 <- paste("y09o",1:7,sep="")
####Select Items that HILDA Recommends
hildaItems9 <- c(eItems9[c(-2,-7)],aItems9[c(-2,-5,-7)],cItems9[-7],nItems9[-7],oItems9[-7])
####Calculate Alphas
e2 <- alpha(h[,eItems9[c(-2,-7)]])
a2 <- alpha(h[,aItems9[c(-2,-5,-7)]])
c2 <- alpha(h[,cItems9[c(-7)]])
n2 <- alpha(h[,nItems9[c(-7)]])
o2 <- alpha(h[,oItems9[c(-7)]])

a05 <- c(e1$total$raw_alpha,a1$total$raw_alpha,c1$total$raw_alpha,n1$total$raw_alpha,o1$total$raw_alpha)
a09 <- c(e2$total$raw_alpha,a2$total$raw_alpha,c2$total$raw_alpha,n2$total$raw_alpha,o2$total$raw_alpha)
alphas <- as.data.frame(rbind(a05,a09))
names(alphas) <- c("Extraversion","Agreeableness","Conscientiousness","Neuroticism","Openness")
row.names(alphas) <- c("2005","2009")


write.csv(alphas,"reports/alphas.csv")
