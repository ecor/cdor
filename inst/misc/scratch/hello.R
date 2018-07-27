
## Input data

x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 100000

## parallel time 
ptime <- system.time({
			 r <- foreach(icount(trials), .combine=cbind) %dopar% {
			ind <- sample(100, 100, replace=TRUE)
		    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
		    coefficients(result1)
			}
			})[3]
ptime

## sequential time 

stime <- system.time({
			 r <- foreach(icount(trials), .combine=cbind) %do% {
			 ind <- sample(100, 100, replace=TRUE)
			 result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
			 coefficients(result1)
			 }
			})[3]
stime
