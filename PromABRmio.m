
function [ABR_block, ABR_Par, ABR_Impar]=PromABRmio(a,n)
% signalblock
% Inputs
% a es la seal completa
% n es la cantidad de muestras que hay en cada poca
m=length(a);

m1=floor(m/n);
ABR_block=zeros(m1,n);
ABR_Par=zeros(floor(m1/2),n);
ABR_Impar=zeros(floor(m1/2),n);

Suma=zeros(n,1);
SumaPar=zeros(n,1);
SumaImpar=zeros(n,1);
Prom=zeros(n,1);
PromPar=zeros(n,1);
PromImpar=zeros(n,1);
j = 1;%para promediar los buffers impares
k = 1;%para promediar los buffers pares

for i = 1:m1
    signal = a(((i-1)*n + 1):(i*n),1);
    ABR_block(i,:)=signal;
    Suma = Suma + signal;
    Prom = Suma/i;
    
    if (rem(i,2) == 0)
        ABR_Par(i/2,:)=signal;
        SumaPar = SumaPar + signal;
        PromPar = SumaPar/k;
        k = k + 1;
    else
        ABR_Impar((i+1)/2,:)=signal;
        SumaImpar = SumaImpar + signal;
        PromImpar = SumaImpar/j;
        j = j + 1;
    end
    
    x = corr2(Prom,PromImpar);
    y = corr2(Prom,PromPar);
    z = corr2(PromImpar,PromPar);
    
    if (i == 1)
%         plot(1:200,Prom,'-g',1:200,PromImpar,'-r',1:200,PromPar,'-b');
%         set(gca,'XTick',0:20:200);
%         set(gca,'XTickLabel',{'0','1.5','3','4.5','6','7.5','9','10.5','12','13.5','15'});
%         xlabel('tiempo en ms');
        x = corr2(Prom,PromImpar);
        y = corr2(Prom,PromPar);
        z = corr2(PromImpar,PromPar);
    end
    if (rem(i,100) == 0)
%         plot(1:200,Prom,'-g',1:200,PromImpar,'-r',1:200,PromPar,'-b');
%         set(gca,'XTick',0:20:200);
%         set(gca,'XTickLabel',{'0','1.5','3','4.5','6','7.5','9','10.5','12','13.5','15'});
%         xlabel('tiempo en ms');
        x = corr2(Prom,PromImpar);
        y = corr2(Prom,PromPar);
        z = corr2(PromImpar,PromPar);
    end
    if (i == m)
        x = corr2(Prom,PromImpar);
        y = corr2(Prom,PromPar);
        z = corr2(PromImpar,PromPar);
%         plot(1:200,Prom,'-g',1:200,PromImpar,'-r',1:200,PromPar,'-b');
%         set(gca,'XTick',0:20:200);
%         set(gca,'XTickLabel',{'0','1.5','3','4.5','6','7.5','9','10.5','12','13.5','15'});
%         xlabel('tiempo en ms');
    end
        
end