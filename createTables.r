######################################################################################
## Table 1 - N
######################################################################################

h <- read.csv("~/Documents/Datasets/HILDA09/Cleaned/hildaItems.csv",na="-9",header=F)

table1 <- table(h$V66,h$V62)
sum <- apply(table1,1,sum)
pFemale <- prop.table(table1,1)[,2]
table1 <- cbind(sum,pFemale)
write.csv(table1,"reports/table1.csv")


######################################################################################
## Table 2 - Fit Indexes
######################################################################################

eFit <- extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*extraversion*")
aFit <- extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*agreeableness*")
cFit <- extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*conscientiousness*")
nFit <- extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*neuroticism*")
oFit <- extractModelSummaries("reports/Auto",recursive=TRUE,filefilter=".*openness*")

###Create Fit Summary Table
eSummary <- eFit[,c("ChiSqM_Value","ChiSqM_DF","CFI","TLI","RMSEA_Estimate","SRMR")]
aSummary <- aFit[,c("ChiSqM_Value","ChiSqM_DF","CFI","TLI","RMSEA_Estimate","SRMR")]
cSummary <- cFit[,c("ChiSqM_Value","ChiSqM_DF","CFI","TLI","RMSEA_Estimate","SRMR")]
nSummary <- nFit[,c("ChiSqM_Value","ChiSqM_DF","CFI","TLI","RMSEA_Estimate","SRMR")]
oSummary <- oFit[,c("ChiSqM_Value","ChiSqM_DF","CFI","TLI","RMSEA_Estimate","SRMR")]

dimnames(eSummary) <- list(c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5"),
                           c("Chi-Square", "DF", "CFI", "TLI", "RMSEA", "SRMR"))
dimnames(aSummary) <- list(c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5"),
                           c("Chi-Square", "DF", "CFI", "TLI", "RMSEA", "SRMR"))
dimnames(cSummary) <- list(c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5"),
                           c("Chi-Square", "DF", "CFI", "TLI", "RMSEA", "SRMR"))
dimnames(nSummary) <- list(c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5"),
                           c("Chi-Square", "DF", "CFI", "TLI", "RMSEA", "SRMR"))
dimnames(oSummary) <- list(c("Model 1", "Model 2", "Model 3", "Model 4", "Model 5"),
                           c("Chi-Square", "DF", "CFI", "TLI", "RMSEA", "SRMR"))

xtable(eSummary, caption="Fit Indexes for Measurement Invariance CFA Models")
xtable(aSummary, caption="Fit Indexes for Measurement Invariance CFA Models")
xtable(cSummary, caption="Fit Indexes for Measurement Invariance CFA Models")
xtable(nSummary, caption="Fit Indexes for Measurement Invariance CFA Models")
xtable(oSummary, caption="Fit Indexes for Measurement Invariance CFA Models")

######################################################################################
