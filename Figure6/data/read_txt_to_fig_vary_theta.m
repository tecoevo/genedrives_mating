close all; clear; clc

p_rewire = 1;
pd = 0.95;
k_vec = [4 8 16 32 99];
c = 0.5;
n = 100;
% theta = 1;
sim_N = 10000;

% lineStyles = linspecer(5,'qualitative');
lineStyles = (1/256)*[241, 167, 169;236, 131, 133;230, 96, 99;227, 80, 83;221, 44, 47];

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 22)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 22)

i = 1;
for k = k_vec
filename_k = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
Fixation_prob_k = dlmread(num2str(filename_k));
fixation_XDD_k = Fixation_prob_k(:,2);
theta_vec = Fixation_prob_k(:,1);
pdd = (fixation_XDD_k)/(sim_N);
qdd = 1 - (fixation_XDD_k/sim_N);
plot(theta_vec,pdd,'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:));
% errorbar(theta_vec,pdd, sqrt( pdd.*qdd/sim_N ),'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:) );
hold on
i = i + 1;
end

grid off
box on
xlabel('Number of released DD','Fontsize',22)
ylabel('Fixation probability of DD','Fontsize',22)
%legend('Average no. of neighbours = 8','Average no. of neighbours = 32','Location','Best','Fontsize',18)
legend('k = 4','k = 8','k = 16','k = 32','k = 99','Location','SouthEast','Fontsize',22)
axis([-8 99+8 -0.08 1.09])
% Set up the axes properties
set(gca,'XMinorTick','off','YMinorTick','off')
set(gcf,'color','w');
print('Fixation_prob_vary_theta.eps','-depsc')
hold off;