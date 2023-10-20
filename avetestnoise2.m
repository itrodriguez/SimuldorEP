function [nvector,nmatrix,snr] = avetestnoise2(svector,fs,nb,Amax,refm,rsa,lsa,interf,colorn,vnoise,vimpulse,j,v)
% Generates noise for event-related signals in a wide sense (ERSWS) 
% to study signal 'averaging' methods of detection/analysis.
% Noise and interferences are generated from given amplitudes, frequencies,
% and phases for sinusoidal interferences and baseline wandering noise,
% as well as the standard deviation and cuttoff frequency, order, and 
% approximation for the filter (instrumentation) to get colored noise
%
% [nvectorn,nmatrixn,snr] = 
% avetestnoise(svector,fs,nb,Amax,refm,rsa,lsa,interf,colorn,vnoise);
%
% Inputs:
%   svector = column vector of ERSWS, showing the 'isoelectric' intervals
%   fs = sampling frequency, in ksamples/second, of the waveform, 
%         default value is fs = 1 ksps
%   nb = number of bits of the analog to digital converter (ADC) block, 
%         which determines the resolution (default value is nb=10)
%   Amax = maximun value that can be converted by the ADC 
%         (default value is Amax=4000u)
%   refm = position of reference marks (fiducial marks for segmentation)
%   rsa = number of samples to the right of fid. marks, default=128
%   lsa = number of samples to the left of fid. marks, default=127
%   interf = interference and baseline wandering noise (sinusoidal-related)
%         is a matrix, in which every row (sin) comprises amp. (in u_p), 
%         frequency (in Hz), and initial phase (in rads/s), for instance,
%         interf = [15, 60, pi; 7, 180, 0; 3, 300, pi/2; 10, 0.2, 0];
%   colorn = [approx, order, cutoff, stdn]; colorn = [approx, order,
%   cutoff, stdn, ftype];
%         row vector with information of colored noise, or the
%         analog low-pass filtering (instrumentation) characteristics, ie.,
%               approx = 1 for Bessel approximation (default),
%                        2 for Butterworth approximation,
%                        3 for White Gaussian Noise (no filter)
%               order = order of the analog low-pass filtering (default=8)
%               cutoff = cuttoff frequency in Hz (default = fs/4)
%               stdn = standard deviation of colored noise in u
%         ftype= 'high' for a highpass digital filter with normalized cutoff frequency Wn
%                'low' for a lowpass digital filter with normalized cutoff frequency Wn
%                'stop' for an order 2*n bandstop digital filter if Wn 
%               is a two-element vector, Wn = [w1 w2]. The stopband is w1 < ? < w2.
%   vnoise = vector with values of another kind of noise. This vector
%               should be the same length of svector, otherwise it is
%               composed by concatenation (if <), or truncated (if >)
% Outputs:
%   nvector = column vector of noisy ERSWS
%   nmatrix = N-row matrix of the noisy ERSWS, windowed for analysis
%   snr = estimated global signal to noise ratio
% Plots:
%   -3D representation of nmatrix
%   -Waveforms (XZ plane = amplitude vs. time), highlighting basic waveform
%   -Amplitudes and shimmer (YZ plane = amplitude vs. epoch number)
%   -Widths, positions and jitter (XY plane = epoch number vs. time)
%   -Plot of svector (amplitude vs. time)
%   -3D representation of nmatrix in the frequency domain
%   -Waveforms in the frequency domain (XZ plane = amplitude vs. frequency)
%   -Amplitudes and shimmer in frequency domain (YZ plane)
%   -Widths, positions and jitter in the frequency domain (XY plane)

% A. Taboada Crispi, June 2006

%--------------------------------------------------------------------------
% default values
if (nargin<1)||(isempty(svector)),
    [svector,smatrix,refm,rsa,lsa,amplits,widths,delays,fs,nb,Amax] = avetestsignal2();
end
if (nargin<2)||(isempty(fs)),
    fs=1;           % default sampling frequency = 1 ksps
end
if (nargin<3)||(isempty(nb)),
    nb=12;          % default number of bits of ADC (nb = 10)
