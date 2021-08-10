The information contained in the data files could be deduced from the name of the text file.
For example, 'fixation_time_rand_1_p_0.95_c_0.5_n_100_vary_theta1_trail_10000_k_8.txt' contains the the value of fixation time for varying WD (WD=theta1, DD=theta) a completely random graph (rand = 1) with average network degree (k) = 8, distortion probability (p) = 0.95, fitness cost (c) = 0.5 and population size (n) = 100.

The matlab code generates the following figures from the data files:

- Figure A (part-1) : read_txt_to_fig_vary_k.m
- Figure A (part-2) : read_txt_to_fig_vary_theta.m
- Figure B (part-1): read_txt_to_fig_vary_releases.m
- Figure B (part-2): - read_txt2fig_diff_fix_prob.m
- Figure C : read_txt_to_fig_vary_theta_time.m