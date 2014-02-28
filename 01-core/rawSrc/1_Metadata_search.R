
## ------------------------------------------------------------------------
library(devtools)
#install_github("rentrez","ropensci")
#install_github("rmetadata","ropensci")
#install_github("rcrossref","ropensci")
#install_github("raltmetric","ropensci")
#install_github("alm","ropensci")
#install_github("rcrossref","ropensci")
#install.packages("tm")
#install.packages("wordcloud")




## ----search with rmetadata-----------------------------------------------
options(stringsAsFactors=F)
library(rcrossref)
library(rmetadata)
library(rentrez)

toxo <- crossref_search(q = "toxoplasmosis")

## We can also extend these to search by year, and change the number of records we have

toxo2 <- crossref_search(q = "toxoplasmosis", rows = 100, year = 2010)


### we can view these records 

toxo2[34,]$doi
toxo2[34,]$fullCitation

### Doi's come back with http appended, let's strip it off
toxo2$doi_nohttp <- gsub("http://dx.doi.org/","",toxo2$doi)

#We can also see the full citation
print(crossref_citation("10.1016/j.cub.2013.11.014"), style="Bibtex")
print(crossref_citation(toxo2$doi_nohttp[55]))




## ----pubmed--------------------------------------------------------------
dmagna <- entrez_search(db="pubmed",term="Daphnia magna", retmax=1000)


papers_by_year <- function(years, search_term){
            return(sapply(years, function(y) entrez_search(db="pubmed",term=search_term, mindate=y, maxdate=y, retmax=0)$count))
        }

years <- 1990:2011
total_papers <- papers_by_year(years, "")
omics <- c("genomic", "epigenomic", "metagenomic", "proteomic", "transcriptomic", "pharmacogenomic", "connectomic" )
trend_data <- sapply(omics, function(t) papers_by_year(years, t))
trend_props <- data.frame(trend_data/total_papers)
trend_props$years <- years

trend_df <- melt(as.data.frame(trend_props), id.vars="years")
p <- ggplot(trend_df, aes(years, value, colour=variable))
p + geom_line(size=1) + scale_y_log10("number of papers")




