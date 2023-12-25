clc;clear all;close all;
Tb=1;
t=0:(Tb/100):Tb;
fc=1;
c1=sqrt(2/Tb)*cos(2*pi*fc*t);
c2=sqrt(2/Tb)*sin(2*pi*fc*t);
subplot(3,2,1);
plot(t,c1);
xlabel('t')
ylabel('c1(t)')
title('Carrier-1');
grid on;
subplot(3,2,2);
plot(t,c2)
xlabel('t')
ylabel('c2(t)')
title('Carrier-2');
grid on;

N=16;
m=rand(1,N);
t1=0;
t2=Tb;
for i=1:2:(N-1)
    t=[t1:(Tb/100):t2];
    if m(i)>0.5
        m(i)=1;
        m_s=ones(1,length(t));
    else
        m(i)=0;
        m_s=-1*ones(1,length(t));
    end
    odd_sig(i,:)=c1.*m_s;

    if m(i+1)>0.5
        m(i+1)=1;
        m_s=ones(1,length(t));
    else
        m(i+1)=0;
        m_s=-1*ones(1,length(t));
    end
    even_sig(i,:)=c2.*m_s;

    %QPSK Modulation
    qpsk=odd_sig +even_sig;

    subplot(3,2,3);
    stem(m);
    title('Binary data bits');
    xlabel('n')
    ylabel('b(n)')
    grid on;

    subplot(3,2,4);
    plot(t,qpsk(i,:));
    title('QPSK modulated signal');
    xlabel('t')
    ylabel('s(t)')
    grid on;
    hold on;
    t1=t1+(Tb+0.01);
    t2=t2+(Tb+0.01);
end
hold off;

%Demodulation
t1=0;
t2=Tb;
for i=1:N-1
    t=[t1:(Tb/100):t2];
    x1=sum(c1.*qpsk(i,:));
    x2=sum(c2.*qpsk(i,:));

    if (x1>0 && x2>0)
        demod(i)=1;
        demod(i+1)=1;
    elseif (x1>0 && x2<0)
         demod(i)=1;
        demod(i+1)=0;
    elseif (x1<0 && x2<0)
         demod(i)=0;
        demod(i+1)=0;
    elseif (x1<0 && x2>0)
         demod(i)=0;
        demod(i+1)=1; 
    end
    t1=t1+(Tb+0.01);
    t2=t2+(Tb+0.01);
end

subplot(3,2,5);
stem(demod);
title('QPSK Demodulated signal');
xlabel('n');
ylabel('b(n)');
grid on;









 
 











   





















