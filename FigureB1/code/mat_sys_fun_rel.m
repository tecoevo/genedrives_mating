%% Figure B1
% This code generates the figure B1 of the manuscript.

% Figure B1: Effect on the rate of production of DD genotype with increases
% in degree of polygamy for different fitness cost. 
% We start from a population consisting of equal abundance of all the three 
% genotypes with 100\% drive efficiency of distortion based gene drive for 
% different fitness cost. Increasing the fitness cost of drive allele decreases 
% the overall production of DD genotype. For moderate level of fitness cost, 
% production of genotype DD first increases upto a point for species with 
% higher level of polygamy but then started to decrease.

clc; clear; % close all;

yww = 1/3;
ywd = 1/3;
ydd = 1/3;

xww = 1/3;
xwd = 1/3;
xdd = 1/3;

c = 0;
fww = 1;
fwd = 1-c;
fdd = (1-c)^2;

p = 1;
d = 0;

r = 1:20; % [1,2,3,4,5];
lineStyles = (1/256)*[241, 167, 169;236, 131, 133;230, 96, 99;227, 80, 83;221, 44, 47;210, 20, 20];

% Output
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 22)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 22)
i = 1;

for c = [0.0,0.1,0.2,0.3,0.4,0.5]
fww = 1;
fwd = 1-c;
fdd = (1-c)^2;

Fww = r.*(fdd.*xdd+fwd.*xwd+fww.*xww).^((-1)+r).*((-1).*fwd.*((-1)+p).* ...
  xwd+fww.*xww).*(((-1)+d).*fwd.*((-1)+p).*xwd+fww.*xww);

Fwd = r.*(fdd.*xdd+fwd.*xwd+fww.*xww).^((-1)+r).*((-1).*fwd.*((-1)+p).*( ...
  2.*fdd.*xdd.*xwd+2.*fwd.*p.*xwd.^2)+fww.*(2.*fdd.*xdd.*xww+2.* ...
  fwd.*p.*xwd.*xww));

Fdd = r.*(fdd.*xdd+fwd.*p.*xwd).^2.*(fdd.*xdd+fwd.*xwd+fww.*xww).^((-1)+ ...
  r);

plot(r,Fdd,'.-','Linewidth',3,'Markersize',30,'Color',lineStyles(i,:))
i = i + 1;
hold on
end

xlabel('Degree of polygamy, r','FontSize' , 22)
ylabel({'Rate of production of ','genotype DD'},'FontSize' , 22)
pbaspect([1 0.75 1])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );

axis([r(1)-1.5 r(end)+1.5 -0.2 3])
legend('c=0.0','c=0.1','c=0.2','c=0.3','c=0.4','c=0.5', 'Fontsize',22,'Location','NorthEast')
% title('x_{WW}=x_{WD}=x_{DD}=1/3')
set(gcf, 'PaperPositionMode', 'auto');
print('mat_sys_fun_rel.eps','-depsc2')

