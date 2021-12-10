function XF = fft_1024_by_256(input)

N = length(input);

for a = 0:3
    x = input(1+a : 4 : N);
    D(1+256*a:256+256*a) = fft_256_by_64(x);
end

for k = 0:255
    for n = 0:3
        E(1+k+n*256) = D(1+k) + (exp(-i*2*pi*(256*n+k)/N) * D(1+k+N/4)) + (exp(-i*4*pi*(256*n+k)/N) * D(1+k+N/2)) + (exp(-i*6*pi*(256*n+k)/N) * D(1+k+3*N/4));
    end
end

XF = E;

end