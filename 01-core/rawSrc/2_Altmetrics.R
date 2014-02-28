
## ----altmetrics, warning=FALSE, message=FALSE----------------------------
library(rAltmetric)
library(alm)
library(rentrez)
library(rplos)
library(plyr)
library(rCharts)

options(PlosApiKey = "3pezRBRXdyzYW6ztfwft")

### We can get the altmetric data for a given doi
vines <- altmetrics(doi = "10.1016/j.cub.2013.11.014")
plot(vines)
# extract particular aspects like tweets
# See all the data
altmetric_data(vines)
vines$cited_by_tweeters_count




## ----workflow, warning=FALSE, message=FALSE------------------------------

dois <- c("10.1038/nature09210","10.1126/science.1187820", "10.1016/j.tree.2011.01.009", "10.1086/664183")
doi_list <- paste0("doi","/", dois)
raw_metrics <- llply(doi_list, altmetrics, .progress = 'text')
metric_data <- ldply(raw_metrics, altmetric_data)
metric_data[,names(metric_data) %in% c("title","journal","mendeley")]



## ----omics_tweets, warning=FALSE, message=FALSE--------------------------
# here's our omics list
omics <- c("genomic", "epigenomic", "metagenomic", "proteomic", "transcriptomic", "pharmacogenomic", "connectomic" )

### Function to return mean tweet
omics_tweets <- function(search_term){
    pmids <- entrez_search(db="pubmed",term=search_term, mindate=2012, maxdate=2012, retmax=50)$ids
  return(mean(unlist(sapply(pmids,function(x) altmetrics(pmid = x)$cited_by_tweeters_count))))
}

(out <- sapply(omics,omics_tweets))




## ----plos_alm , warning=FALSE, message=FALSE-----------------------------

## Let's do some basic queries where we can get back id's and titles.  We will also use this for full text
pmg <- searchplos(terms = "pharmacogenomic",field = c("id","title","abstract"), limit = 300)

out <- alm(doi=pmg$id[30], info='detail')
out


out <- alm(doi = "10.1371/journal.pone.0000005",info="detail")
almplot(out, type='history') # just totalmetrics data

### We can also look at total details:
out <- alm(doi=pmg$id[20], info="detail")
out

## We could also look at metrics by time period.
## Here's a very highly cited plos medicine paper

out <- alm(doi = "10.1371/journal.pmed.0020124", sum_metrics='year')
head(out)

# now let's make a javascript plot with cumulative citations since 2006.
## Subset out the data
out <- out[out$.id %in% "crossref",]
plot(out$year,cumsum(out$citations))
citedata <- data.frame(cbind(out$year,cumsum(out$citations)))
colnames(citedata) <- c("Year","Cumulative citations")

### Plot using rCharts
cite_plot <- mPlot( x = "Year" ,y = "Cumulative citations" ,data = citedata,type="Line")

### Can be customized with this guide: http://t.co/hA6sdFzVI3
### If you want to write this out and use it in an iFrame
### cite_plot$save('mychart.html', cdn = TRUE)



### Get event data
out <- almevents(doi = "10.1371/journal.pone.0053788")
### remove sources that have no data
out <- out[!out %in% c("sorry, no events content yet", "parser not written yet")]
## See sources available
names(out)

## See all tweets
out$twitter[1:3,]
## See all other papers that cited this paper in crossref
out$crossref


### 


## ----cite_hist, warning=FALSE, message=FALSE-----------------------------

dois <- searchplos(terms = "proteomics", fields = "id", toquery = list("cross_published_journal_key:PLoSONE", 
    "doc_type:full", "publication_date:[2010-01-01T00:00:00Z TO 2010-12-31T23:59:59Z]"), 
    limit = 200)

### Remove non full article DOI's
dois <- dois$id
dois <- dois[!grepl("annotation", dois)]

### Get data on all DOI's
out <- alm(doi = dois, total_details = TRUE)
out<- ldply(out)
### See a density plot of all crossref citations, scopus citations, and tweets
plot_density(input = out, source = "crossref_citations")
plot_density(input = out, source = "scopus_citations")
plot_density(input = out, source = "twitter_total")




