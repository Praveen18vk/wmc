clc;clear all;close all;
x=[2 3];
data_ip_bit(1,1)=x(1,1)
data_ip_bit(1,2)=x(1,2)
z=qammod(data_ip_bit,4);
h=[1.3 -.4 ;6 .11];
e=[.1 .1;.1 .1];
out=zeros(10,1);
for i=1;
    out(i,1)=z(i);
    out(i+1,1)=z(i+1);
    out(i,2)=-conj(z(i+1));
    out(i+1,2)=conj(z(i));
end
s1=out(i,1);
s2=out(i+1,1);
for i=1;
    r(1,1)=(h(1,1)*s1) + (h(1,2)*s2) + e(1,1);
    r(1,2)=((-h(1,1))*conj(s2)) + (h(1,2)*conj(s1)) + e(1,2);
    r(2,1)=(h(2,1)*s1) + (h(2,2)*s2) + e(2,1);
    r(2,2)=((-h(2,2))*conj(s2)) + ((h(2,2))*conj(s1)) + e(2,2);
end
t(1,1)=((conj(h(1,1))*r(1,1)));
t(1,2)=h(1,2)*(conj(r(1,2)));
t(2,1)=((conj(h(2,1))*r(2,1)));
t(2,2)=((h(2,2)*(conj(r(2,2)))));
c(1,1)=((conj(h(1,2)))*r(1,1));
c(1,2)=h(1,1)*(conj(r(1,2)));
c(2,1)=((conj(h(1,1))*r(1,1)));
c(2,2)=((h(2,1)*(conj(r(2,2)))));

s1_e=t(1,1) + t(1,2) + t(2,1) + t(2,2);
s2_e=c(1,1) - c(1,2) + c(2,1) - c(2,2);

final_op_bits(1,1)=qamdemod(s1_e,4);
final_op_bits(1,2)=qamdemod(s2_e,4);


