clc; close all; clear
% This matlab code generates the data to create the heatmap
% shown in figure 3A and 3C of the manuscript.
% The value of the fitness cost in figure 3A is 0 and in figure 3C is 0.1
% Excecuting the code will ask to input the value of the fitness cost.
% Put the appropriate value of 'c' to get desired the data file to generate
% the heatmap.

% Parameters Initialization
% Fertility selection
ffww = 1;   ffwd = 1;   ffdd = 1;
c = input('Enter the value of fitness cost, c: ');

% Viablility Selection
d = 0;    e = 0;  g = 0;
omega = 1;  nu = 1;

% Mate choice
% h = 0.5;
h11 = 1;    % h12 = h;    h13 = h;
h22 = 1;    h23 = 1;    h33 = 1;

% Initial condition
tspan = [0 500];
i = 0; 

h_vec = linspace(0.0,1.0,501); % [0.001,0.5,0.8];
p_vec = linspace(0.5,1,501);
Xeqm = zeros(length(p_vec)*length(h_vec),3);

% loop to vary 'h'
for h = h_vec
  % loop to vary 'p'    
for p = p_vec
    % cn = cn + 1
    i = i + 1 % counter for storing equilibrium freqencies in the text file
    xdd0_l = 0;
    xdd0_r  = 1;
    while abs(xdd0_l - xdd0_r) > 0.001
         % Solves the ODE
        [t1,Xl] = ode45(@(t,Xl)fun_drmxr(t,Xl,ffww,1-c,(1-c)^2,p,d,omega,nu,e,g,h11,h,h,h22,h23,h33),tspan,[(1-xdd0_l);xdd0_l]);
        [t2,Xr] = ode45(@(t,Xr)fun_drmxr(t,Xr,ffww,1-c,(1-c)^2,p,d,omega,nu,e,g,h11,h,h,h22,h23,h33),tspan,[(1-xdd0_r);xdd0_r]);
        xdd0_m = (xdd0_r + xdd0_l)/2;
        [t3,Xm] = ode45(@(t,Xm)fun_drmxr(t,Xm,ffww,1-c,(1-c)^2,p,d,omega,nu,e,g,h11,h,h,h22,h23,h33),tspan,[(1-xdd0_m);xdd0_m]);
        if Xm(end,1) > 0.99
            xdd0_l = xdd0_m;
        else % 1 - Xm(end,1) > 0.8
            xdd0_r = xdd0_m;
        end
    end
    Xeqm(i,:) = [h,p,xdd0_m];
end

end


filename1 = ['heatmap_vary_h_p_c_',num2str(c),'.txt']; % variable file name according to entered 'c'
dlmwrite (num2str(filename1),Xeqm);

% Remove comments to see the output plot here:
% % Output
% figure()
% hvalues = [h_vec(1), h_vec(end)];
% cvalues = [p_vec(1), p_vec(end)];
% I = reshape(Xeqm(:,3),[length(p_vec),length(h_vec)]);
% I = fliplr(I);
% I_inter = interp2(I,5);
% %imagesc(p_vec,h_vec,I_inter');
% imagesc(p_vec,h_vec,I');
% colormap('gray')
% oldcmap = colormap;
% colormap( flipud(oldcmap) );
% % lim = caxis;
% % caxis([0 1])
% axis square
% ylabel('Mate choice bias, h','FontSize' , 20)
% xlabel('Distortion efficiency, p','FontSize' , 20)
% set(gca,'XMinorTick','on','YMinorTick','on')
% colorbar