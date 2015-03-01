#A horrific attempt to functionalize the histogram plotting. Opportunity cost miscalculation. 

pValHist = function(datums, name, normalized){
  #datums (yes in jest) = (Dataframe), out_file_name = "string", normalized = boolean
  # ^ pvalues must be in col titled pvalue
  
  if (normalized){
    fileName = paste("Pvalue_Histogram_Normalized_", name, sep = "")
    titleEnd = ("(normalized)")
    type = "%"
  } else {
    fileName = paste("Pvalue_Histogram_",name, sep = "")
    titleEnd = ("")
    type = "#"
  }
  
  m = ggplot(datums, aes(x = pvalue))
  if (normalized){
    m = m + geom_histogram(aes(y=..count../sum(..count..)), color = "white", fill = "black") 
  } else {
    m = m + geom_histogram( color = "white", fill = "black") 
  }
  
  m = m + labs(title = paste("Histogram of p-values for", name, "Words", titleEnd),
           x = "P-Value", y = paste(type, "of words with P-Value"))
  
  m
  
  ggsave(paste("figures/", fileName, ".pdf", sep = "") )
}

pValHist(obesity, "obesity", TRUE)