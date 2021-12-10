clc;
clear;
close all;


M = 64;
k = log2(M);
n = 2^13 ;                      %number of symbols%
x = (0:M-1)'; 

input = randi([0 1],n*k,1);
file_ID = fopen('inputdata.txt','w');
fprintf(file_ID,'%3d\n',input);
fclose(file_ID);



for i =0:n-1
z = input(1+i*k:k+i*k);
y(i+1,1) = ( (-1)^z(1) * (4 + ((-1)^z(3)*(2+(-1)^z(5))) ) +  (-1)^z(2) * j * (4 + ((-1)^z(4)*(2+(-1)^z(6))) ) ) / sqrt(42);
end

temp = y * sqrt(42);

R = real(y) ;
I = imag(y) ;

file_ID = fopen('mappingR.txt','w');
fprintf(file_ID,'%f\n', R);
fclose(file_ID);

file_ID = fopen('mappingI.txt','w');
fprintf(file_ID,'%f\n', I);
fclose(file_ID);
