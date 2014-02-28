Altmetrics, metadata search and text mining OA articles
=============================

1). Altmetrics

* [plos alm](http://ropensci.org/tutorials/alm_tutorial.html)
* [rAltmetric](http://ropensci.github.io/rAltmetric/)

2). Metadata records
 
* [rmetadata](http://ropensci.github.io/rmetadata/)
* [rentrez](http://ropensci.github.io/rentrez/)
* [rpubmed](http://www.github.com/ropensci/rpubmed)
* [rcrossref](https://github.com/ropensci/rcrossref)

3). Full text access

* [rplos](http://ropensci.github.io/rplos/)

4). Plotting

* [rCharts](http://rcharts.io/)


What we'll cover today
========================
* Searching and plotting results from [metadata searches](https://github.com/ropensci/workshops-scio14-2014-02/blob/master/01-core/1_Metadata_search.md)
* Searching and visualizing [altmetrics](https://github.com/ropensci/workshops-scio14-2014-02/blob/master/01-core/2_Altmetrics.md)
* Text mining OA full text and [pubmed abstracts](https://github.com/ropensci/workshops-scio14-2014-02/blob/master/01-core/3_Text_mining.md)

*You can grab the extracted code* [right here](https://github.com/ropensci/workshops-scio14-2014-02/tree/master/01-core/rawSrc) 

How to do this locally
========================
Install these libraries
From CRAN:

```coffee
install.packages("ggplot2", dependencies = TRUE)
install.packages("wordcount","tm","rplos")
```


Then install some packages from GitHub. First install the devtools package since it will allow you to install packages directly from GitHub that haven't yet been submitted to CRAN.

```coffee
install.packages("devtools")
library(devtools)
```

Then install some packages:

```coffee
install_github(c("ropensci/rentrez","ropensci/rpubmed","ropensci/rAltmetric",
"ropensci/rAltmetric","ropensci/rmetadata","ropensci/rcrossref"))
```