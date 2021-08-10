close all; clear; clc

p_rewire = 1;
pd = 0.95;
k_vec = [4 8 16 99];
c = 0.5;
n = 100;
% theta = 1;
sim_N = 10000;

%lineStyles = linspecer(5,'qualitative');
lineStyles = (1/256)*[231, 188, 145;212, 162, 118;188, 138, 95;164, 113, 72];

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 22)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 22)

i = 1;
for k = k_vec
filename_k1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
filename_k2 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta1_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
% DD
Fixation_prob_k1 = dlmread(num2str(filename_k1));
fixation_XDD_k1 = Fixation_prob_k1(:,2);

% WD
Fixation_prob_k2 = dlmread(num2str(filename_k2));
fixation_XWD_k2 = Fixation_prob_k2(:,2);
theta_vec = Fixation_prob_k1(:,1);
pwd = (fixation_XWD_k2)/(sim_N);
qwd = 1 - (fixation_XWD_k2/sim_N);
pdd = (fixation_XDD_k1)/(sim_N);
qdd = 1 - (fixation_XDD_k1/sim_N);
% errorbar(theta_vec,pwd - pdd, sqrt( pdd.*qdd/sim_N + pwd.*qwd/sim_N ),'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:) );
hold on
plot(theta_vec,pwd - pdd,'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:));
i = i + 1;
end

grid off
box on
xlabel('Number of released transgenics (WD or DD) ','Fontsize',20)
%ylabel({'Difference in the fixation probability of';'heterozygotes compared to homozygotes'},'Fontsize',18)
ylabel({'Difference in the fixation prob.';' of heterozygotes compared';'to homozygotes'},'Fontsize',20)

legend('k = 4','k = 8','k = 16','k = 99','Location','NorthEast','Fontsize',20)
axis([0-7 k_vec(end)+8 -0.04 0.32])
pbaspect([1.    0.75    0.75])
% axis([0-5 k_vec(end)+8 -0.1 0.31])
% Set up the axes properties
set(gca,'XMinorTick','off','YMinorTick','off')
set(gcf,'color','w');

filenamefig1 = ['Diff_fixation_prob_vary_k_p1_rand',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_k_trail_',num2str(sim_N),'.eps'];
print(filenamefig1,'-depsc')
hold off;