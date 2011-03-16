####################################################################
##Mplus Data Analysis
####################################################################

####Must create templates 1 through 5 before running this script. These should be placed in the 'Auto' folder within 'Reports'.
createModels("reports/Auto/template5.inp")
runModels("reports/Auto/Model5",Mplus_command="wine Mplus.exe")
summaryStats5 <- extractModelSummaries("reports/Auto/Model5")
showSummaryTable(summaryStats5)

createModels("reports/Auto/template4.inp")
runModels("reports/Auto/Model4",Mplus_command="wine Mplus.exe")
summaryStats4 <- extractModelSummaries("reports/Auto/Model4")
showSummaryTable(summaryStats4)

createModels("reports/Auto/template3.inp")
runModels("reports/Auto/Model3",Mplus_command="wine Mplus.exe")
summaryStats3 <- extractModelSummaries("reports/Auto/Model3")
showSummaryTable(summaryStats3)

createModels("reports/Auto/template2.inp")
runModels("reports/Auto/Model2",Mplus_command="wine Mplus.exe")
summaryStats2 <- extractModelSummaries("reports/Auto/Model2")
showSummaryTable(summaryStats2)

createModels("reports/Auto/template1.inp")
runModels("reports/Auto/Model1",Mplus_command="wine Mplus.exe")
summaryStats1 <- extractModelSummaries("reports/Auto/Model1")
showSummaryTable(summaryStats1)

extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*extraversion*")
extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*agreeableness*")
extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*conscientiousness*")
extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*neuroticism*")
extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*openness*")

###Means
extParam <- extractModelParameters("reports/Auto/Model5",filefilter=".*extraversion*")
extMeans <- extParam$unstandardized[which(extParam$unstandardized$paramHeader=="Means"),]
agrParam <- extractModelParameters("reports/Auto/Model5",filefilter=".*agreeableness*")
agrMeans <- agrParam$unstandardized[which(agrParam$unstandardized$paramHeader=="Means"),]
conParam <- extractModelParameters("reports/Auto/Model5",filefilter=".*conscientiousness*")
conMeans <- conParam$unstandardized[which(conParam$unstandardized$paramHeader=="Means"),]
neuParam <- extractModelParameters("reports/Auto/Model5",filefilter=".*neuroticism*")
neuMeans <- neuParam$unstandardized[which(neuParam$unstandardized$paramHeader=="Means"),]
opeParam <- extractModelParameters("reports/Auto/Model5",filefilter=".*openness*")
opeMeans <- opeParam$unstandardized[which(opeParam$unstandardized$paramHeader=="Means"),]

cfaMeans <- cbind(extMeans[,c(3,7)],agrMeans[,3],conMeans[,3],neuMeans[,3],opeMeans[,3])
names(cfaMeans) <- c("e","group","a","c","n","o")
age <- c(17,21,22,26,27,31,32,36,37,41,42,46,47,51,52,56,57,61,62,66,67,71,72,76,77,81,82,86)
cfaMeans <- cbind(cfaMeans,age)

