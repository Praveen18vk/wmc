clc;clear all;close all;
F1=input('carrier sine freq fs=');
F2=input('Message freq fm=');
A=5;
t=0:0.001:1;

c=A.*sin(2*pi*F1*t);
subplot(3,1,1);
plot(t,c);
xlabel('time');
ylabel('amplitude');
title('Carrier sine wave');
grid on;

m=0.75*A.*square(2*pi*F2*t);
subplot(3,1,2);
plot(t,m);
xlabel('time');
ylabel('amplitude');
title('Message signal'); 
grid on;

n=length(c);
for i=1:n
    if (m(i)>=c(i))
        pwm(i)=1;
    else
        pwm(i)=0;
    end
end
subplot(3,1,3);
plot(t,pwm)
xlabel('time')
ylabel('Amplitude')
title('plot of PWM')
axis([0 1 0 2]);
grid on;


