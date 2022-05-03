The given Matlab codes simulate the results for figure panel C1. Simulation of results for figure C1 requires the user to the input value of average network degree 'k' and the fitness cost 'c' and distortion probability 'p'.

Code file Fix_prob_vary_freq_DD.m generates data file for figure C1.

The information contained in the data files could be deduced from the name of the text file.
For example, 'fixation_time_rand_1_p_0.95_c_0.5_n_100_vary_theta1_trail_10000_k_8.txt' contains the the value of fixation time for varying WD (WD=theta1, DD=theta) a completely random graph (rand = 1) with average network degree (k) = 8, distortion probability (p) = 0.95, fitness cost (c) = 0.5 and population size (n) = 100.

The above main simulation file requires the following functions: networkComponents.m, small_world.m and linspecer.m.

The generated data files for all the cases are collated to produce the respective figures C1 from the Mathematica file "FigC1.nb".

The Mathematica file "FigC1.nb" also generates a corresponding GIF for figure C1.
