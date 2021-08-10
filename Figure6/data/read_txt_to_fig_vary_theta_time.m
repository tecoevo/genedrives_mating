close all; clear; clc

p_rewire = 1;
pd = 0.95;
k_vec = [4 8 16 32 99];
c = 0.5;
n = 100;
% theta = 1;
sim_N = 10000;

%lineStyles = linspecer(5,'qualitative');
lineStyles = (1/256)*[255, 201, 113;255, 182, 39;255, 149, 5;226, 113, 29;204, 88, 3];

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 22)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 22)

i = 1;
for k = k_vec
filename_k1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
filename_k2 = ['fixation_time_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
Fixation_prob_k = dlmread(num2str(filename_k1));
fixation_XDD_k = Fixation_prob_k(:,2);
Fixation_time_k = dlmread(num2str(filename_k2));
fixation_t_k = Fixation_time_k(:,2);
theta_vec = Fixation_prob_k(:,1);
plot(theta_vec,fixation_t_k./(fixation_XDD_k*n),'.-','LineWidth',3,'MarkerSize',30,'Color',lineStyles(i,:));
hold on
i = i + 1;
end

grid off
box on
xlabel('Number of released DD','Fontsize',22)
ylabel('Conditional fixation time for DD','Fontsize',22)
legend('k = 4','k = 8','k = 16','k = 32','k = 98','Location','Best','Fontsize',22)
axis([-8 k_vec(end)+10 -5 55])
% Set up the axes properties
set(gca,'XMinorTick','off','YMinorTick','off')
set(gcf,'color','w');
print('Fixation_time_vary_theta_k.eps','-depsc')
hold off;