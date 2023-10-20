% weigth average
function [y, y1,y2] = w_mean(x,Sa,dim)
% [y,y1] = w_mean(x,dim) 
%calcula el promedio pesado usando el mtodo de minimizacin del error cuadrtico medio
% y1 Usa la estimacin de la varianza del ruido usando laguna pag 214,
% variando el ruido
% y2 Usa la estimacin de la varianza del ruido usando laguna pag 215
% variando la amplitud
%Format:
%        y = w_mean(x,dim)
%   Inputs:
%        x = input vector or matrix
%        dim = dimension of the matrix in which the averaging should be performed (default=1, row)
%        y = output vector or matrix averaged

% Idileisy Torres  2017/06/05
if nargin<3,
    dim=1;
end
if nargin<2,
   Sa=mean(x);
end
[r,c]=size(x);
if dim==1
w=zeros(1,r);
variance=zeros(1,r); % asume la varianza constante en cada potencial
elseif dim==2
w=zeros(1,c);
variance=zeros(1,c);
end
variance=var(x');
for i=1:size(variance')
     w(i)=1/(variance(i)*sum(variance));
end
w=w/sum(w);
w=w/median(w);
%
varianza=1/c*x*x';% x*x' matriz de correlacin que caracteriza el ruido aditivo
varianza=diag(varianza); %los elementos de la diagonal describen la varianza del ruido en cada potencial
peso=zeros(r,1);
for i=1:r
peso(i)=1/sum(1./varianza)*1/varianza(i);
end
peso=peso/median(peso);
y1=zeros(r,c);
for i=1:r
y1(i,:)=(peso(i)*x(i,:));
end
%

pes=x*Sa'; % Si vara la amplitud y la varianza del ruido es constante, pero debo tener un valor de la seal estimada
cw=pes'*pes;
cw=1/cw;
pes1=cw*pes;
pes1=pes1/median(pes1);
y2=zeros(r,c);
for i=1:r
y2(i,:)=(pes1(i)*x(i,:));
end
y2=sum(y2)-mean(sum(y2));
%y2=(y2-mean(y2))/std(y2);
y=(w*x);
%y=(y-mean(y))/std(y);
y1=sum(y1);
%y1=(y1-mean(y1))/std(y1);
