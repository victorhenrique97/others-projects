xcsv <- as.matrix(unname(read.csv("base02coord_x.csv", header = TRUE)))
ycsv <- as.matrix(unname(read.csv("base02coord_y.csv", header = TRUE)))

#plot(xcsv, ycsv, col = "red" ,main = "Processos de poisson bi-dimensionais", ylab = "Y", xlab = "X") funcao que plota o csv

counter <- 0
lim <- 4

for(i in (0:4)){

	counter <- 0
	lim <- 5-i

	for(j in (1:length(xcsv))){
		if(xcsv[j] < lim && ycsv[j] < lim){
			counter = counter + 1
		}
	}

	cat("\n Area:",lim*lim,"Pontos:",counter,"Pontos estimados",lim*lim*4,"\n")

}
