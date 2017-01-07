#!/usr/bin/env Rscript 

#######################################################
# Leishmanias VTM (LVTM)
# Dheeraj Lokam
# School of Human Evolution and Social Change
#######################################################
#########CONFIDENTIAL! DO NOT REDISTRIBUTE#############
#######################################################

args = commandArgs(trailingOnly=TRUE)

    print(args)
    param1 <- as.numeric(args[1])
    param2 <- as.numeric(args[2])
    param3 <- as.numeric(args[3])
    rm(args)

library(deSolve)
 LVTM <- function(time, state, parameters) {   
  with(as.list(c(state, parameters)), {

# Rate of change in Susceptible Humans      
     dSh <- (Nh * alpha_h) + (rho_r * Rh) - ((lambda_h + mu_h)*Sh)  
# Rate of change in people with early asymptomatic infection
     dEh <- (lambda_h * Sh) - ((alpha_1 + mu_h) * Eh)
# Rate of change in people with Late asymptomatic infection 
     dLh <- (rho_1 *Eh) - ((alpha_2 + mu_h)*Lh)
# Rate of change in symptomatic untreated patients
     dMh <- (alpha_2 * Lh) - (gamma_h + mu_h)*Mh
# Rate of change in people receiving incomplete treatment 
     dTh <- (fm * gamma_h * Mh) + (eta * Vh) - ((theta_1 + xi + mu_h) * Th)
# Rate of change in people who are temorarily recovered
     dVh <- (theta_1 * Th) - ((rho_v + eta + mu_h) * Vh)
# Rate of change in completely recovered patients
     dCh <- ((1-fm) * gamma_h *Mh) + (xi * Th) - ((theta_2 + mu_h) * Ch) 
# Rate of change in permanently recovered people
     dWh <- ((1-fp) * Vh * rho_v) + (theta_2 * Ch) - (mu_h * Wh)
# Rate of change in patients contracting PKDL
     dPh <- (fp * Vh * rho_v) - ((mu_h + rho_p) * Ph)
# Rate of change in patients recovered from PKDL
     dRh <- (Ph * rho_p) - ((mu_h + rho_r) * Rh)


# Rate of change in susceptible sandflies
     dSv <- (alpha_v * Nv * (1 - psi)) - ((lambda_v + mu_v) * Sv)
# Rate of change in exposed/latent infected Sandflies
     dEv <- (lambda_v * Sv) - ((alpha_3 + mu_v) * Ev)
# Rate of change in Infective sandflies
     dIv <- (alpha_3 * Ev) - (mu_v * Iv)

          return(list(c(dSh, dEh, dLh, dMh, dTh, dVh, dCh, dWh, dPh, dRh, dSv, dEv, dIv)))
   })
 }
# These are fixed parameters
 
 init <- c(Sh=10 , Eh=4, Lh=1, Mh=1, Th=1, Vh=1, Ch=2, Wh=3, Ph=4, Rh=3, Sv=10, Ev=100, Iv=90)
 parameters <- c(alpha_h=0.0309, alpha_v=195.6003, Nh=1102.39, Nv=987.63, alpha_1=0.002, alpha_2=0.006, alpha_3=0.006, theta_1=0.02, theta_2=0.0306, lambda_h=param1, lambda_v=param2, psi=param3, mu_h=0.0079, mu_v=0.0714, rho_1=0.03, fp=0.6, fm=0.4, gamma_h=0.04, xi=0.02, eta=0.04, rho_v=0.02, rho_p=0.04, rho_r=0.006)
 times <- seq(0, 70, by = 1)
 out <- as.data.frame(ode(y = init, times = times, func = LVTM, parms = parameters))
 out$time <- NULL
write.table(out, file = "datasheet.csv", sep = ",", eol = "\r\n", na="NA", dec=".", row.names = FALSE, col.names = TRUE) 
matplot(times, out, type = "l", xlab = "Time", ylab = "Number of humans/vectors in VTM compartments", main = "Leishmaniasis Vector Transmission Model", lwd = 1, lty = 1, bty = "l", col = 1:14)
legend(60, 250000, c("Sh", "Eh", "Lh", "Mh", "Th", "Vh", "Ch", "Wh", "Ph", "Rh", "Sv", "Ev", "Iv"), pch = 2, col = 1:14)
