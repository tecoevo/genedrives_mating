The matlab code 'mating_sys_time_fig4_data_only.m' generates the data for all the plots as shown in figure panel 4. 
To run the 'mating_sys_time_fig4_data_only.m' following functions are required: 'ode4.m', 'linspecer.m', 'fun_mating_gen_r.m'

Running the Matlab code 'mating_sys_time_fig4_data_only.m' will generate three data files for each subfigure of figure 4. 
- These data files are "Tcrit_medea_no_cost_new.txt", "Tcrit_distortion_no_cost_new.txt", and "Tcrit_distortion_cost_new.txt".
- First row and first column of the data file store the value of "r" and the efficiency of drive "p or d".
- The corresponding value of time until drive individuals (WD + DD) reaches 99% frequency is stored in the matrix form.

The Mathematica file names ' Fig4.nb generates all the three sub-figure of figure 4. It makes use of the data files "Tcrit_medea_no_cost_new.txt", "Tcrit_distortion_no_cost_new.txt", and "Tcrit_distortion_cost_new.txt".
