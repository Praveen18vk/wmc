clc;clear all;close all;
P=5;
t=[0:0.1:1*pi];
sig=4*sin(t);

Vh=max(sig);
Vl=min(sig);
N=3;M=2^N;
S=(Vh-Vl)/M;
stepsize=S;
partition=[Vl+S:S:Vh-S];
codebook=[Vl+S/2:S:Vh-S/2];
[index,quantized_sig,distor]=quantiz(sig,partition,codebook);

codedsig=de2bi(index,'left-msb');
codedsig=codedsig';
txbits=codedsig(:);
errvec=randsrc(length(txbits),1,[0 1;(1-P/100) P/100]);

rxbits=rem(txbits+errvec,2);
rxbits=reshape(rxbits,N,length(sig));
rxbits=rxbits';
index1=bi2de(rxbits,'left-msb');
reconstructedsig=codebook(index1+1);

figure,
subplot(2,2,1);
stem(t,sig);
xlabel('time')
title('original signal')

subplot(2,2,2);
stem(t,quantized_sig);
xlabel('time')
title('quantised signal');
tt=[0:N*length(t)-1];

subplot(2,2,3);
stairs(tt,txbits);
xlabel('time')
title('PCM waveform');;

subplot(2,2,4);
stem(t,reconstructedsig);
xlabel('time')
title('recieved signal');
