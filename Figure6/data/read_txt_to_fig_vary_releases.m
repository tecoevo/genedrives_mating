close all; clear; clc

p_rewire = 1;
pd = 0.95;
k = 99;
c = 0.5;
n = 100;
% theta = 1;
sim_N = 10000;

%lineStyles = linspecer(2,'qualitative');

lineStyles = [0.68    0.68    0.68; 0.9153    0.2816    0.2878];
%lineStyles = (1/256)*[221, 44, 47;256*0.3467, 256*0.5360, 256*0.6907];

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 22)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 22)


filename_k = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
Fixation_prob_k = dlmread(num2str(filename_k));
fixation_XDD_k = Fixation_prob_k(:,2);
theta_vec = Fixation_prob_k(:,1);
pdd = (fixation_XDD_k)/(sim_N);
qdd = 1 - (fixation_XDD_k/sim_N);
plot(theta_vec,pdd,'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(2,:));
% errorbar(theta_vec,pdd, sqrt( pdd.*qdd/sim_N ),'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:) );
hold on

filename_k = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta1_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
Fixation_prob_k = dlmread(num2str(filename_k));
fixation_XDD_k = Fixation_prob_k(:,2);
theta_vec = Fixation_prob_k(:,1);
pdd = (fixation_XDD_k)/(sim_N);
qdd = 1 - (fixation_XDD_k/sim_N);
plot(theta_vec,pdd,'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(1,:));

grid off
box on
xlabel('Number of released transgenics (DD or WD)','Fontsize',22)
ylabel('Fixation probability (DD or WD)','Fontsize',22)
%legend('Average no. of neighbours = 8','Average no. of neighbours = 32','Location','Best','Fontsize',18)
legend('DD release','WD release','Location','Best','Fontsize',22)
axis([-10 99+10 -0.1 1.1])
pbaspect([1.0000    0.75    0.75])
% Set up the axes properties
set(gca,'XMinorTick','off','YMinorTick','off')
% ax = gca;
% ax.XGrid = 'off';
% ax.YGrid = 'on';
set(gcf,'color','w');
print('Fixation_prob_vary_type_releases.eps','-depsc')
hold off;