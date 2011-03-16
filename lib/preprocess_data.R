####Create List of Items and Rename Variables
eItems <- paste("y05e",1:8,sep="")
aItems <- paste("y05a",1:7,sep="")
cItems <- paste("y05c",1:7,sep="")
nItems <- paste("y05n",1:7,sep="")
oItems <- paste("y05o",1:7,sep="")
hildaItems <- c(eItems[c(-2,-7)],aItems[c(-2,-5,-7)],cItems[-7],nItems[-7],oItems[-7])

eItems9 <- paste("y09e",1:8,sep="")
aItems9 <- paste("y09a",1:7,sep="")
cItems9 <- paste("y09c",1:7,sep="")
nItems9 <- paste("y09n",1:7,sep="")
oItems9 <- paste("y09o",1:7,sep="")
hildaItems9 <- c(eItems9[c(-2,-7)],aItems9[c(-2,-5,-7)],cItems9[-7],nItems9[-7],oItems9[-7])

hildaItemsNames <- c("id","age05","hid","weight",hildaItems,"age09",hildaItems9,
                    "female","agecat","agecat2","agecat5","agecat5b","agecat5r")


