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






