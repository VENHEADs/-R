pca<-prcomp(res)
z<-as.matrix(pca$x)
p <- plot_ly(z = ~z[,1:3])
add_surface(p)
