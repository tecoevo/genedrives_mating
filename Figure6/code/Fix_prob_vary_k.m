clc; clear; close all;
% This program simulates the results of figure panel 6A part-1 (mating network model of
% gene drive)

%% Initialization
n = 100;    % total population
P = 1;    % homing probablity/efficiency
pd = input('Enter the value of distortion probability, p: ');   % distorsion probability
% T = n*n*n;    % population is updated for t-generations
% lamda = n_m/n_f; % No. of males per female in the population.
c = 0;

% The gamete production probabilities matrix Q. It gives the probability of
% production of W, D and R gamete by six possible genotype: WW, WD, WR, DD,
% DR, and RR respectively. Matrix size is 6x3.
% Q = [1 0 0;(1-pd) pd*(1+P)/2 pd*(1-P)/2; 1/2 0 1/2; 0 1 0; 0 1/2 1/2; 0 0 1];
Q = [1 0 0;(1-pd) pd 0; 1/2 0 1/2; 0 1 0; 0 1/2 1/2; 0 0 1];

% Fertility fitness of genotype: WW, WD, WR, DD, DR, and RR respectively.
F = [1 1-c 1 (1-c)*(1-c) 1 1];

sim_N = 10000; % Number of trails/simulations
% k_vec = [4,6,8,10,12,14,16,32,64,n - 2];
k_vec = [4,8,16,32,99];
fixation_XDD = zeros(1,length(k_vec));
fixation_t = zeros(1,length(k_vec));
nk = 1;
theta = 1;
p_rewire = 1;

for k = k_vec
for j = 1:sim_N
% Population initialization
Pop = ones(1,n);    % Intial male population

% Only release of males (DD)

Pop(1:theta) = 4;

% Network of the Population 
k_min = 0;
n_component = 2;
while (n_component ~= 1) || (k_min <= 1)
    Net = small_world(n, k, p_rewire);
    n_component = networkComponents(Net); 
    k_min = min(sum(full(Net)));
end
Net = sparse(double(Net));
% Net = sparse(ones(n,n)-eye(n)); % complete graph

% Population frequency
X_WW = sum(Pop==1);
X_WD = sum(Pop==2);
X_DD = sum(Pop==4);

i = 1;

% Population update
while ( X_WW<n && X_WD<n ) && ( X_WD<n && X_DD<n ) && ( X_WW<n && X_DD<n )
        dead_ind = randi(n); % random individual is selected for death
        Parent = Pop(Net(dead_ind,:)==1); % possible parents
        
        % Step 1: Selecting parents with probability proportional to fitness.
        parents = datasample(Parent,2,'Replace',false,'Weights',F(Parent));
        parent_m = parents(1); % choosing male parent
        parent_f = parents(2); % choosing female parent
        
        % Step 2: Selecting offspring by accounting for the gene drive process
        Offspring_p(1) = (Q(parent_m,1)*Q(parent_f,1) + Q(parent_m,1)*Q(parent_f,1))/2;
        Offspring_p(2) = (Q(parent_m,1)*Q(parent_f,2) + Q(parent_m,2)*Q(parent_f,1));
        Offspring_p(3) = (Q(parent_m,1)*Q(parent_f,3) + Q(parent_m,3)*Q(parent_f,1));
        Offspring_p(4) = (Q(parent_m,2)*Q(parent_f,2) + Q(parent_m,2)*Q(parent_f,2))/2;
        Offspring_p(5) = (Q(parent_m,2)*Q(parent_f,3) + Q(parent_m,3)*Q(parent_f,2));
        Offspring_p(6) = (Q(parent_m,3)*Q(parent_f,3) + Q(parent_m,3)*Q(parent_f,3))/2;
        offspring = datasample(1:6,1,'Weights',Offspring_p); 
        
        Pop(dead_ind) = offspring; % birth
        
        % Updating the frequencies
        X_WW = sum(Pop==1);
        X_WD = sum(Pop==2);
        X_DD = sum(Pop==4);
        i = i + 1;
end
% disp(['sim# = ',num2str(j),' X_DD = ',num2str(X_DD)])

