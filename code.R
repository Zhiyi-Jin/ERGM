library(sna)
library(ergm)
library(network)
library(stargazer)

#load the data
load("SNA2020-24.RData")

#select the data and drop the “structurally absent” actors
fri1 <- fri[[1]][!str.abs[,1],!str.abs[,1]]
fri1 <- network(fri1)

#variable-sex: 0-male, 1-female
fem[fem == 0] <- "Male"
fem[fem == 1] <- "Female"
fri1 %v% "sex" <- as.character(fem)

#Plot the observed one
plot(fri1, vertex.col = "sex", edge.col = "grey", main = "Observed Network")

#fit models
m1 <- fri1 ~ edges + mutual + nodematch("sex") + gwesp(0.5,fixed=TRUE) + twopath
m1.result <- ergm(m1)

m2 <- fri1 ~ edges +  nodematch("sex") + twopath
m2.result <- ergm(m2)

m3 <- fri1 ~ edges + mutual + gwesp(0.5,fixed=TRUE) + twopath

#make the table
stargazer(m1.result, m2.result, m3.result, type = "html",
          dep.var.labels.include = F,
          title = "<b>Summary of Models Fit<b>")

#simulate 100 networks from each model
sims1 <- simulate(m1.result, nsim = 100)
sims2 <- simulate(m2.result, nsim = 100)
sims3 <- simulate(m3.result, nsim = 100)

par(mfrow=c(2,2))
#Plot the observed one:
plot(fri1, vertex.col = "sex", edge.col = "grey", main = "Observed Network")

#Plot the simulated ones:
plot(sims1[[1]], vertex.col = "sex", edge.col = "grey", main = "Simulated-Model 1")
plot(sims2[[1]], vertex.col = "sex", edge.col = "grey", main = "Simulated-Model 2")
plot(sims3[[1]], vertex.col = "sex", edge.col = "grey", main = "Simulated-Model 3")

#Model 1 VS. Observed
par(mfrow=c(3,4))
#compare the density with observed data(red line)
lines(rep(gden(fri1),2),c(0,max(hist(gden(sims1),
                                     xlim=c(0.05,0.2), 
                                     main=c("Model 1 - Density"),
                                     xlab=c("Density"))$counts)),col="red",lwd=2)

#compare the recipricity with observed data
lines(rep(grecip(fri1,measure='edgewise'),2),
      c(0,max(hist(grecip(sims1,measure='edgewise'),
                   xlim=c(0,1),
                   main=c("Reciprocity"),
                   xlab=c("Reciprocity"))$counts)),col="red",lwd=2)

#compare the transitivity with observed data
lines(rep(gtrans(fri1),2),c(0,max(hist(gtrans(sims1),
                                       xlim=c(0,0.7),
                                       main=c("Transitivity"),
                                       xlab=c("Transitivity"))$counts)),col="red",lwd=2)

#compare sex homophily
gender.homophily <- function(net){
  require(ergm) 
  model <- net ~ edges + nodematch("sex") 
  statistics <- summary(model)
  result <- statistics[2]/statistics[1]
  return(result)
}

homophily1 <- c()
for (i in 1:100) {
  homophily1[i] <- gender.homophily(sims1[[i]])
}
lines(rep(gender.homophily(fri1),2),c(0,max(hist(homophily1,
                                                 xlim = c(0.2,1),
                                                 main = c("Gender Homophily"),
                                                 xlab = c("Homophily"))$counts)),col="red",lwd=2)

#Model 2
lines(rep(gden(fri1),2),c(0,max(hist(gden(sims2), 
                                     xlim=c(0.05,0.2),
                                     main=c("Model 2 - Density"),
                                     xlab=c("Density"))$counts)),col="red",lwd=2)
lines(rep(grecip(fri1,measure='edgewise'),2),
      c(0,max(hist(grecip(sims2,measure='edgewise'),
                   xlim=c(0,1),
                   main=c("Reciprocity"),
                   xlab=c("Reciprocity"))$counts)),col="red",lwd=2)
lines(rep(gtrans(fri1),2),c(0,max(hist(gtrans(sims2),
                                       xlim=c(0,0.7),
                                       main=c("Transitivity"),
                                       xlab=c("Transitivity"))$counts)),col="red",lwd=2)

homophily2 <- c()
for (i in 1:100) {
  homophily2[i] <- gender.homophily(sims2[[i]])
}
lines(rep(gender.homophily(fri1),2),c(0,max(hist(homophily2,
                                                 xlim = c(0.2,1),
                                                 main=c("Gender Homophily"),
                                                 xlab=c("Homophily"))$counts)),col="red",lwd=2)

#Model 3
lines(rep(gden(fri1),2),c(0,max(hist(gden(sims3),
                                     xlim=c(0.05,0.2),
                                     main=c("Model 3 - Density"),
                                     xlab=c("Density"))$counts)),col="red",lwd=2)
lines(rep(grecip(fri1,measure='edgewise'),2),
      c(0,max(hist(grecip(sims3,measure='edgewise'),
                   xlim=c(0,1),
                   main=c("Reciprocity"),
                   xlab=c("Reciprocity"))$counts)),col="red",lwd=2)
lines(rep(gtrans(fri1),2),c(0,max(hist(gtrans(sims3),
                                       xlim=c(0,0.7),
                                       main=c("Transitivity"),
                                       xlab=c("Transitivity"))$counts)),col="red",lwd=2)

homophily3 <- c()
for (i in 1:100) {
  homophily3[i] <- gender.homophily(sims3[[i]])
}
lines(rep(gender.homophily(fri1),2),c(0,max(hist(homophily3,
                                                 xlim = c(0.2,1),
                                                 main = c("Gender Homophily"),
                                                 xlab = c("Homophily"))$counts)),col="red",lwd=2)