ePlot <- qplot(age,e,data=cfaMeans,geom="line",group=group,xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Extraversion")+scale_y_continuous(limits=c(-1.5,1))
aPlot <- qplot(age,a,data=cfaMeans,geom="line",group=group,xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Agreeableness")+scale_y_continuous(limits=c(-1.5,1))
cPlot <- qplot(age,c,data=cfaMeans,geom="line",group=group,xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Conscientiousness")+scale_y_continuous(limits=c(-1.5,1))
nPlot <- qplot(age,n,data=cfaMeans,geom="line",group=group,xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Neuroticism")+scale_y_continuous(limits=c(-1.5,1))
oPlot <- qplot(age,o,data=cfaMeans,geom="line",group=group,xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Openness")+scale_y_continuous(limits=c(-1.5,1))

png("graphs/cfaMeanFigure1.png",width=10,height=8,units="in",res=300)
grid.newpage()
pushViewport(viewport(layout=grid.layout(2,3)))
print(ePlot,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(aPlot,vp=viewport(layout.pos.row=1,layout.pos.col=2))
print(cPlot,vp=viewport(layout.pos.row=1,layout.pos.col=3))
print(nPlot,vp=viewport(layout.pos.row=2,layout.pos.col=1))
print(oPlot,vp=viewport(layout.pos.row=2,layout.pos.col=2))
dev.off()


###Correlations
extCorrs <- extParam$stdyx.standardized[which(extParam$stdyx.standardized$paramHeader=="T1.WITH"),]
agrCorrs <- agrParam$stdyx.standardized[which(agrParam$stdyx.standardized$paramHeader=="T1.WITH"),]
conCorrs <- conParam$stdyx.standardized[which(conParam$stdyx.standardized$paramHeader=="T1.WITH"),]
neuCorrs <- neuParam$stdyx.standardized[which(neuParam$stdyx.standardized$paramHeader=="T1.WITH"),]
opeCorrs <- opeParam$stdyx.standardized[which(opeParam$stdyx.standardized$paramHeader=="T1.WITH"),]

cfaCorrs <- cbind(extCorrs[,c(3,7)],agrCorrs[,3],conCorrs[,3],neuCorrs[,3],opeCorrs[,3])
names(cfaCorrs) <- c("e","group","a","c","n","o")
age <- seq(17,82,by=5)
cfaCorrs <- cbind(cfaCorrs,age)

z <- sapply(cfaCorrs[,c(1,3:6)],rtoZ)
agg <- ZtoR(apply(z,1,mean))
cfaCorrs <- cbind(cfaCorrs,agg)

ePlot <- qplot(age,e,data=cfaCorrs,xlab="Age",ylab="r")+
  geom_smooth(data=cfaCorrs,method="lm",formula=y~poly(x,2),color="black",se=F)+
  geom_smooth(data=cfaCorrs,color="grey",se=F)+
  theme_bw(base_size=10)+
  opts(title="Extraversion")+
  scale_y_continuous(limits=c(.40,1.00))
aPlot <- qplot(age,a,data=cfaCorrs,xlab="Age",ylab="r")+
  geom_smooth(data=cfaCorrs,method="lm",formula=y~poly(x,2),color="black",se=F)+
  geom_smooth(data=cfaCorrs,color="grey",se=F)+
  theme_bw(base_size=10)+
  opts(title="Agreeableness")+
  scale_y_continuous(limits=c(.40,1.00))
cPlot <- qplot(age,c,data=cfaCorrs,xlab="Age",ylab="r")+
  geom_smooth(data=cfaCorrs,method="lm",formula=y~poly(x,2),color="black",se=F)+
  geom_smooth(data=cfaCorrs,color="grey",se=F)+
  theme_bw(base_size=10)+
  opts(title="Conscientiousness")+
  scale_y_continuous(limits=c(.40,1.00))
nPlot <- qplot(age,n,data=cfaCorrs,xlab="Age",ylab="r")+
  geom_smooth(data=cfaCorrs,method="lm",formula=y~poly(x,2),color="black",se=F)+
  geom_smooth(data=cfaCorrs,color="grey",se=F)+
  theme_bw(base_size=10)+
  opts(title="Neuroticism")+
  scale_y_continuous(limits=c(.40,1.00))
oPlot <- qplot(age,o,data=cfaCorrs,xlab="Age",ylab="r")+
  geom_smooth(data=cfaCorrs,method="lm",formula=y~poly(x,2),color="black",se=F)+
  geom_smooth(data=cfaCorrs,color="grey",se=F)+
  theme_bw(base_size=10)+
  opts(title="Openness")+
  scale_y_continuous(limits=c(.40,1.00))
aggPlot <- qplot(age,agg,data=cfaCorrs,xlab="Age",ylab="r")+
  geom_smooth(data=cfaCorrs,method="lm",formula=y~poly(x,2),color="black",se=F)+
  geom_smooth(data=cfaCorrs,color="grey",se=F)+
  theme_bw(base_size=10)+
  opts(title="Average")+
  scale_y_continuous(limits=c(.40,.90))



png("graphs/cfaStabilityFigure2.png",width=10,height=8,units="in",res=300)
grid.newpage()
pushViewport(viewport(layout=grid.layout(2,3)))
print(ePlot,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(aPlot,vp=viewport(layout.pos.row=1,layout.pos.col=2))
print(cPlot,vp=viewport(layout.pos.row=1,layout.pos.col=3))
print(nPlot,vp=viewport(layout.pos.row=2,layout.pos.col=1))
print(oPlot,vp=viewport(layout.pos.row=2,layout.pos.col=2))
print(aggPlot,vp=viewport(layout.pos.row=2,layout.pos.col=3))
dev.off()



###From ESEM
###Must have 'Constrained.inp' in the 'reports' folder before running this
###Uncomment next line to run; it is commented by default because it takes so long.
#runModels("reports",Mplus_command="wine Mplus.exe")
esemParam <- extractModelParameters("reports/constrained.out")
esemMeans <- esemParam$unstandardized[which(esemParam$unstandardized$paramHeader=="Means"),]
time <- rep(1:2,each=5,times=14)
esemMeans <- cbind(esemMeans,time)
temp <- reshape(esemMeans,timevar="param",idvar="Group",drop=c("paramHeader","se","est_se","pval"),direction="wide")
names(temp) <- c("group","e.1","te.1","a.1","ta.1","c.1","tc.1","n.1","tn.1","o.1","to.1",
                 "e.2","te.2","a.2","ta.2","c.2","tc.2","n.2","tn.2","o.2","to.2")
temp2 <- reshape(temp,idvar="group",varying=c("e.1","a.1","c.1","n.1","o.1","e.2","a.2","c.2","n.2","o.2"),direction="long",drop=c("te.1","ta.1","tc.1","tn.1","to.1","te.2","ta.2","tc.2","tn.2","to.2"))
temp3 <- temp2[order(temp2$group,temp2$time),]

#Get data from CFA Model (see above)
temp3$time <- NULL
temp3 <- cbind(temp3,age)
temp3$type <- 1
cfaMeans$type <- 2
finalMeans <- rbind(temp3,cfaMeans)


#Plots
finalMeans$group2 <- paste(finalMeans$group,finalMeans$type,sep="")

ePlot <- qplot(age,e,data=finalMeans,geom="line",group=group2,color=factor(type),xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Extraversion")+scale_y_continuous(limits=c(-1.5,1))
aPlot <- qplot(age,a,data=finalMeans,geom="line",group=group2,color=factor(type),xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Agreeableness")+scale_y_continuous(limits=c(-1.5,1))
cPlot <- qplot(age,c,data=finalMeans,geom="line",group=group2,color=factor(type),xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Conscientiousness")+scale_y_continuous(limits=c(-1.5,1))
nPlot <- qplot(age,n,data=finalMeans,geom="line",group=group2,color=factor(type),xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Neuroticism")+scale_y_continuous(limits=c(-1.5,1))
oPlot <- qplot(age,o,data=finalMeans,geom="line",group=group2,color=factor(type),xlab="Age",ylab="Standardized Mean")+theme_bw(base_size=10)+opts(title="Openness")+scale_y_continuous(limits=c(-1.5,1))

png("graphs/compMeanFigure1.png",width=10,height=8,units="in",res=300)
grid.newpage()
pushViewport(viewport(layout=grid.layout(2,3)))
print(ePlot,vp=viewport(layout.pos.row=1,layout.pos.col=1))
print(aPlot,vp=viewport(layout.pos.row=1,layout.pos.col=2))
print(cPlot,vp=viewport(layout.pos.row=1,layout.pos.col=3))
print(nPlot,vp=viewport(layout.pos.row=2,layout.pos.col=1))
print(oPlot,vp=viewport(layout.pos.row=2,layout.pos.col=2))
dev.off()
