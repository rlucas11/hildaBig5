####################################################################
##Mplus Data Analysis
####################################################################

####Must create templates 1 through 5 before running this script. These should be placed in the 'Auto' folder within 'Reports'.

## Create Models
createModels("reports/Auto/template5.inp")
createModels("reports/Auto/template4.inp")
createModels("reports/Auto/template3.inp")
createModels("reports/Auto/template2.inp")
createModels("reports/Auto/template1.inp")

## Run Models
runModels("/home/rich/Projects/hildaBig5/reports/Auto/Model5",Mplus_command="wine Mplus.exe")
runModels("/home/rich/Projects/hildaBig5/reports/Auto/Model4",Mplus_command="wine Mplus.exe")
runModels("/home/rich/Projects/hildaBig5/reports/Auto/Model3",Mplus_command="wine Mplus.exe")
runModels("/home/rich/Projects/hildaBig5/reports/Auto/Model2",Mplus_command="wine Mplus.exe")
runModels("/home/rich/Projects/hildaBig5/reports/Auto/Model1",Mplus_command="wine Mplus.exe")

## Summary Status
summaryStats5 <- extractModelSummaries("reports/Auto/Model5")
showSummaryTable(summaryStats5)
summaryStats4 <- extractModelSummaries("reports/Auto/Model4")
showSummaryTable(summaryStats4)
summaryStats3 <- extractModelSummaries("reports/Auto/Model3")
showSummaryTable(summaryStats3)
summaryStats2 <- extractModelSummaries("reports/Auto/Model2")
showSummaryTable(summaryStats2)
summaryStats1 <- extractModelSummaries("reports/Auto/Model1")
showSummaryTable(summaryStats1)






