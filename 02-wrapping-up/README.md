# Survey.

Our workshops are always evolving, and we'd love your feedback.
[http://ropensci.org/scio14](http://ropensci.org/scio14)

# Rstudio server

The RStudio you used for the workshop today is available as a public Amazon Machine Image (AMI). The machine ID is:

```coffee
ami-25787c4c
```

This means that you can use your own [personal Amazon account](https://console.aws.amazon.com/console/home) to launch an instance of this machine image at your convenience. We'll keep all the stable versions of rOpenSci packages and tools updated at all times. 

You will most likely just want to work locally on your copy of RStudio. In that case, you'll need the latest version of R (currently `3.0.2`) and [RStudio](http://www.rstudio.com/) for your platform. Then install the following packages:

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
install_github(c("ropensci/rentrez","ropensci/rpubmed","ropensci/rAltmetric","ropensci/rAltmetric"))
```

I may have missed a few dependencies. If so, apologies in advance.