
potM <- function(M, n){ #Funcao para calcular a n-esima potencia de uma matriz.
	if (n == 1) return (M)
	if (n > 1) return (M %*% potM (M, n-1))
}

autoM <- function(M, n){ #receba a matriz e a potencia a ser calculada pelo metodos dos autovalores.

	auto <- eigen(t(M)) #decomposicao espectral de uma matriz.
	Q <- as.matrix(auto$vectors) #atribuindo os autovetores a uma matriz de consulta.
	DK <- diag(auto$values^n) #matriz diagonal elevada a n eh igual ao seus elementos elevados a n
	
	return (t(Q%*%DK%*%solve(Q))) # onde solve irá inverter a matriz e %*% faz a multiplicacao de matriz.
}

M = matrix(						#preenchendo os valores da matriz.
		c(0.3, 0.3, 0.4, 0.2, 0.6, 0.2, 0, 0, 1),
		nrow = 3,
		ncol = 3,
		byrow = TRUE
	)

cat("\nResultado obtido pelo metodo dos autovalores:", autoM(M,3)[1,3])
cat("\nResultado obtido pelo metodo das potencias:", potM(M,3)[1,3],"\n\n")