end
if (nargin<4)||(isempty(Amax)),
    Amax=4000;      % maximun value that can be converted by the ADC
end
if (nargin<5)||(isempty(refm)),
    refm=128:2*256:length(svector);    % default position of reference marks
end
if (nargin<6)||(isempty(rsa)),
    rsa=128;        % default number of samples to the right of fid. marks
end
if (nargin<7)||(isempty(lsa)),
    lsa=127;        % default number of samples to the left of fid. marks
end
%interference and baseline wandering noise (sinusoidal-related)
if (nargin<8)||(isempty(interf)),
    interf = [max(svector)*15/1000, 60, pi; max(svector)*7/1000, 180, 0; max(svector)*3/1000, 300, pi/2; max(svector)*10/1000, 0.2, 0];
end
if (nargin<9)||(isempty(colorn)),
    colorn(1)=1;      % default colored noise filter approximation (Bessel)
end
if (nargin<10)||(isempty(vnoise)),
    vnoise=zeros(1,length(svector));    % default vnoise (no other noise)
end
if (nargin<11)||(isempty(vimpulse)),
    vimpulse=zeros(1,length(svector));    % default vnoise (no other noise)
end
if (nargin<12)||(isempty(j)),
    j=randi(112);  
end
if (nargin<13)||(isempty(v)),
    v=randi(6);   % default vnoise (no other noise)
end
if length(colorn)<2,
    colorn(2)=8;            % default order for coloring filter
end
if length(colorn)<3,
    colorn(3)=1000*fs/4;    % default cutoff freq for coloring filter
end
if length(colorn)<4,
    colorn(4)=25;    % default standard deviation of colored noise
end
if length(colorn)<5,
   colorn(5)=1;  %default ftype is lowpass filter 1='low'
end
lnoise=length(vnoise);  lvector=length(svector);
if lnoise<lvector,
    k=fix(log2(lvector/lnoise));
    for i=0:k,
        vnoise=[vnoise, vnoise];
    end
end
vnoise=vnoise(1:lvector);      % complete vnoise

%--------------------------------------------------------------------------
% additive noise and interference

if interf==0, 
    interf=[0 0 0]; 
end
matrix=zeros(size(interf,1)+2,lvector);  % allocated matrix
tmp2=zeros(1, size(matrix,2));% allocated matrix
for i=1:size(interf,1),                   % interference and baseline wand.
    matrix(i,:)=interf(i,1)*sin(2*pi*interf(i,2)*(0:1/fs:lvector*1/fs-1/fs)+interf(i,3));
end
matrix(size(interf,1)+1,:)=vnoise;              % other noise
% colored noise, colorn = [approx, order, cutoff, stdn];

if colorn(1) == 1,                              % if Bessel filter
    [Ba,Aa]=besself(colorn(2),2*pi*colorn(3));  % analog coefficients
    [Ba,Aa]=impinvar(Ba,Aa,fs*1000);              % equiv digital coeficients
elseif colorn(1) == 2,                          % if Butterworth filter
   if length(colorn)==5 && colorn(5)==1 %low
        Wn=colorn(3)/(1000*fs/2);
        [Ba,Aa]=butter(colorn(2),Wn);% digital coefficients
   elseif length(colorn)==5 && colorn(5)==2 %hihg
        Wn=colorn(3)/(1000*fs/2);
        [Ba,Aa]=butter(colorn(2),Wn,'high');% digital coefficients
   elseif length(colorn)==6 && colorn(6)==3 %bandpass
        %Paso Bajo fc=3000;
        Wpb=colorn(4)/(fs*1000/2);
        Wsb=(colorn(4)+1500)/(fs*1000/2);
        Rpb=3;
        Rsb=15;
        [npb,Wnb] = buttord(Wpb,Wsb,Rpb,Rsb);
        [Bb,Ab] = butter(npb,Wnb);
        %Paso Alto fc=30;
        Wpa=colorn(3)/(fs*1000/2);
        Wsa=(colorn(3)-10)/(fs*1000/2);
        Rpa=3;
        Rsa=12;
        [na,Wna] = buttord(Wpa,Wsa,Rpa,Rsa);
        [Ba,Aa] = butter(na,Wna);
   elseif length(colorn)==6 && colorn(6)==4 %stopband
        Wn=[colorn(3) colorn(4)]/(1000*fs/2);
        n=color(2);
        ftype='stop';
        [Ba,Aa] = butter(n,Wn,ftype);
   end
