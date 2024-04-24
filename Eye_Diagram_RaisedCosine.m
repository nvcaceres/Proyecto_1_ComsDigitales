
% Script for plotting the eye diagram of the system in which the transmitted signal is
% filtered by the RC.
clc
N  = 10^5; % number of symbols, solo se tomaran las primeras 1000000 muestras
am = 2*(rand(1,N)>0.5)-1 + j*(2*(rand(1,N)>0.5)-1); %random binary sequence BPSK
fs = 10; % sampling frequency in Hz
alpha = 0.5; %roll-off factor
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%RAISED COSINE FILTER

% defining the sinc filter
sincNum = sin(pi*[-fs:1/fs:fs]); % numerator of the sinc function
sincDen = (pi*[-fs:1/fs:fs]); % denominator of the sinc function
sincDenZero = find(abs(sincDen) < 10^-10);
sincOp = sincNum./sincDen;
sincOp(sincDenZero) = 1; % sin(pix/(pix) =1 for x =0

%Raised Cosine Filter

cosNum = cos(alpha*pi*[-fs:1/fs:fs]);
cosDen = (1-(2*alpha*[-fs:1/fs:fs]).^2);
cosDenZero = find(abs(cosDen)<10^-10);
cosOp = cosNum./cosDen;
cosOp(cosDenZero) = pi/4;

gt_alpha35 = sincOp.*cosOp; %RC impulse responde
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Upsampling the transmit sequence 
%With a sampling frequency of fs, we can ‘see’ frequencies from [-fs/2 to fs/2).
%Typically, we would want to control a bigger bandwidth compared to the original transmit sequence.
amUpSampled = [am;zeros(fs-1,length(am))];
amU = amUpSampled(:).';
%--------------------------------------------------------------------------
% filtered sequence using convolution fucntion
st_alpha35 = conv(amU,gt_alpha35);

%--------------------------------------------------------------------------
%One only takes the first 1000000 samples for 
st_alpha35 = st_alpha35([1:1000000]);

st_alpha35_reshape = reshape(st_alpha35,fs*2,N*fs/20).';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%PLOT of Eye Diagrams
close all
figure(1);
plot([-0.99:1/fs:0.99],real(st_alpha35_reshape).','k','LineWidth',.1);   
title('Eye Diagram of the RC pulse for an excess bandwidth');
xlabel('t/T')
ylabel('Amplitude') 
axis([-1 1 -2.5 2.5])
grid on
hold on








