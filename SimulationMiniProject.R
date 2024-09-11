#Effect of Correlation on Confidence Intervals

### PROBLEM 1 ###
## Write a function sim_AR1 with arguments n, phi
      # (use the value 1 for sigma_epsilon)
sim_AR1 <- function(n, phi){
  
  simdata_AR1 <- rep(0, n)
  
  for(i in 1 : n){
    if(i == 1){
      simdata_AR1[1] <- rnorm(1, mean = 0, sd = 1 / sqrt(1 - phi^2))
    } else{
    simdata_AR1[i] <- phi * simdata_AR1[i - 1] + rnorm(1, mean = 0, sd = 1)
    }
  }
  return(simdata_AR1)
}

# Test your code
ts.plot(sim_AR1(n = 100, phi = 0.6))



### Problem 2 ###
## Write code to generate one dataset from an AR(1), compute the 95% CI for 
# using t.test, and extract the lower & upper CI bounds from the t.test result

#generate n observations from AR(1) with specified phi
sample <- sim_AR1(n = 100, phi = 0.6)
#compute 95% CI for mu using t.test
out <- t.test(sample)
# extract the lower bound of the CI from the t.test result
lower <- out$conf.int[1]
# extract the upper bound of the CI from the t.test result
upper <- out$conf.int[2]
lower
upper



### Problem 3 ###
# Write a function sim_MP to perform simulation
# arguments are n, phi
# returns value of proportion of CIs that contain zero

sim_MP <- function(n, phi){
  Nsim = 10000
  CI_L <- rep(0, Nsim)
  CI_U <- rep(0, Nsim)
  for(i in 1 : Nsim){
    out <- t.test(sim_AR1(n, phi))
    lower <- out$conf.int[1]
    upper <- out$conf.int[2]
    CI_L[i] = lower
    CI_U[i] = upper
  }
  return(mean(CI_U > 0 & CI_L < 0))
}
# Compute the proportion of CIs that contain zero
# (as the last line, this will be the value returned by the function)

# Test your code
sim_MP(n = 100, phi = 0)
