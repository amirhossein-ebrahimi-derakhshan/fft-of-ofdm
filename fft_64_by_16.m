function XF = fft_64_by_16(input)

    N = length(input);


    for a = 0:3
        x = input(1+a : 4 : N);
        B(1+16*a:16+16*a) = fft_16(x);
    end

    for k = 0:15
        for n = 0:3
            C(1+k+n*16) = B(1+k) + (exp(-i*2*pi*(16*n+k)/N) * B(1+k+N/4)) + (exp(-i*4*pi*(16*n+k)/N) * B(1+k+N/2)) + (exp(-i*6*pi*(16*n+k)/N) * B(1+k+3*N/4));
        end
    end

XF = C ;

end