%========================== In The Name Of God ===========================%
%------------------------ Created by Mohsen Lotfi ------------------------%
%------------------------ Persian Gulf University ------------------------%
% Date: 2018/03/05 01:20:00 
% ======================================================================= %
clc
clear
close all
tic
a=2;b=0.2/2;c=3;d=0.3/3;   
h=0.7;
t1=0;
t2=30;
t=t1:h:t2;
n=floor((t2-t1)/h);
%------------------
Y1(1)=5;
Y2(1)=5;
X=zeros(n+1,1);
X(1)=0;
%-----------------
x(1)=10.0173+0.7372*sin((1.56^0.5)*t(1))-0.0166*sin((1.56^0.5)*t(1))*cos((1.56^0.5)*t(1))-0.0346*((cos((1.56^0.5)*t(1)))^2)+0.0173*cos((1.56^0.5)*t(1));
y(1)=11.7993-0.8371*cos((1.56^0.5)*t(1))-0.0197*sin((1.56^0.5)*t(1))*cos((1.56^0.5)*t(1))+0.0378*((cos((1.56^0.5)*t(1)))^2)+0.0197*sin((1.56^0.5)*t(1));
%-----------------
for i=1:n
    K1=h*(a*Y1(i)*(1-b*Y2(i)));
    L1=h*(c*Y2(i)*(d*Y1(i)-1));
    K2=h*(a*(Y1(i)+K1/2))*(1-b*(Y2(i)+L1/2));
    L2=h*(c*(Y2(i)+L1/2)*(d*(Y1(i)+K1/2)-1));
    K3=h*(a*(Y1(i)+K2/2))*(1-b*(Y2(i)+L2/2));
    L3=h*(c*(Y2(i)+L2/2)*(d*(Y1(i)+K2/2)-1));
    K4=h*(a*Y1(i)+K3)*(1-b*(Y2(i)+L3));
    L4=h*(c*(Y2(i)+L3)*(d*(Y1(i)+K3)-1));

    Y1(i+1)=Y1(i)+1/6*(K1+2*K2+2*K3+K4);
    Y2(i+1)=Y2(i)+1/6*(L1+2*L2+2*L3+L4);
    X(i+1)=h*(i);
    x(i+1,1)=10.0173+0.7372*sin((1.56^0.5)*t(i))-0.0166*sin((1.56^0.5)*t(i))*cos((1.56^0.5)*t(i))-0.0346*((cos((1.56^0.5)*t(i)))^2)+0.0173*cos((1.56^0.5)*t(i));
    Y(i+1,1)=11.7993-0.8371*cos((1.56^0.5)*t(i))-0.0197*sin((1.56^0.5)*t(i))*cos((1.56^0.5)*t(i))+0.0378*((cos((1.56^0.5)*t(i)))^2)+0.0197*sin((1.56^0.5)*t(i));
end
Error_Pray=((x-Y1(:,1))./x).*100;
Error_Predator=((Y-Y2(:,1))./Y).*100;
ErrorPray=(sum(abs(Error_Pray)))/length(x)
ErrorPredator=(sum(abs(Error_Predator)))/length(Y)

T=(X-1)*h;
figure(1)
plot(T,Y1,'-.g',T,Y2,'-.b');
title ( 'Runge Kutta Method' );
legend('Y1','Y2');
xlabel('Time')
ylabel('Y')
grid on
hleg2=legend('Y1','Y2');
figure(2)
plot (Y1,Y2);
title ( 'Runge Kutta Method' );
xlabel ( 'Y1' );
ylabel ( 'Y2' );
toc
