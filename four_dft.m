function XF = four_dft(x)
 N1 = length(x);
for n = 0:N1/2-1
        H(2*n+1) = x(1+n) + x(1+n+N1/2);
        H(2*n+2) = x(1+n) - x(1+n+N1/2);
end
for n = 0:N1/2-1
        XF(1+n) = H(1+n) + exp(-i*2*pi*n/N1) * H(1+n+N1/2);
        XF(1+n+N1/2) = H(1+n) -exp(-i*2*pi*n/N1) * H(1+n+N1/2);
end
end