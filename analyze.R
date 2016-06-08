#!/usr/bin/Rscript

# First convert from kB/s to GB/sec
d<- read.csv('output.csv')
d1=subset(d, select=-c(read_bw_k,write_bw_k))
d1$read_bw_G=round(d$read_bw_k/1024/1024,3)
d1$write_bw_G=round(d$write_bw_k/1024/1024,3)
write.csv(d1, 'output.G.csv', row.names=FALSE)

require(ggplot2)
require(dplyr)
require(reshape2)
df <- read.csv('output.csv')
df1 <- tbl_df(df)
rm(df)
df2 <- melt(df1, id=c("test", "queue_depth"))
df3 <- filter(df2, value>0 & (variable=="read_bw_k" | variable=="write_bw_k"))
df4 <- mutate(df3, direction=ifelse(variable=="read_bw_k", "read", "write"))

svg("bandwidth.svg", width=8, height=6)
p <- ggplot(df4, aes(x=queue_depth, y=value/1024/1024, color=test, linetype=direction))
title_str <- "FIO bandwidth test"
p <- p + geom_line() + ggtitle(title_str)
p <- p + xlab("Queue depth") + ylab("Bandwidth [ GB/s ]")
p <- p + scale_x_continuous(breaks=unique(df4$queue_depth))
print(p)
tmp <- dev.off()

df3 <- filter(df2, value>0 & (variable=="read_iops" | variable=="write_iops"))
df4 <- mutate(df3, direction=ifelse(variable=="read_iops", "read", "write"))
svg("iops.svg", width=8, height=6)
p <- ggplot(df4, aes(x=queue_depth, y=value, color=test, linetype=direction))
title_str <- "FIO IOPS test"
p <- p + geom_line() + ggtitle(title_str)
p <- p + xlab("Queue depth") + ylab("IOPS")
p <- p + scale_x_continuous(breaks=unique(df4$queue_depth))
print(p)
tmp <- dev.off()
