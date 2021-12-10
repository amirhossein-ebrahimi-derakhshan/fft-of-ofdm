function XF = fft_4096_by_1024(input)
N = length(input);
for a = 0:3
    x = input(1+a : 4 : N);
    E(1+1024*a:1024+1024*a) = fft_1024_by_256(x);
end
for k = 0:1023
    for n = 0:3
        F(1+k+n*1024) = E(1+k) + (exp(-i*2*pi*(1024*n+k)/N) * E(1+k+N/4)) + (exp(-i*4*pi*(1024*n+k)/N) * E(1+k+N/2)) + (exp(-i*6*pi*(1024*n+k)/N) * E(1+k+3*N/4));
    end
end
XF = F;
end