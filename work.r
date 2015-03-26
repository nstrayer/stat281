setwd("/Users/Nick/spring15/independentStudy")
#A point of note: fdrtool was written under R 3.1.2 which is the latest. 
#R.Version() #A quick way to check if you need.

# Incase you need to isntall the packages
# install.packages("fdrtool")
# install.packages("ggplot2")
# install.packages("gridExtra")

require(fdrtool)
require(ggplot2)
library(gridExtra)

obesityRaw = read.table("data/obesity_censored.txt", header = TRUE, fill = TRUE)
obesity = na.omit(obesityRaw) #There are some NAs in the data.

m = ggplot(obesity, aes(x = pvalue)) + 
  geom_histogram(aes(y=..count../sum(..count..)), color = "white", fill = "black") + 
  labs(title = "Histogram of p-values for obesity words (normalized)",
      x = "P-Value", y = "% of words at p-val")
m #Have to actually call the ggplot variable to see it
ggsave("figures/Obesity_PVal_Hist_Norm.pdf") #Save


FDRresults = fdrtool(obesity$pvalue, statistic = "pvalue", plot = TRUE)
obesity$qvalue = FDRresults$qval

#Plot qval and pval side by side to see changes.
P   = ggplot(obesity, aes(x = pvalue)) + geom_histogram(aes(y=..count../sum(..count..)),fill = "#7fc97f", alpha = 0.6) + ylim(0,0.4)
Q   = ggplot(obesity, aes(x = qvalue)) + geom_histogram(aes(y=..count../sum(..count..)), fill = "#beaed4", alpha = 0.6) + ylim(0,0.4)
out = arrangeGrob(P,Q,ncol=2, main = "P-Val vs, Q-Val")
out #just so we can see the output. 
ggsave("figures/Obesity_PVal_vs_Qval.pdf",out) #Save
