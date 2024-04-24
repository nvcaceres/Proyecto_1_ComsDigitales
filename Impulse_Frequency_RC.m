%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for plotting the time domain and frequency domain representation
% of raised cosine filters for various values of alpha
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
fs =10;
NFFT=1024;
FPulse=[-NFFT/2:NFFT/2-1]/NFFT;
alpha = 0.35;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%defining the RC filter
sincNum = sin(pi*[-fs:1/fs:fs]); % numerator of the sinc function
sincDen = (pi*[-fs:1/fs:fs]); % denominator of the sinc function
sincDenZero = find(abs(sincDen) < 10^-10);
sincOp = sincNum./sincDen;
sincOp(sincDenZero) = 1; % sin(pix/(pix) =1 for x =0

cosNum = cos(alpha*pi*[-fs:1/fs:fs]);
cosDen = (1-(2*alpha*[-fs:1/fs:fs]).^2);
cosDenZero = find(abs(cosDen)<10^-10);
cosOp = cosNum./cosDen;
cosOp(cosDenZero) = pi/4;

RC_Filter = sincOp.*cosOp;
RC_Filter_Spectrum = (abs((fft(RC_Filter,NFFT))/fs));
RC_Filter_Spectrum_dB = 20*log10((fft(RC_Filter,NFFT))/fs);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Respuesta al Impulso
close all
figure(1)
plot([-fs:1/fs:fs],[RC_Filter],'--kd','LineWidth',1)
hold on


legend('RC');
axis([0 5 -.2 1.1])
hold all

grid on
xlabel('Time, t/T')
ylabel('Amplitude, h(t)')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Respuesta en Frecuencia
figure(2)
plot(FPulse*2*fs, fftshift(RC_Filter_Spectrum),'--kd','LineWidth',1);
hold on


legend('RC');
axis([-1.7 1.7 0 1])

grid on
xlabel('f/B')
ylabel('H(f)/T')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Spectral Magnitude
figure(3)
plot(FPulse*2*fs, fftshift(RC_Filter_Spectrum_dB),'--kd','LineWidth',1);
hold on


legend('RC');
grid on
xlabel('f/B')
ylabel('dB')
%--------------------------------------------------------------------------
%-------------------------------------------------------------------------


