library("ShortRead")

arg <- commandArgs(trailingOnly=TRUE)
#make sure that exactly arg is entered
if (length(arg) > 1){
  stop('Stop: More than one file entered')
}
if (length(arg)== 0){stop('Stop: n files entered')
}

qqF <- qa(arg) #quality assessment
qqf.pc.qual <- qqF[["perCycle"]]$quality

pdf("q-graph.pdf")
print(ShortRead:::.plotCycleQuality(qqf.pc.qual))
dev.off()