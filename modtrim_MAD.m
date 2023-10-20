function [y,d,m,w]=modtrim_MAD(x,d,q,dim)
% Modified trimmed mean for ABR detection
% Format:
%      [y,d,m,w]=modtrim_iqr(x,d,q)
% Inputs:
%      x = input matrix (epoch,samples)
%      d = number of displacements taken into account. It can be automaticaly estimated if not given.
%      q = quant,vector of the two element  [Q1-1.5*iqr, Q3+1.5*iqr],
%      where Q1 is 25th percentil and Q3 is 75th percentil of the date in x
% Outputs:
%      y = trimmed output vector
%      m = intermediate matrix to compute the mean
%      w = weighting matrix to compute the mean

% Idileisy Torres Rodrguez & Juan Carlos Oliva 29.04.18


if nargin<3,
    dim = 1;
end
[N,C,D]=size(x);
if N==1 && dim==1
    y=x;
elseif N==1 && dim==2
    y=mean(x,2);
elseif N==1 && dim==3
    y=mean(x,3);
    return
end

if nargin<3||isempty(q), 
 % Encontrar los outliers basados en el rango en MAD,
 % Detecting outliers: Do not use standard deviation around the mean, use
 % absolute deviation around the median, 2013, Christophe Leys, et. al
 % METODO DE DETECCI ON TEMPRANA DE OUTLIERS, 2012, Juan Gabriel Moreno Castel lanos
 Y = mad(x,1);
 b=1./quantile(x,0.75);
 %b=1.4826;
 %MAD=1.4826.*Y;
 MAD=b.*Y;
end
 
if nargin<2||isempty(d), 
   d=4;
end

M=median(x);

m=zeros((2*d+1)*N,C,D);                   % allocated matrix
for i=1:(2*d+1)*N,
    m(i,:,:)=M;                         % default columns are median column
end
m(1:N,:,:)=x;
if d>0
for i=1:d,
    m(N+2*N*(i-1)+1:2*N*i,1:C-i)=x(:,i+1:C);    % i-th advanced version
    m(2*N*i+1:(2*i+1)*N,i+1:C)=x(:,1:C-i);      % i-th delayed version
end
end
[r,c,dd]=size(m);

w=ones(r,c,dd);                            % weighting matrix
%M=repmat(M,r,1);
%tmp=abs(m-M);
% MAD=repmat(MAD,r,1);
% w(tmp>3*MAD)=0;
umbralbajo=M-2.5*MAD;
umbralalto=M+2.5*MAD;
for j=1:dd
for i=1:c
    if umbralalto(1,i,j)>umbralbajo(1,i,j)
   w((m(:,i,j))> umbralalto(1,i,j),i,j)=0;
   w((m(:,i,j))< umbralbajo(1,i,j),i,j)=0;
    end
end
end

y=sum(w.*m)./sum(w);                    % trimmed mean output vector
%y=(y-mean(y))/std(y);