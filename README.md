# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

| :exclamation: Important Note            |
|-----------------------------------------|

## Please fill in your project documentation in this README.md file 

Project for internship

## Poisson analysis of arbiter:
Assuming a 1KHz spike rate for 1 neuron, with an array of 16 neurons and a clock speed of 40MHz we obtain 16000 firings per second = 16e-6 firings per nanosecond = 4e-4 firings per clock period. Using the poisson distribution with lambda = 4e-4 we get that the probability of more than one firing per clock cycle is zero.

Now to compute the number of neurons for which less than 99% of the requests will be handled in 1 clock cycle. For 99% of requests to be handled in 1 cycle, 99% of cycles should have only 1 request or less, as we can process one request per clock cycle. Thus the amount of cycles where more than 1 request arrives should be equal to or less than 1% (P(x > 1) < 0.01). So to break this, we need to find lambda such that P(x > 1) >= 0.01. Such a lambda is around 0.15. Which means there should be around 6 million events per second, which means this should be around 6000 neurons. This is a rough estimation for two reasons, first when three requests arrive in 1 clock cycle, two requests are not handled within one clock cycle but with this method we only count one, second this is excluding delay effects of adding this many arbiter branches, which could lead to a request taking more than 1 clock cycle to be processed, in this case the amount of neurons will decrease linearly with the increase in clock cycles per request.