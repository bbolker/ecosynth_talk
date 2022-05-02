nc <- 100 ## number of communities
ns <- 100 ## samples per community
gm <- 0.9 ## grand mean

## community means
comm_means <- rnorm(nc,mean=qlogis(gm))
## uncertainty around community means
comm_matrix <- matrix(rnorm(nc*ns),nrow=nc) + comm_means

## nonlinear transformation
t_vals <- plogis(comm_means)
mean(t_vals)
sd(t_vals)

m_vals <- plogis(comm_matrix)
mean(m_vals)
sd(m_vals)

## in this case: mean decr (as expected), sd increases

## density plots
plot(density(t_vals))
lines(density(m_vals),col=2)

## could a skewed distribution have an effect?
## what if we write this out in terms of expectations/Taylor expansions?

## JI approx
## E[f(x)]  ~ E[f(x^)+(x-x^)*f'(x)+(x-x^)^2/2*f''(x) + ...]

## variance
## E[(f(x)-E[f(x)])^2] =
## E[((f(x^)+(x-x^)*f'(x^)+(x-x')^2/2*f''(x^))-(f(x^)+f''(x^)/2*V))^2] = 
## ...
## this seems to come out to the usual (f'(x))^2*V to first order ...
