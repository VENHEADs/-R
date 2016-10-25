ggplot(dd, aes(sc[,1],sc[,2], color = cl),ymi) +ylim(-1*10^7,2.5*10^7)+geom_point()+labs ( colour = "Кластеры" ) # строим классный график с лимитами и цветом
sc<-pc$scores #5 сохраняем значения
pc<-princomp(d) #4 делаем мгк
cl<-as.factor(cl) #3 делаем еее фактором
cl<-km$cluster #2 переменная для кластерво и лементов
km<-kmeans(d,10,algorithm = "MacQueen",iter.max = 50)  #1 разбиваем на кластеры
