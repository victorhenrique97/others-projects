passeio_circulo <- function(p, time){

	estados <- numeric() # vetor de estados
	estados[1] <- 0 # estado inicial

	for(i in 2:time){
		
		u <- runif(n=1, min = 0, max = 1) #gera em uma iteracao um valor entre (0,1)

		if(u<=p){
			if(estados[i-1] == 5){ # se tiver que avançar para frente e estiver em 5 volta para o zero
				estados[i] <- 0
			} else{
				estados[i] <- estados[i-1] + 1
			}
		}

		else{
			if(estados[i-1] == 0){ # se tiver que voltar um estado e estiver em zero vai para o cinco
				estados[i] <- 5
			} else{
				estados[i] <- estados[i-1] - 1
			}
		}
	}

	return (estados)
}

time <- 60
p <- 0.5
estados <- passeio_circulo(p, time)

#graficando a simulacao.
plot (c(0, time) , c(0, 5) , type = "n",
main = "Passeio aleatorio no circulo", xlab = "Tempo", ylab = "Estado")
grid (nx = NULL , ny = NULL , col = "lightgray", lty = "dotted", lwd = par("lwd") , equilogs = TRUE)
lines (0:(time -1) , estados , col ="indianred")