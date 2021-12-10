clear;
clc;

D_gi = 1/4;                              %duration of guard interval


file_ID = fopen('OFDM_output_real.txt','r');
R_r = fscanf(file_ID,'%f');
fclose(file_ID);

file_ID = fopen('OFDM_output_imaginary.txt','r');
R_i = fscanf(file_ID,'%f');
fclose(file_ID);

r = R_r' + R_i'*i;                             %received data

%% removing cyclic prefix

R = r(floor((1-(1/(1+D_gi)))*end)+2:end);

%% ftt


N = length(R);

for a = 0:1
    x = R(1+a : 2 : N);
    F(1+4096*a:4096+4096*a) = fft_4096_by_1024(x);
end

for k = 0:4095
    for n = 0:1
        G(1+k+n*4096) = (F(1+k) + (exp(-i*2*pi*(4096*n+k)/N) * F(1+k+N/2)));
    end
end


%% Demapper( QAM demodulation)

G = G * sqrt(42);

for i=0:2^13-1
    temp = G(i+1);
    re = real(temp);
    im = imag(temp);
    if (re > 0)
        output(6*i + 1) = 0;
    else
        output(6*i + 1) = 1;
    end
    
    if (im > 0)
        output(6*i + 2) = 0;
    else
        output(6*i + 2) = 1;
    end
    
    if  (6 < abs(re))
        output(6*i + 3) = 0;
        output(6*i + 5) = 0;
    elseif ((4<abs(re)) && (abs(re)<6))
        output(6*i + 3) = 0;
        output(6*i + 5) = 1;
    elseif ((2<abs(re)) && (abs(re)<4))
        output(6*i + 3) = 1;
        output(6*i + 5) = 1;
    elseif ((0<abs(re)) && (abs(re)<2))
        output(6*i + 3) = 1;
        output(6*i + 5) = 0;
    end
    if  6 < abs(im)
        output(6*i + 4) = 0;
        output(6*i + 6) = 0;
    elseif (4<abs(im) && abs(im)<6)
        output(6*i + 4) = 0;
        output(6*i + 6) = 1;
    elseif (2<abs(im) && abs(im)<4)
        output(6*i + 4) = 1;
        output(6*i + 6) = 1;
    elseif (0<abs(im) && abs(im)<2)
        output(6*i + 4) = 1;
        output(6*i + 6) = 0;
    end

end

file_ID = fopen('inputdata.txt','r');
input = fscanf(file_ID,'%f');
fclose(file_ID);

error = input' - output ; 
max(error)
sum(error)

file_ID = fopen('OUTPUT.txt','w');
fprintf(file_ID,'%3d\n', output);
fclose(file_ID);
