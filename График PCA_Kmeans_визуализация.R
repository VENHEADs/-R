km<-kmeans(d,10,algorithm = "MacQueen",iter.max = 50)  #1 разбиваем на кластеры
cl<-km$cluster #2 переменная для кластерво и лементов
cl<-as.factor(cl) #3 делаем еее фактором
pc<-princomp(d) #4 делаем мг
sc<-pc$scores #5 сохраняем значения
ggplot(dd, aes(sc[,1],sc[,2], color = cl)) +ylim(-1*10^7,2.5*10^7)+geom_point()+labs ( colour = "Кластеры" ) # строим классный график с лимитами и цветом
lines(1:4,y[1:4],col="green")
