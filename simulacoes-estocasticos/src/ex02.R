ehrenfest <- function(max){ # a urna pode ter de zero a max estados

	M <- matrix (0, nrow = max+1, ncol = max+1)
	M[1,2] <- 1 #caso trivial, se nao tem bolinhas em um instante, no outro instante concerteza ira ter 1 com prob 1.
	M[max+1, max] <- 1 #caso trivial, se tem todas as bolinhas no proximo instante terá n-1 com prob 1

	for(i in 2: max){ #no prox passo, so pode ter uma bolinha a menos ou uma a mais, por isso que a matriz eh montada dessa maneira.
		M[i, i-1] <- (i-1)/max
		M[i, i+1] <- (max-i+1)/max
	}

	return (M)
}

potM <- function(M, n){ #funcao que faz a potencia das matrizes

	Maux <- M
	n = n-1

	while(n>0){
		Maux <- Maux%*%M
		n = n-1
	}
	return (Maux)
}

autoM <- function(M, n){ #receba a matriz e a potencia a ser calculada pelo metodos dos autovalores.

	auto <- eigen(t(M)) #decomposicao espectral de uma matriz.
	Q <- as.matrix(auto$vectors) #atribuindo os autovetores a uma matriz de consulta.
	DK <- diag(auto$values^n) # uma vez que eh uma matriz diagonal, para operar com potencia sobre ela basta elevar cada elemento a potencia desejada.
	
	return (t(Q%*%DK%*%solve(Q))) # onde solve irá inverter a matriz e %*% faz a multiplicacao de matriz.
}

M <- ehrenfest(4)

cat("\n\nM elevada a 37:\n")
print(potM(M,37))

cat("\nM elevada a 38:\n")
print(potM(M,38))

cat("\nM elevada a 39:\n")
print(potM(M,39))

cat("\nM elevada a 40:\n")
print(potM(M,40))

cat("\n\nAutovalores da transposta da matriz de transicao:\n", eigen(t(M))$values, "\n\n")




