% Conway´s game of life
clc
close all
clear
n=50;               % matrix dimensions
t=20;               % # generations
Ta=zeros(n,n,t);    % initialize matrix

Ta(7,4,1)=1;        % manually input initial conditions; example : glider
Ta(7,5,1)=1;
Ta(7,6,1)=1;
Ta(6,6,1)=1;
Ta(5,5,1)=1;

clc

%Ta(:,:,1)=rand(n); % random matrix alternative
%Ta = Ta<0.5;       % make the matrix binary



h = figure;
imagesc(Ta(:,:,1))                  % plot matrix
ax.NextPlot = 'replaceChildren';
M(t) = struct('cdata',[],'colormap',[]);
h.Visible = 'off';
M(1) = getframe;
for i=2:t
T = Ta(:,:,i-1);                    % abbreviates 
V=movsum(movsum(T,3,1),3,2)-T;      % compute neighborhood´s value
Tn=(T>0).*(V>1&V<4)+(T<1).*(V==3);  % new table 
Ta(:,:,i) = Tn;

imagesc(Tn)
drawnow
M(i) = getframe;
end

h.Visible = 'on';
movie(M,1,1);                       % play movie