else 
    Ba=1; Aa=1;                                   % if White Gaussian noise
end
if length(colorn)==5 && colorn(1)==3
load coeff3; % esto son los cofiecientes estimados por el modelo AR, esto es mio
A=coeff3(j,:);
VarianzasPromedios=[1.06E-15,  3.35E-17;
7.28E-16 , 3.21E-16;
1.06E-15 , 1.75E-17;
3.91E-16 , 8.57E-18;
3.94E-16 , 0.00E+00;
4.11E-16 , 0.00E+00;
]; % Las varianzas promedios estimdas de los 6 sujetos de la base de datos, valor medio y desviacin estndar
vp=(VarianzasPromedios(v,1)-VarianzasPromedios(v,2))+2*VarianzasPromedios(v,2).*rand(1,1);
u = 1000*sqrt(vp)*randn(1,lvector);
tmp=filter(1,A,u,[],1);
tmp2=sum(matrix(1:size(interf,1),:));
load Hdpa1_1
tmp=filter(Hdpa1_1,tmp+tmp2);
% tmp=filter(Ba,Aa,randn(1,lvector),[],1);
% tmp=filter(Bb,Ab,tmp,[],1);
matrix(size(interf,1)+2,:)=max(svector)*colorn(4)*tmp/(1000*std(tmp)); % colored noise

elseif length(colorn)==6 && colorn(1)==3
load coeff3; % esto son los cofiecientes estimados por el modelo AR, esto es mio
C=coeff3(j,:);
VarianzasPromedios=[1.06E-15,  3.35E-17;
7.28E-16 , 3.21E-16;
1.06E-15 , 1.75E-17;
3.91E-16 , 8.57E-18;
3.94E-16 , 9.24E-18;
4.11E-16 , 1.40E-17;
]; 
% -15, -11, -16, -12,
% Las varianzas promedios estimdas de los 6 sujetos de la base de datos, valor medio y desviacin estndar
vp=(VarianzasPromedios(v,1)-VarianzasPromedios(v,2))+2*VarianzasPromedios(v,2).*rand(1,1);
u =sqrt(vp)*randn(1,lvector);
tmp2=sum(matrix(1:size(interf,1),:));
%u1=u+vnoise+tmp2;
%Filtrar paso alto
% load Hdpa1_1
% tmp=filter(Hdpa1_1,u1);
%Filtrar paso bajo
tmp=filter(1,C,u);
%Filtrar paso alto
load Hdpa1_1
tmp=filter(Hdpa1_1,tmp+tmp2);
    %tmp2=sum(matrix(1:size(interf,1),:));
    %tmp=filter(Bb,Ab,randn(1,lvector),[],1);

    
      
%tmp=filter(Ba,Aa,tmp);
matrix(size(interf,1)+2,:)=max(svector)*colorn(5)*tmp/(1000*std(tmp)); % colored noise
end

