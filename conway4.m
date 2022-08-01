% Conway´s game of life 
clc
close all
clear
n=100;              % matrix dimensions
t=10;               % # generations
Ta=zeros(n,n,t);    % initialize matrix

Ta(7,4,1)=1;        % manually input initial conditions; example : glider
Ta(7,5,1)=1;
Ta(7,6,1)=1;
Ta(6,6,1)=1;
Ta(5,5,1)=1;

clc

%Ta(:,:,1)=rand(n); % random matrix alternative
%Ta = Ta<0.5;       % make the matrix binary

% i=1                % show generation


imagesc(Ta(:,:,1))                   % plot     % pcolor(T) % plot matrix

for i=2:t
T = Ta(:,:,i-1);                    %   
V=movsum(movsum(T,3,1),3,2)-T;      % compute neighborhood´s value
Tn=(T>0).*(V<4&V>1)+(T<1).*(V==3);  % new table 
Ta(:,:,i) = Tn;
figure                              % plot
imagesc(Tn)                         %
i=i+1                               % update and show generation
end