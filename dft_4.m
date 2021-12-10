function XF = dft_4(x)
% N = length(x);
    for k = 1:4
        X(k) = x(0+1) + x(1+1)*exp(-i*2*pi*k/4) + x(2+1)*exp(-i*4*pi*k/4) + x(3+1)*exp(-i*6*pi*k/4) ;
    end
    XF = X;
end