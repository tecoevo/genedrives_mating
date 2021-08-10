close all; clear; clc

p_rewire = 1;
pd = 0.5;
pd_vec = [0.8 0.95 1];
c = 0.5;
n = 100;
theta = 1;
sim_N = 10000;

%filename1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_release_',num2str(theta),'.txt'];
%Fixation_prob_neutral = dlmread(num2str(filename1));
% 
%k_vec = Fixation_prob_neutral(:,1);
%fixation_XDD = Fixation_prob_neutral(:,2);

%lineStyles = linspecer(3,'qualitative');
lineStyles = (1/256)*[241, 167, 169;230, 106, 109;221, 44, 47];

% lineStyles = 1/256*[207, 177, 238; 160, 98, 221; 112, 20, 204];

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 22)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 22)

i = 1;
for pd = pd_vec
filename_p = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_release_',num2str(theta),'.txt'];
Fixation_prob_p = dlmread(num2str(filename_p));
fixation_XDD_p = Fixation_prob_p(:,2);
k_vec = Fixation_prob_p(:,1);
% plot(k_vec,fixation_XDD_p./fixation_XDD,'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:));
p1 = plot(k_vec,fixation_XDD_p/sim_N,'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:));
%alpha(p1,.2)
hold on
i = i + 1;
end

grid off
box on
filenamefig1 = ['Combined_fixation_prob2_vary_k_p1_rand',num2str(p_rewire),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_theta_',num2str(theta),'.eps'];
xlabel('Average degree, k','Fontsize',22)
% ylabel('^{\phi}/_{\phi_{0}}','Fontsize',24)
ylabel('Fixation probability of DD','Fontsize',22)
legend('p = 0.80','p = 0.95','p = 1.00','Location','Best','Fontsize',22)
axis([-2 k_vec(end)+5 -0.025 0.31])
pbaspect([1.0000    0.75    0.75])
% Set up the axes properties
set(gca,'XMinorTick','off','YMinorTick','off')
set(gcf,'color','w');
% print('Fixation_prob_ratio_vary_k_p1.eps','-depsc')
print(filenamefig1,'-depsc')
hold off;