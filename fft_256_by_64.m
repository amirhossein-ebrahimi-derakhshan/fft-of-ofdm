function XF = fft_256_by_64(input)

N = length(input);


for a = 0:3
    x = input(1+a : 4 : N);
    C(1+64*a:64+64*a) = fft_64_by_16(x);
end

for k = 0:63
    for n = 0:3
        D(1+k+n*64) = C(1+k) + (exp(-i*2*pi*(64*n+k)/N) * C(1+k+N/4)) + (exp(-i*4*pi*(64*n+k)/N) * C(1+k+N/2)) + (exp(-i*6*pi*(64*n+k)/N) * C(1+k+3*N/4));
    end
end

XF = D;

end