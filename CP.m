clear;
clc;



D_gi = 1/4;       %duration of guard interval


%%
file_ID = fopen('output_IFFT_realpart.txt','r');
R = fscanf(file_ID,'%f');
fclose(file_ID);

file_ID = fopen('output_IFFT_imaginarypart.txt','r');
I = fscanf(file_ID,'%f');
fclose(file_ID);

G = R' + I'*i;
%%



G = [G(floor((1-D_gi)*end)+1:end) G];

G_r = real(G);
G_i = imag(G);


file_ID = fopen('OFDM_output_real.txt','w');
fprintf(file_ID,'%f\n', G_r);
fclose(file_ID);


file_ID = fopen('OFDM_output_imaginary.txt','w');
fprintf(file_ID,'%f\n', G_i);
fclose(file_ID);
