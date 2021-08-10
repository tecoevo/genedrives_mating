close all
% This Matlab code reads the data file to generate all the heatmaps
% of figure panel 3.
%% viability without cost
filename1 = ['heatmap_vary_h_d','.txt'];
Xeqm = dlmread(num2str(filename1));
h_vec = linspace(0.01,1,100); % [0.001,0.5,0.8];
d_vec = linspace(0,1,101);

% Output
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

I = reshape(Xeqm(:,3),[length(d_vec),length(h_vec)]);
I = fliplr(I);
clim = [0 1]; % color limit
imagesc(d_vec,h_vec,I',clim);
xlim([d_vec(1)-0.02 d_vec(end)+0.02])
ylim([h_vec(1)-0.02 h_vec(end)+0.02])
set(gca,'YDir','normal') 
colormap('gray')
caxis([0 1])
oldcmap = colormap;
colormap( flipud(oldcmap) );
axis square
grid on
ylabel('Mate choice bias, h','FontSize' , 22)
xlabel('Medea efficiency, d','FontSize' , 22)
set(gca,'XMinorTick','on','YMinorTick','on')
% colorbar

% Overlaying the contour plots
hold on
[C1,h1] = imcontour([d_vec(1) d_vec(end)], [h_vec(1) h_vec(end)], I',[0.01 0.1 0.2 0.3 0.4 0.45],'--k','ShowText','on');
axis square
set(gca,'YDir','normal') 
clabel(C1,h1,'FontSize',15,'Color','black')

% Saving the figure
print('HP_medea_without_cost1.eps','-depsc2') 

%% viability with cost
clc; clear
filename1 = ['heatmap_vary_h_d_c_0_1','.txt'];
Xeqm = dlmread(num2str(filename1));
h_vec = linspace(0,1,501); 
d_vec = linspace(0,1,501);

% Output
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

I = reshape(Xeqm(:,3),[length(d_vec),length(h_vec)]);
I = fliplr(I);
clim = [0 1]; % color limit
imagesc(d_vec,h_vec,I',clim);
xlim([d_vec(1)-0.02 d_vec(end)+0.02])
ylim([h_vec(1)-0.02 h_vec(end)+0.02])
set(gca,'YDir','normal') 
colormap('gray')
caxis([0 1])
oldcmap = colormap;
colormap( flipud(oldcmap) );
axis square
grid on
ylabel('Mate choice bias, h','FontSize' , 22)
xlabel('Medea efficiency, d','FontSize' , 22)
set(gca,'XMinorTick','on','YMinorTick','on')
ax = gca;
% Requires R2020a or later

% Overlaying the contour plots
hold on
[C1,h1] = imcontour([d_vec(1) d_vec(end)], [h_vec(1) h_vec(end)], I',[0.01 0.1 0.2 0.3 0.4 0.5 0.55],'--k','ShowText','on');
axis square
set(gca,'YDir','normal') 
clabel(C1,h1,'FontSize',15,'Color','black')

% Saving the figure
print('HP_medea_with_cost1.eps','-depsc2') 

%% distortion without cost
clc; clear
filename1 = ['heatmap_vary_h_p','.txt'];
Xeqm = dlmread(num2str(filename1));
h_vec = linspace(0.01,0.99,100); % [0.001,0.5,0.8];
p_vec = linspace(0.5,1,101);

% Output
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

I = reshape(Xeqm(:,3),[length(p_vec),length(h_vec)]);
I = fliplr(I);
clim = [0 1]; % color limit
imagesc(p_vec,h_vec,I',clim);
xlim([p_vec(1)-0.01 p_vec(end)+0.01])
ylim([h_vec(1)-0.02 h_vec(end)+0.02])
set(gca,'YDir','normal') 
colormap('gray')
caxis([0 1])
oldcmap = colormap;
colormap( flipud(oldcmap) );
axis square
grid on
axis square
ylabel('Mate choice bias, h','FontSize' , 22)
xlabel('Distortion probability, p','FontSize' , 22)
set(gca,'XMinorTick','on','YMinorTick','on')
% colorbar

% Overlaying the contour plots
hold on
[C1,h1] = imcontour([p_vec(1) p_vec(end)], [h_vec(1) h_vec(end)], I',[0.01 0.1 0.2 0.3 0.4 0.45],'--k','ShowText','on');
axis square
set(gca,'YDir','normal') 
clabel(C1,h1,'FontSize',15,'Color','black')

% Saving the figure
print('HP_distortion_without_cost1.eps','-depsc2') 


%% distortion with cost
clc; clear
filename1 = ['heatmap_vary_h_p_c_0_1','.txt'];
Xeqm = dlmread(num2str(filename1));
h_vec = linspace(0.0,1.0,501); % [0.001,0.5,0.8];
p_vec = linspace(0.5,1,501);

% Output
figure()
% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Arial')
set(0,'DefaultTextFontSize', 20)

I = reshape(Xeqm(:,3),[length(p_vec),length(h_vec)]);
I = fliplr(I);
clim = [0 1]; % color limit
% I_inter = interp2(I,4);
imagesc(p_vec,h_vec,I',clim);
xlim([p_vec(1)-0.01 p_vec(end)+0.01])
ylim([h_vec(1)-0.02 h_vec(end)+0.02])
set(gca,'YDir','normal') 
colormap('gray')
caxis([0 1])
oldcmap = colormap;
colormap( flipud(oldcmap) );
axis square
grid on
axis square
ylabel('Mate choice bias, h','FontSize' , 22)
xlabel('Distortion probability, p','FontSize' , 22)
set(gca,'XMinorTick','on','YMinorTick','on')
% colorbar

% Overlaying the contour plots
hold on
[C1,h1] = imcontour([p_vec(1) p_vec(end)], [h_vec(1) h_vec(end)], I',[0.01 0.1 0.2 0.3 0.4 0.5 55],'--k','ShowText','on');
axis square
set(gca,'YDir','normal') 
clabel(C1,h1,'FontSize',15,'Color','black')

% set(gca, ...
%   'Box'         , 'on'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on' );

% Saving the figure
print('HP_distortion_with_cost1.eps','-depsc2')
