% Conway´s game of life 
clc
close all
clear
%%
% Initial conditions

n=50;               % matrix dimensions
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


h = figure;
h2=imagesc(Ta(:,:,1));                  % plot matrix
tt = title("Conway's Game of Life");
mydlg = warndlg('close this dialogue to click the initial conditions');
waitfor(mydlg)
mydlg = warndlg('right click + check run = execute');



c = uicontrol('Style','checkbox','String','Run');  % Run button
c.Position = [0 0 80 20];
c.Visible = "on";  

% Input by left clicks

ax = gca;
fig = ancestor(ax, 'figure');
q = [];
hold(ax, 'on');
while true
  p = ginput(1);
  sel = get(fig, 'SelectionType');
  if strcmpi(sel, 'alt'); break; end
  Ta(round(p(1,2)),round(p(1,1)),1)= ~Ta(round(p(1,2)),round(p(1,1)),1);
  set(h2,'CData',Ta(:,:,1));
  drawnow
  q=[q;p];
end
hold(ax, 'off')

waitfor(c,'Value');


c.Visible = "off";          % hide the run button


%%
% Computation

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

%%
% Graphics

h.Visible = 'on';
fps=2;                                % frames per second
movie(M,1,fps);                       % play movie