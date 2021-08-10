% This code plots graphs for figure panel 4 of the manuscript.

%% Distortion Drive with no cost
clc, clear; % close all;
xdd0 = 0.01; % initial DD frequency 
tspan = 0:0.01:1000; % time for which population is evolved
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
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + 0.5*(1 - X1(:,1)-X1(:,2)))>0.99)));
    j = j + 1;
    end
    i = i + 1;
end

%% Output-2
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

% Semi-Log plot
axes('NextPlot','replacechildren', 'ColorOrder',C);
plt1 = semilogy(p_vec,(T_crit),'-','Linewidth',4)

xlabel('Distortion probability, p','FontSize' , 22)
ylabel({'Time until Drive allele';'reaches 99% frequency'},'FontSize' , 22)
% axis([pmin-0.05 1.05 -0.05 1.05])
% xlim([pmin-0.05-0.05 pmax+0.05])
ax = gca; % current axes
axis(ax, 'tight')   % where ax is your axis handle.
xlim(ax, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.05)
ylim(ax, [3,2*max(max(T_crit))] )
pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
set(gcf, 'PaperPositionMode', 'auto');
print('mat_sys_log_p_c_0.eps','-depsc')

figure()
axes('NextPlot','replacechildren', 'ColorOrder',C);
plot(p_vec,T_crit./T_crit(:,1),'-','Linewidth',4)
xlabel('Distortion probability, p','FontSize' , 22)
ylabel({'Relative time until Drive allele';'reaches 99% frequency'},'FontSize' , 22)
ax = gca; % current axes
axis(ax, 'tight')   % where ax is your axis handle.
xlim(ax, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.05)
ylim(ax, [-0.05,max(max(T_crit./T_crit(:,1)))+0.05] )
% axis([pmin-0.05 pmax+0.05 -0.05 max(max(T_crit./T_crit(:,1)))+0.1])
pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
set(gcf, 'PaperPositionMode', 'auto');
print('rel_mat_sys_p_c_0.eps','-depsc')

% Uncomment for linear-axis plot
% axes('NextPlot','replacechildren', 'ColorOrder',C);
% plt1 = plot(p_vec,T_crit,'-','Linewidth',4)
% 
% xlabel('Distortion probability, p','FontSize' , 22)
% ylabel({'Time until Drive allele';'reaches 99% frequency'},'FontSize' , 25)
% axis([pmin-0.05 1.05 -0.05 1.05])
% pbaspect([1 0.75 1])
% set(gca, ...
%   'Box'         , 'on'     , ...
%   'TickDir'     , 'in'     , ...
%   'TickLength'  , [.01 .01] , ...
%   'XMinorTick'  , 'off'      , ...
%   'YMinorTick'  , 'off'      , ...
%   'YGrid'       , 'off'      , ...
%   'XColor'      , [0 0 0], ...
%   'YColor'      , [0 0 0], ...
%   'LineWidth'   , 1         );
% axis([pmin-0.05 pmax+0.05 -0.05 max(max(T_crit))+10])
% set(gcf, 'PaperPositionMode', 'auto');
% print('mat_sys_p_c_0.eps','-depsc')
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
r_vec = [1,2,4,6,8,10]; % Degree of plogygamy
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
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + 0.5*(1 - X1(:,1)-X1(:,2)))>0.99)));
    j = j + 1;
    end
    i = i + 1;
end

%% Output-2
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

axes('NextPlot','replacechildren', 'ColorOrder',C);
plt1 = semilogy(p_vec,T_crit,'-','Linewidth',4)
xlabel('Distortion probability, p','FontSize' , 22)
ylabel({'Time until Drive allele';'reaches 99% frequency'},'FontSize' , 22)
% xlim([0.5-0.05-0.05 pmax+0.05])
ax = gca; % current axes
axis(ax, 'tight')   % where ax is your axis handle.
xlim(ax, [0.5 1] + [-1,1]*range(xlim(ax)).* 0.05)
ylim(ax, [5,2*max(max(T_crit))] )
pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
set(gcf, 'PaperPositionMode', 'auto');
print('mat_sys_p_c_02.eps','-depsc')

figure()
axes('NextPlot','replacechildren', 'ColorOrder',C);
plot(p_vec,T_crit./T_crit(:,1),'-','Linewidth',4)
xlabel('Distortion probability, p','FontSize' , 22)
ylabel({'Relative time until Drive allele';'reaches 99% frequency'},'FontSize' , 22)
ax = gca; % current axes
axis(ax, 'tight')   % where ax is your axis handle.
xlim(ax, [0.5 1] + [-1,1]*range(xlim(ax)).* 0.05)
ylim(ax, [-0.05,max(max(T_crit./T_crit(:,1)))+0.05] )
% axis([0.5-0.05 pmax+0.08 -0.05 max(max(T_crit./T_crit(:,1)))+0.1])
pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
set(gcf, 'PaperPositionMode', 'auto');
print('rel_mat_sys_p_c_02.eps','-depsc')

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
    
    T_crit(i,j) = tspan(min(find((X1(:,2) + 0.5*(1 - X1(:,1)-X1(:,2)))>0.99)));
    
    j = j + 1;
    end
    i = i + 1;
end

%% Output-2
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

% Log Plot
axes('NextPlot','replacechildren', 'ColorOrder',C);
semilogy(d_vec,T_crit,'-','Linewidth',4)
xlabel('Medea drive efficiency, d','FontSize' , 22)
ylabel({'Time until Drive allele';'reaches 99% frequency'},'FontSize' , 22)
%legend('Monogamy, r=1','Ploygamy, r=2','Ploygamy, r=3','Ploygamy, r=4','Ploygamy, r=5')
% axis([dmin-0.05 dmax+0.05 -0.05 max(max(T_crit))+10])
%xlim([dmin-0.05-0.05 dmax+0.05])
%ylim([max(max(T_crit))+500 min(min(T_crit))-100])
ax = gca; % current axes
axis(ax, 'tight')   % where ax is your axis handle.
xlim(ax, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.05)
ylim(ax, [30,2*max(max(T_crit))] )

pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
print('mat_sys_log_d_c_0.eps','-depsc')

figure()
axes('NextPlot','replacechildren', 'ColorOrder',C);
plot(d_vec,T_crit./T_crit(:,1),'-','Linewidth',4)
xlabel('Medea drive efficiency, d','FontSize' , 22)
ylabel({'Relative time until Drive allele';'reaches 99% frequency'},'FontSize' , 22)
% legend('Monogamy, r=1','Polygamy, r=2','Polygamy, r=3','Polygamy, r=4','Polygamy, r=5')
% grid on
% axis([dmin-0.05-0.03 1.08 -0.1 1.1])
ax = gca; % current axes
axis(ax, 'tight')   % where ax is your axis handle.
xlim(ax, xlim(ax) + [-1,1]*range(xlim(ax)).* 0.05)
ylim(ax, [-0.05,max(max(T_crit./T_crit(:,1)))+0.05] )
pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
set(gcf, 'PaperPositionMode', 'auto');
print('rel_mat_sys_d_c_0.eps','-depsc')