% This code plots graphs for figure panel 4 of the manuscript.

%% Distortion Drive with no cost
clc, clear; % close all;
xdd0 = 0.01; % initial DD frequency 
tspan = 0:0.1:1000; % time for which population is evolved
d = 0; % Medea drive efficiency
c = 0; % fitness cost (fertility)
fww=1; % Fitness of WW
fwd=1-c; % Fitness of WD
fdd=(1-c)*(1-c); % Fitness of DD
pmin = 0.51; pmax = 1; % probability of distortion limit
p_vec = pmin:0.01:pmax; % probability of distortion
% d_vec = 0:0.1:1;
r_vec = [1,2,3,4,5]; % Degree of plogygamy
T_crit = zeros(length(p_vec),length(r_vec));
clen = [1,2,3,4,5,6,8,10];

% Generates colors for each case of 'r'
C_big = linspecer(length(clen));
C(1,:) = 0.1*[1 1 1];
C(2,:) = C_big(2,:);
C(3,:) = C_big(3,:);
C(4,:) = C_big(4,:);
C(5,:) = C_big(5,:);

i = 1;
j = 1;
% Loop over ;p'
for p = p_vec
    j = 1;
    % Loop over 'r'
    for r = r_vec
    
    X1 = ode4(@(t,X1)fun_mating_gen_r(t,X1,fww,fwd,fdd,p,d,r),tspan,[(1-xdd0);xdd0]);
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + (1 - X1(:,1)-X1(:,2)))>0.99)));
    j = j + 1;
    end
    i = i + 1;
end

%% Output data save
dlmwrite ('Tcrit_distortion_no_cost.txt', [[0,r_vec];[p_vec',T_crit]])
%% Distortion Drive with cost
clc, clear; % close all;

xdd0 = 0.01;  % initial DD frequency 
tspan = 0:0.05:1000; % time for which population is evolved
d = 0; % Medea drive efficiency
c = 0.2; % fitness cost (fertility)
fww=1; % Fitness of WW
fwd=1-c; % Fitness of WD
fdd=(1-c)*(1-c); % Fitness of DD
pmin = 0.635; pmax = 1; % probability of distortion limit
p_vec = pmin:0.01:pmax;
% d_vec = 0:0.1:1;
r_vec = 1:10; % [1,2,4,6,8,10]; % Degree of plogygamy
T_crit = zeros(length(p_vec),length(r_vec));
clen = [1,2,3,4,5,6,8,10];

% Generates colors for each case of 'r'
C_big = linspecer(length(clen));
C(1,:) = 0.1*[1 1 1];
C(2,:) = C_big(2,:);
C(3,:) = C_big(4,:);
C(4,:) = C_big(6,:);
C(5,:) = C_big(7,:);
C(6,:) = C_big(8,:);

i = 1;
j = 1;
% Loop over 'p'
for p = p_vec
    j = 1;
    % Loop over 'r'
    for r = r_vec

    X1 = ode4(@(t,X1)fun_mating_gen_r(t,X1,fww,fwd,fdd,p,d,r),tspan,[(1-xdd0);xdd0]);
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + (1 - X1(:,1)-X1(:,2)))>0.99)));
    j = j + 1;
    end
    i = i + 1;
end

%% Output data save
dlmwrite ('Tcrit_distortion_cost.txt', [[0,r_vec];[p_vec',T_crit]])


%% Medea Drive with no cost
clc, clear; %close all;

xdd0 = 0.1;
tspan = 0:0.2:15000;
p = 0.5;
c = 0;
fww=1;
fwd=(1-c);
fdd=(1-c)*(1-c);
dmin = 0.02; dmax = 1;
d_vec = dmin:0.01:dmax;
r_vec = [1,2,3,4,5];
T_crit = zeros(length(d_vec),length(r_vec));

clen = [1,2,3,4,5,6,8,10];
C_big = linspecer(length(clen));
C(1,:) = 0.1*[1 1 1];
C(2,:) = C_big(2,:);
C(3,:) = C_big(3,:);
C(4,:) = C_big(4,:);
C(5,:) = C_big(5,:);

i = 1;
j = 1;
for d = d_vec
    j = 1;
    for r = r_vec

    X1 = ode4(@(t,X1)fun_mating_gen_r(t,X1,fww,fwd,fdd,p,d,r),tspan,[(1-xdd0);xdd0]);
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + (1 - X1(:,1)-X1(:,2)))>0.99)));
    
    j = j + 1;
    end
    i = i + 1;
end

%% Output data save
dlmwrite ('Tcrit_medea_no_cost.txt', [[0,r_vec];[d_vec',T_crit]])

%% Medea Drive with cost
clc, clear; %close all;

xdd0 = 0.1;
tspan = 0:0.2:15000;
p = 0.5;
c = 0.2;
fww=1;
fwd=(1-c);
fdd=(1-c)*(1-c);
dmin = 0.02; dmax = 1;
d_vec = dmin:0.01:dmax;
r_vec = [1,2,3,4,5];
T_crit = zeros(length(d_vec),length(r_vec));

clen = [1,2,3,4,5,6,8,10];
C_big = linspecer(length(clen));
C(1,:) = 0.1*[1 1 1];
C(2,:) = C_big(2,:);
C(3,:) = C_big(3,:);
C(4,:) = C_big(4,:);
C(5,:) = C_big(5,:);

i = 1;
j = 1;
for d = d_vec
    j = 1;
    for r = r_vec

    X1 = ode4(@(t,X1)fun_mating_gen_r(t,X1,fww,fwd,fdd,p,d,r),tspan,[(1-xdd0);xdd0]);
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + (1 - X1(:,1)-X1(:,2)))>0.99)));
    
    j = j + 1;
    end
    i = i + 1;
end

%% Output data save
dlmwrite ('Tcrit_medea_with_cost.txt', [[0,r_vec];[d_vec',T_crit]])