clc;close all;clear all;
M=8;N=12;
msg=round(rand(1,N));
disp('Binary ip at transmitter');
disp(msg);

Tb=0.000001;
x=msg;
bits=[];
for n=1:1:length(x)
    if x(n)==1;
        sig =ones(1,100);
    else x(n)==0;
        sig =zeros(1,100);
    end
    bits=[bits sig];
end

t1=Tb/100:Tb/100:100*length(x)*(Tb/100);
subplot(3,1,1);
plot(t1,bits,'lineWidth',2.5);
grid on;
axis ([0 Tb*length(x) -0.5 1.5]);
xlabel('time');
ylabel('Amplitude');
title('digital ip signal');

msg_reshape=reshape(x,log2(M),N/log2(M))';
disp('information is reshaped to convert into symbol form');
disp(msg_reshape);
fprintf('\n\n');
size(msg_reshape);
for (j=1:1:N/log2(M))
    for (i=1:1:log2(M))
        a(j,i)=num2str(msg_reshape(j,i));
    end
end
as=bin2dec(a);
ast=as';

subplot(3,1,2);
stem(ast,'LineWidth',2.0);
title('serial symbol for 8-QAM moduln');
xlabel('n(discrete time)');
ylabel('Magnitude');
disp('symbol form of information for 8-QAM');
disp(ast);
fprintf('\n\n');

p=qammod(ast,M);
scatterplot(p),grid on;
title('8-QAM constellation diagram');

RR=real(p);
II=imag(p);
sp=Tb*2;
sr=1/sp;
f=sr*2;
t=sp/100:sp/100:sp;
ss=length(t);
m=[];
for (k=1:1:length(RR))
    yr=RR(k)*cos(2*pi*f*t);
    yim=II(k)*sin(2*pi*f*t);
    y=yr+yim;
    m=[m y];
end

tt=sp/100:sp/100:sp*length(RR);
figure(1);
subplot(3,1,3);
plot(tt,m);
xlabel('time');
ylabel('amplitude');
title('8-QAM modulated signal');


 
