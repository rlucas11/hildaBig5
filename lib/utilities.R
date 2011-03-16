clean.variable.name <- function(variable.name)
{
  variable.name <- gsub('_', '.', variable.name, perl = TRUE)
  variable.name <- gsub('-', '.', variable.name, perl = TRUE)
  variable.name <- gsub('\\s+', '.', variable.name, perl = TRUE)
  return(variable.name)
}

### r to Z functions for aggregating correlations
rtoZ <- function(r) {
  return(.5*(log(1+r)-log(1-r)))
}
ZtoR <- function(Z) {
  return((exp(2*Z)-1)/(exp(2*Z)+1))
}
