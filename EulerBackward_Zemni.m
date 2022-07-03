%========================== In The Name Of God ===========================%
%------------------------ Created by Mohsen Lotfi ------------------------%
%------------------------ Persian Gulf University ------------------------%
% Date: 2018/02/28 03:45:01 
% ======================================================================= %
clc
clear
tic
% a=1;b=2;c=3;d=4;      % zarayeb halati ke be sefr meyl mikonad
a=2;b=0.2/2;c=3;d=0.3/3;    % zarayeb halate navasani 
h=0.2;                 % andazeye game zamani
t1=0;
t2=30;
t=t1:h:t2;              % bazaye zamani
n=floor((t2-t1)/h);
% ---------------------------------------
y1=zeros(n+1,1);        % tedade shekar
y2=zeros(n+1,1);        % tedade shekarchi
X =zeros(n+1,1);        % tedade game zamani
% ----- maghadire avalie --------------------
y1(1)=5;
y2(1)=5;
X(1) =1;
%-----------------------------
x(1)=10.0173+0.7372*sin((1.56^0.5)*t(1))-0.0166*sin((1.56^0.5)*t(1))*cos((1.56^0.5)*t(1))-0.0346*((cos((1.56^0.5)*t(1)))^2)+0.0173*cos((1.56^0.5)*t(1));
y(1)=11.7993-0.8371*cos((1.56^0.5)*t(1))-0.0197*sin((1.56^0.5)*t(1))*cos((1.56^0.5)*t(1))+0.0378*((cos((1.56^0.5)*t(1)))^2)+0.0197*sin((1.56^0.5)*t(1));
% ----------------------------
for i=1:n; 
    M(1)=0;     
    N(1)=0;
   for J=1:20;
       Q=inv([1-h*a*(1-b*N(J)),+b*h*a*M(J);-h*c*N(J)*d,1-h*c*(-1+d*M(J))]);
       W=[M(J);N(J)]-Q*[-y1(i)+M(J)-h*(a*M(J)*(1-b*N(J)));-y2(i)+N(J)-h*(c*N(J)*(-1+d*M(J)))];
       M(J+1)=W(1);
       N(J+1)=W(2);
   end
   y1(i+1)=M(21);
   y2(i+1)=N(21);
   X(i+1)=i+1; 
   x(i+1,1)=10.0173+0.7372*sin((1.56^0.5)*t(i))-0.0166*sin((1.56^0.5)*t(i))*cos((1.56^0.5)*t(i))-0.0346*((cos((1.56^0.5)*t(i)))^2)+0.0173*cos((1.56^0.5)*t(i));
   y(i+1,1)=11.7993-0.8371*cos((1.56^0.5)*t(i))-0.0197*sin((1.56^0.5)*t(i))*cos((1.56^0.5)*t(i))+0.0378*((cos((1.56^0.5)*t(i)))^2)+0.0197*sin((1.56^0.5)*t(i));

end 
% -------------- plot shekar & shekarchi bar hasbe zaman------------------%
Error_Pray=((x-y1(:,1))./x).*100;
Error_Predator=((y-y2(:,1))./y).*100;
ErrorPray=(sum(abs(Error_Pray)))/length(x)
ErrorPredator=(sum(abs(Error_Predator)))/length(y)

T=(X-1)*h;
figure(1) 
plot(T,y1,'-.g',T,y2,'-.b');
title ( 'Euler Backward Method' );
legend('y1','y2');
xlabel('Time')
ylabel('Y')
grid on
hold on
hleg2=legend('y1','y2');
figure(2)
plot(y1,y2);
title('Euler Backward Method');
xlabel('y1');
ylabel('y2');
grid on
toc