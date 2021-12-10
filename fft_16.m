function XF = fft_16(input)

N = length(input);

for a = 0:N/4-1
    x = input(1+a : N/4 : N);
    A(1+4*a:4+4*a) = four_dft(x);
end

for k = 0:3
    for a = 0:N/4-1
        B(1+k+a*4) = A(1+k) + (exp(-i*2*pi*(4*a+k)/N) * A(1+k+N/4)) + (exp(-i*4*pi*(4*a+k)/N) * A(1+k+N/2)) + (exp(-i*6*pi*(4*a+k)/N) * A(1+k+3*N/4));
    end
end
XF = B;

end