 clc;
 clear all;close all;
 N=8;
 b=round(rand(1,N));
 subplot(4,1,1);
 stem(b,'filled')
 xlabel('Bit index');
 ylabel('transmitted bits');

 %encoding in NRZ 
 NRZ_out=[];
 Vp=1;
 for index=1:size(b,2)
     if b(index)==1
         NRZ_out=[NRZ_out ones(1,200)*Vp];
     elseif b(index)==0
         NRZ_out=[NRZ_out zeros(1,200)*(-Vp)];
     end
 end
 subplot(4,1,2);
 plot(NRZ_out)

 %Modulation
 t=0.005:0.005:8;
 f1=3;
 f2=5;
 A=5;
 mod_sig=[];
 for (i=1:1:length(NRZ_out))
     if (NRZ_out(i)==1)
         y=A*cos(2*pi*f1*t(i));
     else
         y=A*cos(2*pi*f2*t(i));
     end
 mod_sig=[mod_sig y];
 end

 subplot(4,1,3);
 plot(t,mod_sig)
 xlabel('Time in sec');
 ylabel('Modulated sig');

 %Demodulation
demod_branch_1=mod_sig.*(cos(2*pi*f1*t));
demod_branch_2=mod_sig.*(cos(2*pi*f2*t));
y_1=[];
for i=1:200:size(demod_branch_1,2)
    y_1=[y_1 trapz(t(i:i+199),demod_branch_1(i:i+199))];
end
y_2=[];
for i=1:200:size(demod_branch_2,2)
    y_2=[y_2 trapz(t(i:i+199),demod_branch_2(i:i+199))];
end
rec_sig=y_1>y-2;

subplot(4,1,4);
stem(rec_sig,'filled','r')
xlabel('Bit index')
ylabel('Received bits ')






