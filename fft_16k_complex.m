clear;
clc;

in1 = randn(1,4^7);
in2 = randn(1,4^7);
input = in1 + i * in2;

N = length(input);

for a = 0:3
    x = input(1+a : 4 : N);
    F(1+4096*a:4096+4096*a) = fft_4096_by_1024(x);
end

for k = 0:4095
    for n = 0:3
        MY_fft_result(1+k+n*4096) = F(1+k) + (exp(-i*2*pi*(4096*n+k)/N) * F(1+k+N/4)) + (exp(-i*4*pi*(4096*n+k)/N) * F(1+k+N/2)) + (exp(-i*6*pi*(4096*n+k)/N) * F(1+k+3*N/4));
    end
end



input = i * in1 + in2;
Matlab_ifft = ifft(input)*16384;

dif1 = real(Matlab_ifft) - imag(MY_fft_result);
max(dif1)

dif2 = real(MY_fft_result) - imag(Matlab_ifft);
max(dif2)
