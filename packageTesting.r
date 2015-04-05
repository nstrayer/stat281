#install.packages("http://www.uvm.edu/~rsingle/temp2/R/asymLD/asymLD_0.1.tar.gz", repos = NULL, type = "source")

library(asymLD)
data(hla.freqs)

#this is a comment

hla.a_b <- hla.freqs[hla.freqs$locus1=="A" & hla.freqs$locus2=="B",]
compute.ALD(hla.a_b)
hla.freqs$locus <- paste(hla.freqs$locus1, hla.freqs$locus2, sep="-")
testing = compute.ALD(hla.freqs[hla.freqs$locus=="C-B",])


#-----
#out with the old and in with the new

detach("package:asymLD", unload=TRUE) #remove from search path if already listed
remove.packages("asymLD")
install.packages("http://www.uvm.edu/~rsingle/temp2/R/asymLD/asymLD_0.1.zip", repos = NULL, type = "source")

#------------------
require(plotrix)
require(asymLD)

data(hla.freqs)
hla.dr_dq <- hla.freqs[hla.freqs$locus1=="DRB1" & hla.freqs$locus2=="DQB1",]
compute.ALD(hla.dr_dq)

temp <- compute.AShomz(hla.dr_dq, sort.var=c("focal","allele"), sort.asc=c(T,T))
head(temp)
locus.name <- "DQB1"
dat <- temp[temp$focal==locus.name,]
rownames(dat) <- as.character(dat$allele)

par(mfrow=c(1,2))
dat1 <- as.data.frame(dat[,5])
dat2 <- as.data.frame(dat[,4])
color2D.matplot(dat1,
                show.values = 3,
                axes = FALSE,
                xlab = "",
                ylab = "",
                vcex = 1,
                vcol = "black",
                extremes = c("yellow", "red"))
axis(3, at = seq_len(ncol(dat1)) - 0.5, labels = names(dat)[5], tick = FALSE, cex.axis = 1)
color2D.matplot(dat2,
                show.values = 3,
                axes = FALSE,
                xlab = "",
                ylab = "",
                vcex = 1,
                vcol = "black",
                extremes = c("yellow", "red"))
axis(3, at = seq_len(ncol(dat2)) - 0.5, labels = names(dat)[4], tick = FALSE, cex.axis = 1)
axis(2, at = seq_len(nrow(dat)) -0.5, labels = rev(rownames(dat)), tick = FALSE, las = 1, cex.axis = 1)
axis(3, at = 0 , labels = locus.name, tick = FALSE, cex.axis = 1)