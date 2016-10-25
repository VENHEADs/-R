ggplot(dd, aes(sc[,1],sc[,2], color = cl)) + geom_point() #6
sc<-pc$scores #5
pc<-princomp(d) #4
cl<-as.factor(cl) #3
cl<-km$cluster #2
km<-kmeans(d,10,algorithm = "MacQueen",iter.max = 50)  #1
