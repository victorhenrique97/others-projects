catarinafunc <- function(t_catarina, t_end, lambda){

	times <- numeric(0)
	i <- 1
	current_time <- 0 #tempo comeca em zero

	while(current_time < t_end){
		times[i] <- current_time
 		current_time <- current_time + rexp(1 , rate = 5.5) #tempo de saida dos onibus
		i <- i+1
 	}
 	index_catarina_bus <- min(which(times > t_catarina)) #descobrindo o onibus que a catarina pegou
 	wait_time <- times[index_catarina_bus] - t_catarina 
 	interval_time <- times[index_catarina_bus] - times[index_catarina_bus-1] # tempo entre o onibus dela e o anterior

 	return(list(interval_time,wait_time))
} 
	
	wait_time <- 0
	for(i in 1:1000){
		data <- catarinafunc(0.75, 7, 5.5)
		wait_time <- wait_time + data[[2]]
	}
	cat("\nTempo de espera da Catarina:", wait_time/1000, "\n")

	interval <- 0
	wait_time <- 0
	for(i in 1:1000){
		data <- catarinafunc(3.5,7, 5.5)
		interval <- interval + data[[1]]
		wait_time <- wait_time + data[[2]]
	}
	cat("\nMedia dos intervalos:", interval/1000, "Tempo de espera da Catarina(x2):", wait_time/500, "\n\n")