%nvector=sum(matrix);                           % total additive noise
nvector=tmp+vnoise+vimpulse;
nvector=nvector-mean(nvector);                 % takes DC level off
nvector=nvector+svector;                       % noisy vector 
nvector=nvector-mean(nvector);
%--------------------------------------------------------------------------
% ADC quantization (not affecting first epoch)
lsb=(Amax*10^-6)/2^(nb-1);
nvector(rsa+lsa+1:end)=lsb*round(nvector(rsa+lsa+1:end)/lsb);  
nvector(nvector>Amax)=Amax;               % ADC range limitation
nvector(nvector<-Amax)=-Amax;
%--------------------------------------------------------------------------
% Noisy matrix
nmatrix=windowingmatrix(nvector,refm,rsa,lsa);
smatrix=windowingmatrix(svector,refm,rsa,lsa);
%--------------------------------------------------------------------------
snr=10*log10(var(svector)/var(nvector));  % signal to noise ratio
%--------------------------------------------------------------------------
% % PLOTS
t=0:1/fs:size(nmatrix,2)/fs-1/fs;      % time axis (ms) for nmatrix
t1D=0:1/fs:lvector/fs-1/fs;               % time axis (ms) for svector
N=size(nmatrix,1);
per=lvector/((rsa+lsa+1)*N);
% % 3D plot of smatrix
% figure;                        % Fig. 1
% surf(t,1:N,nmatrix)       
% shading flat
% % colormap(gray)
% colormap(pink)
% xlabel('time (ms)');
% ylabel('epoch number');
% zlabel('amplitude (u)');
% title(['3D Noisy Waveform @ ',num2str(fs),'ksps, ',num2str(nb),'-bit ADC (+/-',num2str(Amax),'u)']);
% axis([0 max(t) 1 N 1.2*min(svector) 1.2*max(svector)]);
% 
% figure;                         % Fig. 2
% % Amplitudes and shimmer (YZ plane = amplitude vs. epoch number)
% subplot(221)
% plot(1:N,nmatrix','Color',[207/255 169/255 146/255]); hold on
% plot(1:N,max(nmatrix'),'r','LineWidth',2); hold off % shimmer
% xlabel('epoch number');
% set(gca,'YTickLabel',{[]})
% axis([1 N 1.2*min(svector) 1.2*max(svector)]);
% set(gca,'PlotBoxAspectRatio',[1 1 1]);
% % Waveforms (XZ plane = amplitude vs. time)
% subplot(222)
% plot(t,nmatrix,'Color',[207/255 169/255 146/255]); title('Seal Simulada sin Artefactos'), hold on
% plot(t,svector(1,1:rsa+lsa+1),'r','LineWidth',1); hold off  % basic
% xlabel('Tiempo (ms)');
% ylabel('Amplitud (V)');
% axis([0 max(t) 1.2*min(svector) 1.2*max(svector)]);
% % Widths, positions and jitter (XY plane = epoch number vs. time)
% subplot(224)
% pcolor(t,1:N,nmatrix);
% shading flat
% % colormap(gray)
% colormap(pink)
% % hold on
% % plot(onsets,1:N,'r','LineWidth',1);                  % onsetss
% % plot(onsets+widths,1:N,'r','LineWidth',1); hold off  % onsets+widths
% ylabel('epoch number');
% set(gca,'XTickLabel',{[]})
% axis([0 max(t) 1 N]);
% colorbar;
% % Info
% subplot(223)
% message1=['Noisy Waveform @ ',num2str(fs),'ksps'];
% text(0.05,0.5,message1);
% set(gca,'XTickLabel',{[]})
% set(gca,'YTickLabel',{[]})
% axis off
% 
% % Plot of nvector (amplitude vs. time)
% figure;                         % Fig. 3
% plot(t1D,nvector,'r'); grid
% xlabel('Tiempo (ms)');
% ylabel('amplitude (u)');
% title(['1D Noisy Waveform @ ',num2str(fs),'ksps, ',num2str(nb),'-bit ADC (+/-',num2str(Amax),'u)']);
% axis([0 max(t1D) 1.2*min(svector) 1.2*max(svector)]);
% 
% % Plot of nvector (amplitude vs. time) for epochs 1, 2, and N
% figure;                         % Fig. 4
% subplot(131)
% plot(t1D(refm(1)-lsa:refm(1)+rsa),nvector(refm(1)-lsa:refm(1)+rsa),'r'); 
% % hold on
% % line(onsets(1),1.2*min(rvector):max(rvector)/40:1.2*max(rvector),'LineStyle',':')
% % line(onsets(1)+widths(1),1.2*min(rvector):max(rvector)/40:1.2*max(rvector),'LineStyle',':')
% ylabel('amplitude (u)');
% title('Epoch 1');
% axis([t1D(refm(1)-lsa) t1D(refm(1)+rsa) 1.2*min(nvector) 1.2*max(nvector)]);
% subplot(132)
% plot(t1D(refm(2)-lsa:refm(2)+rsa),nvector(refm(2)-lsa:refm(2)+rsa),'r'); 
% % hold on
% % line(t1D(per*(rsa+lsa+1))+onsets(2),1.2*min(rvector):max(rvector)/40:1.2*max(rvector),'LineStyle','--')
% % line(t1D(per*(rsa+lsa+1))+onsets(2)+widths(2),1.2*min(rvector):max(rvector)/40:1.2*max(rvector),'LineStyle','--')
% % line(0:find(max(rvector(per*length(xw)+1:(per+1)*length(xw)))),max(rvector(per*length(xw)+1:(per+1)*length(xw))),'LineStyle','--')
% set(gca,'YTickLabel',{[]})
% title('Epoch 2');
% axis([t1D(refm(2)-lsa) t1D(refm(2)+rsa) 1.2*min(nvector) 1.2*max(nvector)]);
% subplot(133)
% plot(t1D(refm(N)-lsa:refm(N)+rsa),nvector(refm(N)-lsa:refm(N)+rsa),'r'); 
% % line(t1D(end-per*length(xw))+onsets(N),1.2*min(rvector):max(rvector)/40:1.2*max(rvector),'LineStyle','--')
% % line(t1D(end-per*length(xw))+onsets(N)+widths(N),1.2*min(rvector):max(rvector)/40:1.2*max(rvector),'LineStyle','--')
% set(gca,'YTickLabel',{[]})
% set(gca,'XTickLabel',{[]})
% xlabel('time (ms)');
% title('Epoch N');
% axis([t1D(refm(N)-lsa) t1D(refm(N)+rsa) 1.2*min(nvector) 1.2*max(nvector)]);
% 
% % Plots with Frequency Info
% Y = fft(nmatrix,[],2);
% Ya=abs(Y);
% Yp=Ya(:,1:size(Ya,2)/2);
% Yi=fft(svector(1:rsa+lsa+1));
% Yai=abs(Yi);
% Ypi=Yai(:,1:length(Yai)/2);
% f=linspace(0,1000*fs/2,size(Ya,2)/2);
% 
% % 3D plot of smatrix
% figure;                        % Fig. 5
% surf(f,1:N,Yp)       
% shading flat
% colormap(pink)
% xlabel('frequency (Hz)');
% ylabel('epoch number');
% zlabel('amplitude (u)');
% title(['3D Noisy Waveform @ ',num2str(fs),'ksps, ',num2str(nb),'-bit ADC (+/-',num2str(Amax),'u)']);
% axis([0 max(f)/2.5 1 N 0 1.2*max(max(Yp))]);
% 
% figure;                         % Fig. 6
% % Amplitudes and shimmer (YZ plane = FFT amplitude vs. epoch number)
% subplot(221)
% plot(1:N,Yp','Color',[207/255 169/255 146/255]); 
% hold on
% plot(1:N,max(smatrix'),'r','LineWidth',2); hold off % shimmer
% xlabel('epoch number');
% set(gca,'YTickLabel',{[]})
% axis([1 N 0 1.2*max(max(Yp))]);
% set(gca,'PlotBoxAspectRatio',[1 1 1]);
% % Waveforms (XZ plane = amplitude vs. frequency)
% subplot(222)
% plot(f,Yp,'Color',[207/255 169/255 146/255]); hold on
% plot(f,Ypi,'r','LineWidth',1); hold off  % basic
% xlabel('frequency (Hz)');
% ylabel('amplitude (u)');
% axis([0 max(f)/2.5 0 1.2*max(max(Yp))]);
% % Widths, positions and jitter (XY plane = epoch number vs. frequency)
% subplot(224)
% pcolor(f,1:N,Yp);
% shading flat
% colormap(pink)
% hold on
% ylabel('epoch number');
% % plot(onsets,1:N,'r','LineWidth',1);                  % onsetss
% % plot(onsets+widths,1:N,'r','LineWidth',1); hold off  % onsets+widths
% set(gca,'XTickLabel',{[]})
% axis([0 max(f)/2.5 1 N]);
% colorbar;
% % Info
% subplot(223)
% message1=['Noisy Waveform @ ',num2str(fs),'ksps'];
% text(0.05,0.5,message1);
% set(gca,'XTickLabel',{[]})
% set(gca,'YTickLabel',{[]})
% axis off