if X_DD == n
    fixation_t(nk) = fixation_t(nk) + i-1;
    fixation_XDD(nk) = fixation_XDD(nk) + 1;
end

end
k_vec(nk);
nk = nk + 1;
end
%% Output
filename1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_release_',num2str(theta),'.txt'];
filename2 = ['fixation_time_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_release_',num2str(theta),'.txt'];
filenamefig1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_release_',num2str(theta),'.eps'];
filenamefig2 = ['fixation_time_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_k_trail_',num2str(sim_N),'_release_',num2str(theta),'.eps'];

dlmwrite (num2str(filename1),[k_vec',fixation_XDD']);
dlmwrite (num2str(filename2),[k_vec',fixation_t']);

%% Uncomment to get the Figures
% fig1 = figure(1);
% 
% lineStyles = linspecer(3,'qualitative');
% 
% % Change default axes fonts.
% set(0,'DefaultAxesFontName', 'Arial')
% set(0,'DefaultAxesFontSize', 16)
% 
% % Change default text fonts.
% set(0,'DefaultTextFontname', 'Arial')
% set(0,'DefaultTextFontSize', 16)
% 
% width = 7.5;
% height = 5.5;
% fig.PaperPositionMode = 'manual';
% fig.PaperUnits = 'inches';
% fig.Units = 'inches';
% fig.PaperPosition = [0, 0, width, height];
% fig.PaperSize = [width, height];
% fig.Position = [0.1, 0.1, width-0.1, height-0.1];
% fig.Resize = 'off';
% fig.InvertHardcopy = 'off';
% 
% % Set up the axes properties
% ax = gca;
% ax.FontName = 'Arial';
% ax.Box = 'on'; % 'off'
% ax.LineWidth = 1.5;
% ax.FontSize = 18;
% set(gcf,'color','w');
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gcf,'color','w');
% 
% hold on
% p1 = plot(k_vec,fixation_XDD/sim_N,'.-');
% 
% hold on
% 
% % Set the plot p roperties
% p1.LineWidth = 3;
% p1.MarkerSize = 40;
% %p1.MarkerFaceColor = lineStyles(1,:);
% %p1.MarkerEdgeColor = lineStyles(1,:);
% p1.Color = lineStyles(1,:);
% 
% grid on
% box off
% xlabel('Average degree, k')
% ylabel('Fixation probability')
% % title(['k_{mf} = ',num2str(k_mf)])
% %legend(num2str(['Number of DD release = ',num2str(theta)]),'Location','NorthEast')
% %axis([0 k_vec(end)+2 0 0.1])
% % print('fixation_prob_rand_1_vary_kmf_trail_100_release_1.eps','-depsc')
% print(filenamefig1,'-depsc')
% 
% hold off;
% 
% fig2 = figure(2);
% width = 7.5;
% height = 5.5;
% fig.PaperPositionMode = 'manual';
% fig.PaperUnits = 'inches';
% fig.Units = 'inches';
% fig.PaperPosition = [0, 0, width, height];
% fig.PaperSize = [width, height];
% fig.Position = [0.1, 0.1, width-0.1, height-0.1];
% fig.Resize = 'off';
% fig.InvertHardcopy = 'off';
% 
% % Set up the axes properties
% ax = gca;
% ax.FontName = 'Helvetica';
% ax.Box = 'on'; % 'off'
% ax.LineWidth = 1.5;
% ax.FontSize = 18;
% set(gcf,'color','w');
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gcf,'color','w');
% hold on
% 
% p2 = plot(k_vec,fixation_t./(fixation_XDD*n),'.-');
% p2.LineWidth = 3;
% p2.MarkerSize = 40;
% grid on
% box off
% xlabel('Average degree, k')
% ylabel('Conditional fixation time')
% % title(['k_{mf} = ',num2str(k_mf)])
% %legend(num2str(['Number of DD release = ',num2str(theta)]),'Location','NorthEast')
% %axis([0 k_mf_vec(end)+2 0 0.1])
% % print('fixation_time_vary_rand_1_kmf_trail_100_release_1.eps','-depsc')
% print(filenamefig2,'-depsc')
% hold off;