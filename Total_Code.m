clear;clc;close all
%% Adams-Bashforth-Moulton (ode113):
 t = [0 40];
y0 = [10 10];

tic
options = odeset('RelTol',1e-6,'AbsTol',[1e-6 1e-6]);
[v1,v2]=ode113(@func,[0 40],[10 10],options);
% [v1,v2]=ode113(@func,t,y0);
toc

figure
plot(v1,v2(:,1),'-.g',v1,v2(:,2),'-.b','LineWidth',1);
title ( 'Adams-Bashforth-Moulton (ode113)' );
legend('y1','y2');
xlabel('Time')
ylabel('Y')
grid on
hold on

%% Trapizodal:
tic
[v1,v2]=ode23t(@func,t,y0,options); % ode23t is for Trapizodal Rule
toc
figure
plot(v1,v2(:,1),'-.g',v1,v2(:,2),'-.b','LineWidth',1);
title ( 'Trapizodal rule (ode23t)' );
legend('y1','y2');
xlabel('Time')
ylabel('Y')
grid on
hold on

%% Adams-Bashforth-Moulton:
a=2;b=0.2;c=3;d=0.3;  % zarayeb halate navasani
h=0.001;               % andazeye game zamani
t1=0;
t2=40;
t=t1:h:t2;            % bazaye zamani
n=(t2-t1)/h;   

%% Adams-Bashforth Two-Step Explicit Method:
tic
y = zeros(n,2);
y(1,:)=10;
y(2,:)=y(1,:)+(h/2)*(func(t(1),y(1,:)))';

for i=2:n
  dy = 3*func(t(i),y(i,:))-func(t(i-1),y(i-1,:));
  y(i+1,:)=y(i,:)+(h/2)*(dy');
end
toc

figure
plot(t,y(:,1),'-.g',t,y(:,2),'-.b','LineWidth',1);
title ( 'Adams-Bashforth Explicit' );
legend('y1','y2');
xlabel('Time')
ylabel('Y')
grid on
hold on

%% predictor-corrector method (fourth-order):
tic
% OOOO estimates using Runge-Kutta
for i = 1:3
	k1 = func(t(i), y(i,:));
	k2 = func(t(i) + h/2, y(i,:) + h/2*k1');
	k3 = func(t(i) + h/2, y(i,:) + h/2*k2');
	k4 = func(t(i) + h, y(i,:) + h*k3');
	y(i+1,:) = y(i,:) + h/6*(k1' + 2*k2' + 2*k3' + k4');
end

% OOOOOOOOOOOOOOOOOOOOOOOOOOO predict-correct OOOOOOOOOOOOOOOOOOOOOOOOOOOO%
for i = 4:n
	% Adams-Bashforth -- *predict*
    dyp = (55*func(t(i), y(i,:)) - 59*func(t(i-1),y(i-1,:)) ...
		+ 37*func(t(i-2),y(i-2,:)) - 9*func(t(i-3),y(i-3,:)));
	y(i+1,:) = y(i,:) + h/24*dyp';
	% Adams-Moulton -- *correct*
    dyc = (9*func(t(i+1),y(i+1,:)) + 19*func(t(i),y(i,:)) ...
		- 5*func(t(i-1),y(i-1,:)) + func(t(i-2),y(i-2,:)));
	y(i+1,:) = y(i,:) + h/24*dyc';
end
toc

figure
plot(t,y(:,1),'-.g',t,y(:,2),'-.b','LineWidth',1);
title ( 'Predictor-Corrector (4th order)' );
legend('y1','y2');
xlabel('Time')
ylabel('Y')
grid on
hold on