setwd("/Users/Nick/spring15/independentStudy")
#A point of note: fdrtool was written under R 3.1.2 which is the latest. 
#R.Version() #A quick way to check if you need. 

require(fdrtool)
require(ggplot2)

obesity = read.table("data/obesity_censored.txt", header = TRUE, fill = TRUE)

m = ggplot(obesity, aes(x = pvalue)) + 
  geom_histogram(aes(y=..count../sum(..count..)), color = "white", fill = "black") +
  labs(title = "Histogram of p-values for obesity Words (normalized)",
      x = "P-Value", y = "% of words at p-val")
m #Have to actually call the ggplot variable to see it

ggsave("figures/Testing.pdf") #Save
