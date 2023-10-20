function y=interpolation(x,L);
% Interpolates the vector x at a rate of 1:L
% Format:
%   y=interpolation(x,L);
% Inputs:
%   x = input vector
%   L = interpolation factor
% Output:
%   y = output vector (interpolated vector)

% A. Taboada Crispi, May 2006, for CIARP 2006

if nargin<2, L=2; end       % default interpolation factor
long=length(x);             % number of samples
x=x-mean(x);                % leaves DC level out
x=x/max(x);                 % normalizes amplitude to 1
x1=zeros(1,long*L);
x1(1:L:end)=x;              % x with L zeros between consecutive samples
fc=0.5/L;                   % cutoff frequency         
win=window('blackmanharris',length(x1));
h=L*2*fc*sinc(2*fc*(-length(x1)/2:length(x1)/2-1)).*win';
% ARREGLAR LINEAS(22 Y 23) 
% Hmay=fft(h); X1may=fft(x1);      
% y=ifft(Hmay.*X1may);
y=conv(h,x1);           % output vector
y=y((end+1)/4+1:(end+1)/4+length(x1));