percentile <- ecdf(1:10) # какой перцентиль занимает эта позиция из всей выборки
percentile(8)
[1] 0.8


# Как выбрать все ряды содержащие какое то значение или в каком то значении находящиеся
r<-Month5$Temp==66
o<-Month5[r,1]
vvv<-Month5[which(! Month5$Ozone  %in% o),]

# начертить интересный 3- д график
pca<-prcomp(res)
z<-as.matrix(pca$x)
p <- plot_ly(z = ~z[,1:3])
add_surface(p)
