### This code is associated with the paper "On the effect of mating complexity on gene drive dynamics".


## Overview ##

This repository contains and all of the code and data required to reproduce the figures presented in: *On the effect of mating complexity on gene drive dynamics*.

All the final figures are also included in the repository. The code included comes in two types:

1. Code for running numerical simulations and generating data (written in a mixture of Matlab and Mathematica)
2. Code for loading the numerical simulation data and plotting it to reproduce the figures as shown in the text (written in Matlab and Mathematica)

The following description addresses these two steps separately.

## Generating numerical simulation data ##

For figures 3 and 6, the data is generated by Matlab code, which can be found in the directory "code/". The  code runs simulations and saves data specifically for each of these figures, and the data is stored in the same directory where the code runs. For all the other figures, the figures are generated directly in Matlab or Mathematica file, so no data storage is required for these cases.


## Plotting data from numerical simulations to reproduce the figures ##

For figures 3 and 6, once the data is generated (or downloaded from the repository) for a figure that you're interested in generating, navigate to the directory "data/". There, Matlab code can be found for automatic generation of each figure. For generating the figure of your choice, place the data file of the corresponding figure in the same directory where the code for generating that figure is placed. Run the corresponding code to generate the required figure.

For figures 3 and 6, data corresponding to the figures in the manuscript can also be downloaded directly from the "data/" subdirectories here in the repository and plotted as described in the paragraph above without re-generating it via Matlab code in "code".
