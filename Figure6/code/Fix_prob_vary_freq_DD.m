%clc; clear; close all;
k = input('Enter the value of average degree, k: ');
% This program simulates the results of figure panel 6B and C (mating network model of
% gene drive)
%% Initialization
n = 100;    % total population
P = 1;    % homing probablity/efficiency
pd = 0.95;   % distorsion probability
% T = n*n*n;    % population is updated for t-generations
% lamda = n_m/n_f; % No. of males per female in the population.
c = 0.5;

% The gamete production probabilities matrix Q. It gives the probability of
% production of W, D and R gamete by six possible genotype: WW, WD, WR, DD,
% DR, and RR respectively. Matrix size is 6x3.
% Q = [1 0 0;(1-pd) pd*(1+P)/2 pd*(1-P)/2; 1/2 0 1/2; 0 1 0; 0 1/2 1/2; 0 0 1];
Q = [1 0 0;(1-pd) pd 0; 1/2 0 1/2; 0 1 0; 0 1/2 1/2; 0 0 1];

% Fertility fitness of genotype: WW, WD, WR, DD, DR, and RR respectively.
F = [1 1-c 1 (1-c)*(1-c) 1 1];

sim_N = 10000;
% k_vec = [4,6,8,10,12,14,16,32,64,n - 2];
theta_vec = [1,5,10,20,30,40,50,60,70,80,100];
fixation_XDD = zeros(1,length(theta_vec));
fixation_t = zeros(1,length(theta_vec));
nk = 1;
% theta = 1;
p_rewire = 1;

for theta = theta_vec
for j = 1:sim_N
% Population initialization
Pop = ones(1,n);    % Intial male population

% Only release of males (DD)

Pop(1:theta) = 4;
% k = 8;
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
        
        X_WW = sum(Pop==1);
        X_WD = sum(Pop==2);
        X_DD = sum(Pop==4);
        i = i + 1;
end
% disp(['sim# = ',num2str(j),' X_DD = ',num2str(X_DD),' theta = ',num2str(theta)])

if X_DD == n
    fixation_t(nk) = fixation_t(nk) + i-1;
    fixation_XDD(nk) = fixation_XDD(nk) + 1;
end

end
nk = nk + 1;
end
%% Output
filename1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
filename2 = ['fixation_time_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.txt'];
filenamefig1 = ['fixation_prob_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.eps'];
filenamefig2 = ['fixation_time_rand_',num2str(p_rewire),'_p_',num2str(pd),'_c_',num2str(c),'_n_',num2str(n),'_vary_theta_trail_',num2str(sim_N),'_k_',num2str(k),'.eps'];

dlmwrite (num2str(filename1),[theta_vec',fixation_XDD']);
dlmwrite (num2str(filename2),[theta_vec',fixation_t']);
