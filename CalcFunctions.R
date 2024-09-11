x <- seq(0, 2, length=100)
plot(x, log(x), type="l")
abline(h=0, v=0, col = "blue")

x <- seq(-2, 2, length=100)
plot(x, exp(x), type="l")
abline(h=0, v=0, col = "blue")

x <- seq(-4,4, length = 100)
fx <- (1/sqrt(2*pi))*exp(-.5*(x^2))
plot(x, fx, type="l")
abline(h=0, v=0,col="blue")
