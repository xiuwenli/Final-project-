# Final-project-
## Final project description 
###Description:

I find some data about disease adipose and want to use informatics to do some data analyses. I collected two different data about two different types of adipose. One is adipose in subcutaneous. The other data is about visceral adipose (sample choose from visceral omentum). They both contain gender, age and sample tissue ID and hardy scale about each individual sample. So that, I want to use these data to compare different adipose disease. By using R studio and library in R. I want to know that is adipose a kind of disease that usually exist in female or male, and which kind of age group dose subcutaneous adipose disease or visceral adipose disease usually show in, and is it have serious influence in people’s life? I collected twenty different genocode ID information for each adipose tissue from GTEx website, and get the whole RNAseq gene tpm file from that website. I would comparing these fourty gene by using PCA analysis. 

The data come from:
https://gtexportal.org/home/histologyPage.  
Adipose – Subcutaneous & Adipose - Visceral (Omentum)

Timelines:
Due to 11/06/2018: having a tentative program, which kind of disease I want to analyze, what kind of thing I want to know from this disease, what kind of graphs I want to get. Get dataset (first draft).

Due to 11/13/2018: complete my dataset and diagrams. Get first graphs by using R. Fix the issues showing in my dataset.

Due to 11/20/2018: combining the information that I want. getting PCA data. creating graphes.

Due to 11/27/2018: second draft of my final project 

Due to 12/05/2018: post my final project


## First Milestone 
### Try to complete the data 

Question: still have trouble in finding the gene from the gct file.

### Try to create first PCA 
code:
```{r}
library(ggplot2)
#library('RColorBrewer')
library(dplyr)
library(plotly)
library(data.table)

setwd(dir = '/Users/user')
genocode <- read.csv('genocade ID.csv',header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, row.names = 1)
genocode_sample <- as.data.frame(t(genocode[c(rep(),TRUE), ]))
pca<-prcomp(genocode_sample)

```
Question: After running the last code "pca<-prcomp(genocode_sample)". It always shows that "Error in colMeans(x, na.rm = TRUE) : 'x' must be numeric".
