clear;
clc;
%input = randi([0 1],2^13,1);

file_ID = fopen('mappingR.txt','r');
R = fscanf(file_ID,'%f');
fclose(file_ID);

file_ID = fopen('mappingI.txt','r');
I = fscanf(file_ID,'%f');
fclose(file_ID);

input = (I + R*i);

N = length(input);

for a = 0:1
    x = input(1+a : 2 : N);
    F(1+4096*a:4096+4096*a) = fft_4096_by_1024(x);
end

for k = 0:4095
    for n = 0:1
        G(1+k+n*4096) = (F(1+k) + (exp(-i*2*pi*(4096*n+k)/N) * F(1+k+N/2)))/8192;
    end
end



input = R + I*i;
Matlab_ifft = ifft(input);

dif1 = real(Matlab_ifft) - imag(G.');
max(dif1)

dif2 = real(G.') - imag(Matlab_ifft);
max(dif2)

G_r = real(G);
G_i = imag(G);


file_ID = fopen('output_IFFT_realpart.txt','w');
fprintf(file_ID,'%f\n', G_i);
fclose(file_ID);


file_ID = fopen('output_IFFT_imaginarypart.txt','w');
fprintf(file_ID,'%f\n', G_r);
fclose(file_ID);
