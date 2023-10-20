function [svector,smatrix,refm,rsa,lsa,amplits,widths,delays,fs,nb,Amax] = avetestsignal2(wave,wp,A,fs,per,N,aml,pam,wml,pwm,pml,ppm,pp,nb,Amax,os)
%AVETESTSIGNAL generates event-related signals in a wide sense (ERSWS)
% to study signal 'averaging' methods of detection/analysis.
% Signals are generated from a basic waveform, given the shimmer, jitter,
% and width modulation, affecting the basic waveform in every event (epoch)
%
%[svector,smatrix,refm,rsa,lsa,amplits,widths,delays,fs,nb,Amax] =
%avetestsignal(wave,wp,A,fs,per,N,aml,pam,wml,pwm,pml,ppm,pp,nb,Amax,os);
%
% Inputs:
%   wave = waveform
%             'db1' = first order Daubechies wavelet or Haar wavelet
%             'db2' = second order Daubechies wavelet ...
%             'dbO' = Daubechies wavelet of order O (O is integer, 1<O<10)
%             'sym2' = second order Symlets wavelet
%             'sym3' = third order Symlets wavelet ...
%             'symO' = Symlets wavelet of order O (O is integer, 2<O<8)
%             'coif1' = first order Coiflets wavelet
%             'coif2' = second order Coiflets wavelet ...
%             'coifO' = Coiflets wavelet of order O (O is integer, 1<O<5)
%             'gaus1' = first order Gaussian wavelet (default value)
%             'gaus2' = second order Gaussian wavelet or Mexican hat ...
%             'gausO' = Gaussian wavelet of order O (O-th derivative)
%             'meyr' = Meyer wavelet
%             'morl' = Morlet wavelet
%             'othr' = other waveform (a vector has to be passed to wp)
%   wp = waveform parameters
%           if wave is a wavelet, then wp = iter (the number of samples of
%               the wavelet will be forced to 2^iter), default wp = 8
%           if wave=='othr', then wp = vector with the waveform, (the
%               number of samples should be a power of 2, or slightly lower,
%               otherwise a zero padding will be done to complete it
%   A = amplitude of the waveform, in units (u), default value A = 1000 u
%   fs = sampling frequency, in ksamples/second, of the waveform (the
%           width of this waveform (w0) will be obtained from fs and the
%           number of points of the waveform), default value is fs = 1 ksps
%   per = relative period of the event, in times of the analysis window
%           length (default value of period is per = 3)
%   N = number of events, N is usually a power of 2 (default value N = 64)
%   aml = amplitude modulation (shimmer) law
%         'null' = no amplitude modulation
%         'sin' = sinusoidal variation around A (default AM law)
%         'rand' = random variation (uniform distribution) around A
%         'randn' = random variation (normal distribution) around A
%         'othr' = other variation law around A (a vector is passed to pam)
%   pam = amplitud modulation parameter(s)
%           if aml=='sin', then pam = [ra rf rp], where
%               ra = relative amplitude, fraction of A (0 < ra < 1)
%               rf = relative frequency (0 < rf < 0.5)
%               rp = relative phase (0 < rp < 2pi)
%           if aml=='rand', then pam = rv, where rv is the relative
%                   variation, as a fraction of A (0 < rv < 1)
%           if aml=='randn', then pam = rsd, where rsd is the relative
%                   standard deviation, as a fraction of A (0 < rsd < 1/5)
%           if aml=='othr', then pam = vector with N values between -A and A,
%                   otherwise it is composed by concatenation (if <), or
%                   truncated (if >)
%           if aml=='nul', then pam = 0
%   wml = width modulation law
%         'null' = no width modulation
%         'sin' = sinusoidal variation around the width of the initial wave
%                                                               (w0, in ms)
%         'rand' = random variation (uniform distribution) around w0
%         'randn' = random variation (normal distribution) around w0
%         'othr' = other variation law around w0 (a vector is passed to pwm)
%   pwm = width modulation parameter(s)
%           if wml=='sin', then pwm = [ra rf rp], where
%               ra = relative amplitude, fraction of w0 (0 < ra < 0.5)
%               rf = relative frequency (0 < rf < 0.5)
%               rp = relative phase (0 < rp < 2pi)
%           if wml=='rand', then pwm = rv, where rv is the relative
%                   variation, as a fraction of w0 (0 < rv < 0.5)
%           if wml=='randn', then pwm = rsd, where rsd is the relative
%                   standard deviation, as a fraction of w0 (0 < rsd < 0.1)
%           if wml=='othr', then pwm = vector with N values between
%                   -w0/2 and w0/2, otherwise it is composed by
%                   concatenation (if <), or truncated (if >)
%           if wml=='nul', then pwm = 0
%   pml = position modulation (jitter) law
%         'null' = no position modulation
%         'sin' = sinusoidal variation around the position of initial wave
%         'rand' = random variation (uniform distribution) around t0
%         'randn' = random variation (normal distribution) around t0 (def.)
%         'othr' = other variation law around t0 (vector is passed to ppm)
%   ppm = position modulation parameter(s)
%           if pml=='sin', then pwm = [ra rf rp], where
%               ja = jitter amplitude, in ms (default = 2ms)
%               rf = relative frequency (0 < rf < 0.5)
%               rp = relative phase (0 < rp < 2pi)
%           if pml=='rand', then ppm = rv, where rv is the relative
%                   variation, as a fraction of w0 (0 < rv < 0.5)
%           if pml=='randn', then ppm = rsd, where rsd is the relative
%                   standard deviation, as a fraction of w0 (0 < rsd < 1/10)
%           if pml=='othr', then ppm = vector with N values between
%                   -w0/2 and w0/2, otherwise it is composed by
%                   concatenation (if <), or truncated (if >)
%           if pml=='nul', then ppm = 0
%   pp = pivot position or position taken as a reference for the wave
%           pp = 'c' when the pivot is the center of the waveform (default)
%           pp = 'o' when the pivot is the onset of the waveform
%   nb = number of bits of the analog to digital converter (ADC) block,
%           which determines the resolution (default value is nb=10)
%   Amax = maximun value that can be converted by the ADC
%           (default value is Amax=4*A)
%   os = oversampling factor to get the 'continuos' waveforms
%           (signals are oversampled at 2^os times), default value is os=4
%
% Outputs:
%   svector = column vector of ERSWS, showing the 'isoelectric' intervals,
%               that is, those segments between the analysis windows.
%               Therefore, the total number of points in svector is
%               PER times higher than in smatrix
%   smatrix = N-row matrix of the ERSWS, windowed for analysis,
%               where the first row represents the reference waveform
%               centered in the analysis window of twice the width
%               of the basic waveform
%   refm = position of reference marks (fiducial marks for segmentation)
%   rsa = number of samples to the right of fid. marks, default=156
%   lsa = number of samples to the left of fid. marks, default=99
%   amplits = column vector of maximun amplitudes of the N ERSWS, in u
%   widths  = column vector of widths of the N ERSWS, in ms
%   delays  = column vector of delays respect to t0 of the N ERSWS, in ms
%   inputs fs, nb, Amax are given as outputs as well...
% %plots:
%   -3D representation of smatrix in the time domain
%   -Waveforms (XZ plane = amplitude vs. time), highlighting basic waveform
%   -Amplitudes and shimmer (YZ plane = amplitude vs. epoch number)
%   -Widths, positions and jitter (XY plane = epoch number vs. time)
%   -svector (amplitude vs. time)
%   -3D representation of smatrix in the frequency domain
%   -Waveforms in the frequency domain (XZ plane = amplitude vs. frequency)
%   -Amplitudes and shimmer in frequency domain (YZ plane)
%   -Widths, positions and jitter in the frequency domain (XY plane)

% A. Taboada Crispi, May-June 2006
% I.Torres-Rodrguez 2020
%--------------------------------------------------------------------------
% default values
if (nargin<1)||(isempty(wave)),
    wave='gaus1';   % default waveform (1st order Gaussian wavelet)
end
if (nargin<2)||(isempty(wp)),
    wp=7;           % default number of iterations (waveform of 128 points)
end
if (nargin<3)||(isempty(A)),
    A=1000;          % default amplitude value (A = 1000 u)
end
if (nargin<4)||(isempty(fs)),
    fs=0.5;           % default sampling frequency (fs = 1 ksps)
end
if (nargin<5)||(isempty(per)),
    per=2;          % default period (per = 2 times analysis window length)
end
if (nargin<6)||(isempty(N)),
    N=64;          % default number of events (N = 64)
end
if (nargin<7)||(isempty(aml)),
    aml='sin';      % default AM law (sinusoidal)
end
if (nargin<8)||(isempty(pam)),
    pam=0.05; % default AM parameter (modulation of 5%)
end
if (nargin<9)||(isempty(wml)),
    wml='sin';      % default width mod law (sinusoidal)
end
if (nargin<10)||(isempty(pwm)),
    pwm=0.05;       % default width mod parameter (modulation of 5%)
end
if (nargin<11)||(isempty(pml)),
    pml='randn';    % default delay modulation law (random Gaussian)
end
if (nargin<12)||(isempty(ppm)),
    ppm=2;          % default delay modulation parameter (std=2ms)
end
if (nargin<13)||(isempty(pp)),
    pp='c';          % default pivot position (center of the waveform)
end
if (nargin<14)||(isempty(nb)),
    nb=10;          % default number of bits of ADC (nb=10)
end
if (nargin<15)||(isempty(Amax)),
    Amax=4*A;       % maximun value that can be converted by the ADC
end
if (nargin<16)||(isempty(os)),
    os=4;           % oversampling to get 'continuos' signals (16x)
end

% if 2^fix(log2(N))~=N,
%     N=2^(fix(log2(N))+1);      % forces N to the next power of two
% end

if strcmp(aml(1:3),'sin')           % if AM law is sinusoidal
    if length(pam)<1,
        ra=0.05;               % default relative amplitude = 0.05
        pam(1)=ra;
    end
    if length(pam)<2,
        rf=1/7;                % default relative freq = 1/7
        pam(2)=rf;
    end
    if length(pam)<3,
        rp=0;                  % default relative phase = 0
        pam(3)=rp;
    end
    am=pam(1)*sin(2*pi*pam(2)*(0:N-1)+pam(3));
elseif strcmp(aml(1:3),'ran')
    if strcmp(aml,'randn')
        am=pam*randn(1,N);
        am(am<-1)=-1;
        am(am>1)=1;
    else
        am=2*pam*rand(1,N)-pam;
    end
elseif strcmp(aml(1:3),'nul')
    am=zeros(1,N);
elseif strcmp(aml(1:3),'oth')
    [r,c]=size(aml);
    if r>c, aml=aml'; end       % forces to row vector
    while length(aml)<N,
        aml=[aml aml];          % concatenates
    end
    am=pam(1:N);                % truncates
end
am(am>A)=A;
am(am<-A)=-A;

if strcmp(wml(1:3),'sin')            % if WM law is sinusoidal
    if length(pwm)<1,
        ra=0.05;               % default relative amplitude = 0.05
        pwm(1)=ra;
    end
    if length(pwm)<2,
        rf=1/7;               % default relative freq = 1/7
        pwm(2)=rf;
    end
    if length(pwm)<3,
        rp=0;                  % default relative phase = 0
        pwm(3)=rp;
    end
    wm=pwm(1)*sin(2*pi*pwm(2)*(0:N-1)+pwm(3));
elseif strcmp(wml(1:3),'ran')
    if strcmp(wml,'randn')
        wm=pwm*randn(1,N);
        wm(wm<-0.5)=-0.5;
        wm(wm>0.5)=0.5;
    else                      % wml='rand',
        wm=2*pwm*rand(1,N)-pwm;
    end
elseif strcmp(wml(1:3),'nul')
    wm=zeros(1,N);
elseif strcmp(wml(1:3),'oth')
    [r,c]=size(wml);
    if r>c, wml=wml'; end       % forces to row vector
    while length(wml)<N,
        wml=[wml wml];          % concatenates
    end
    wm=pwm(1:N);                % truncates
end

if strcmp(pml(1:3),'sin')             % if delay mod law is sinusoidal
    if length(ppm)<1,
        ja=2;                  % default relative amplitude = 2ms
        ppm(1)=ja;
    end
    if length(ppm)<2,
        rf=1/7;                % default relative freq = 1/7
        ppm(2)=rf;
    end
    if length(ppm)<3,
        rp=0;                  % default relative phase = 0
        ppm(3)=rp;
    end
    pm=ppm(1)*sin(2*pi*ppm(2)*(0:N-1)+ppm(3));
elseif strcmp(pml(1:3),'ran')
    if strcmp(pml,'randn')
        pm=ppm*randn(1,N);
        %         pm(pm<-0.5)=-0.5;
        %         pm(pm>0.5)=0.5;
    else                   % pml='rand',
        pm=2*ppm*rand(1,N)-ppm;
    end
elseif strcmp(pml(1:3),'nul')
    pm=zeros(1,N);
elseif strcmp(pml(1:3),'oth')
    [r,c]=size(pml);
    if r>c, pml=pml'; end       % forces to row vector
    while length(pml)<N,
        pml=[pml pml];          % concatenates
    end
    pm=ppm(1:N);                % truncates
end
%--------------------------------------------------------------------------
% Basic waveform and 'continuos' basic waveform
if strcmp(wave(1:3),'oth')           % if the waveform is given as a vector wp,
    x=wp;                      % basic waveform
    [r,c]=size(x); if r>c, x=x'; end
    long=length(x);            % length of x is forced to the
    lon=2^ceil(log2(long));    % next power of two by zero padding
    zer=lon-long;              % zeros to pad (half at both sides)
    x=[zeros(1,round(zer/2)) x zeros(1,zer-round(zer/2))]; % zero padding
    xc=interpolation(x,2^os);  % obtains the initial 'continuous' waveform
else                          % if the basic waveform is a wavelet,
    x=mywavefun(wave,wp);      % obtains the basic waveform
    xc=mywavefun(wave,wp+os);  % obtains the initial 'continuous' waveform
end
xc=xc-mean(xc); x=x-mean(x);   % cancels DC level out
xc=A*xc/max(xc); x=A*x/max(x); % forces amplitude to A
w0=length(x)/fs;               % width of the basic waveform, in ms
wm(wm>w0/2)=w0/2;
wm(wm<-w0/2)=-w0/2;
pm(pm>w0/2)=w0/2;
pm(pm<-w0/2)=-w0/2;
%--------------------------------------------------------------------------
% Basic waveforms in analysis windows
xw=[zeros(1,length(x)/2) x zeros(1,length(x)/2)];
xcw=[zeros(1,length(xc)/2) xc zeros(1,length(xc)/2)];   % 'continuos'
%--------------------------------------------------------------------------
% Matrix
smatrix=zeros(N,length(xw));   % allocated matrix
smatrixc=zeros(N,length(xcw)); % allocated matrix
onsets=zeros(N,1);             % allocated matrix
onsets(1,1)=length(xw)/4;
if pp=='o',              % waveform onset as pivot
    pivotc=length(xcw)/4;   pivot=length(xw)/4;
else                    % center of waveform as pivot
    pivotc=length(xcw)/2;   pivot=length(xw)/2;
end
for i=2:N,
    L=round(100*(1+wm(i))); M=100;
    tmp=resample(xc,L,M);    % shrinked/expanded basic 'continuos' wave
    if pp=='o',              % waveform onset as pivot
        %ini=round(pivotc+(2^os)*pm(i)/fs)+1;
        ini=round(pivotc+(2^os)*pm(i)*fs)+1;
        pm(i)=(ini-pivotc-1)/2^os; % corrected delay according to delta-t min
    else                    % center of waveform as pivot
        % ini=round((pivotc-length(tmp)/2+(2^os)*pm(i))/fs)+1;
        ini=round((pivotc-length(tmp)/2+(2^os)*pm(i)*fs))+1;
        pm(i)=(ini-pivotc+length(tmp)/2-1)/2^os; % corrected delay according to delta-t min
    end
    en=ini+length(tmp)-1;
    smatrixc(i,ini:en)=(1+am(i))*tmp;
    
    %smatrix(i,:)=decimation(smatrixc(i,:),2^os);
    smatrix(i,:)=decimate(smatrixc(i,:),2^os);
    onsets(i,1)=ini/2^os; % corrected onsets according to delta-t min
end
smatrix(1,:)=xw;                            % 1st epoch is the basic waveform
% ADC quantization
lsb=Amax/2^(nb-1);
smatrix(2:N,:)=lsb*round(smatrix(2:N,:)/lsb);
smatrix(smatrix>Amax)=Amax;               % ADC range limitation
smatrix(smatrix<-Amax)=-Amax;
%--------------------------------------------------------------------------
% Modulation laws (values vs. realization number)
amplits=max(smatrix,[],2);         % maximun amplitudes of the N ERSWS, in u
widths=(wm'+1)*w0;              % widths of the N ERSWS, in ms
delays=pm'+pivot;                     % delays of the N ERSWS, in ms
%--------------------------------------------------------------------------
% PLOTS
t=0:1/fs:(size(xw,2)-1)/fs;      % time axis (ms) for smatrix and analysis w.
% tc=0:1/(fs*2^os):size(xcw,2)-1/(fs*2^os);   % 'continuos' time axis (ms)
% t1D=0:1/fs:per*N*length(t);     % time axis (ms) for svector

%svector=zeros(1,round(per*N*length(t)));  % allocation vector
svector=zeros(1,round(N*length(t)));  % allocation vector
for i=0:N-1;
    svector(1,round(i*length(t))+1:round(i*length(t))+length(xw))=smatrix(i+1,:);
end
%--------------------------------------------------------------------------
%   refm = position of reference marks (fiducial marks for segmentation)
refm=size(smatrix,2)/2:per*size(smatrix,2):length(svector);
%   rsa = number of samples to the right of fid. marks
rsa=size(smatrix,2)/2;
%   lsa = number of samples to the left of fid. marks
lsa=size(smatrix,2)/2-1;
% % 3D plot of smatrix
% figure;                        % Fig. 1
% surf(t,1:N,smatrix)
% shading flat
% % colormap(gray)
% colormap(pink)
% xlabel('time (ms)');
% ylabel('epoch number');
% zlabel('amplitude (u)');
% title(['3D Waveform=',wave,' @ ',num2str(fs),'ksps, ',num2str(nb),'-bit ADC (+/-',num2str(Amax),'u)']);
% axis([0 max(t) 1 N 1.2*min(svector) 1.2*max(svector)]);
% %
% figure;                         % Fig. 2
% % Amplitudes and shimmer (YZ plane = amplitude vs. epoch number)
% subplot(221)
%
% % surf(t,1:N,smatrix)
% % shading flat
% % colormap(pink)
% % view(90,0);
% % ylabel('epoch number');
% % axis([0 max(t) 1 N 1.2*min(svector) 1.2*max(svector)]);
% % set(gca,'ZTickLabel',{[]})
%
% [ro,co]=size(smatrix);
% if ro>=co,
%     mplot=smatrix';
% else,
%     mplot=smatrix;
% end
% plot(1:N,mplot','Color',[207/255 169/255 146/255]); hold on
% plot(1:N,max(smatrix'),'r','LineWidth',2); hold off % shimmer
% xlabel('epoch number');
% set(gca,'YTickLabel',{[]})
% axis([1 N 1.1*min(svector) 1.1*max(svector)]);
%
% set(gca,'PlotBoxAspectRatio',[1 1 1]);
%
% % Waveforms (XZ plane = amplitude vs. time)
% subplot(222)
% % plot(t,smatrix,'Color',[.5 .5 .5]); hold on
% plot(t,mplot,'Color',[207/255 169/255 146/255]); hold on
% plot(t,xw,'r','LineWidth',1); hold off  % basic
% xlabel('time (ms)');
% ylabel('amplitude (u)');
% axis([0 max(t) 1.2*min(svector) 1.2*max(svector)]);
% % Widths, positions and jitter (XY plane = epoch number vs. time)
% subplot(224)
% pcolor(t,1:N,smatrix);
% shading flat
% % colormap(gray)
% colormap(pink)
% hold on
% plot(onsets,1:N,'r','LineWidth',1);                  % onsetss
% plot(onsets+widths,1:N,'r','LineWidth',1); hold off  % onsets+widths
% ylabel('epoch number');
% set(gca,'XTickLabel',{[]})
% axis([0 max(t) 1 N]);
% colorbar;
% % Info
% subplot(223)
% message1=['Waveform=',wave,' @ ',num2str(fs),'ksps'];
% message2=['Shimmer variation: ',aml];
% message3=['Trigger variation: ',pml];
% message4=['Width variation: ',wml];
% text(0.05,0.8,message1);
% text(0.05,0.6,message2);
% text(0.05,0.4,message3);
% text(0.05,0.2,message4);
% set(gca,'XTickLabel',{[]})
% set(gca,'YTickLabel',{[]})
% axis off
%
% % % Plot of svector (amplitude vs. time)
% % figure;                         % Fig. 3
% % plot(t1D,svector,'r'); grid
% % xlabel('time (ms)');
% % ylabel('amplitude (u)');
% % title(['1D Waveform=',wave,' @ ',num2str(fs),'ksps, ',num2str(nb),'-bit ADC (+/-',num2str(Amax),'u)']);
% % axis([0 max(t1D) 1.2*min(svector) 1.2*max(svector)]);
% %
% % % Plot of svector (amplitude vs. time) for epochs 1, 2, and N
% % figure;                         % Fig. 4
% % subplot(131)
% % plot(t1D(1:length(xw)),svector(1:length(xw)),'r'); hold on
% % line(onsets(1),1.2*min(svector):max(svector)/40:1.2*max(svector),'LineStyle',':')
% % line(onsets(1)+widths(1),1.2*min(svector):max(svector)/40:1.2*max(svector),'LineStyle',':')
% % ylabel('amplitude (u)');
% % title('Epoch 1');
% % axis([0 length(xw)-1 1.2*min(svector) 1.2*max(svector)]);
% % subplot(132)
% % plot(t1D(per*length(xw)+1:(per+1)*length(xw)),svector(per*length(xw)+1:(per+1)*length(xw)),'r'); hold on
% % line(t1D(per*length(xw))+onsets(2),1.2*min(svector):max(svector)/40:1.2*max(svector),'LineStyle','--')
% % line(t1D(per*length(xw))+onsets(2)+widths(2),1.2*min(svector):max(svector)/40:1.2*max(svector),'LineStyle','--')
% % % line(0:find(max(svector(per*length(xw)+1:(per+1)*length(xw)))),max(svector(per*length(xw)+1:(per+1)*length(xw))),'LineStyle','--')
% % set(gca,'YTickLabel',{[]})
% % title('Epoch 2');
% % axis([t1D(per*length(xw)+1) t1D((per+1)*length(xw)) 1.2*min(svector) 1.2*max(svector)]);
% % subplot(133)
% % plot(t1D(end-per*length(xw)+1:end-(per-1)*length(xw)),svector(end-per*length(xw)+1:end-(per-1)*length(xw)),'r');
% % line(t1D(end-per*length(xw))+onsets(N),1.2*min(svector):max(svector)/40:1.2*max(svector),'LineStyle','--')
% % line(t1D(end-per*length(xw))+onsets(N)+widths(N),1.2*min(svector):max(svector)/40:1.2*max(svector),'LineStyle','--')
% % set(gca,'YTickLabel',{[]})
% % set(gca,'XTickLabel',{[]})
% % xlabel('time (ms)');
% % title('Epoch N');
% % axis([t1D(end-per*length(xw)+1) t1D(end-(per-1)*length(xw)) 1.2*min(svector) 1.2*max(svector)]);
% %
% % % Plots with Frequency Info
% % Y = fft(smatrix,[],2);
% % Ya=abs(Y);
% % Yp=Ya(:,1:size(Ya,2)/2);
% % f=linspace(0,1000*fs/2,size(Ya,2)/2);
% % Yp=Yp/max(max(Yp));
% % % 3D plot of smatrix
% % figure;                        % Fig. 5
% % surf(f,1:N,Yp)
% % shading flat
% % colormap(pink)
% % xlabel('frequency (Hz)');
% % ylabel('epoch number');
% % zlabel('normalized amplitude');
% % title(['3D Waveform=',wave,' @ ',num2str(fs),'ksps, ',num2str(nb),'-bit ADC (+/-',num2str(Amax),'u)']);
% % axis([0 max(f)/2.5 1 N 0 1.2*max(max(Yp))]);
% %
% % figure;                         % Fig. 6
% % % Amplitudes and shimmer (YZ plane = FFT amplitude vs. epoch number)
% % subplot(221)
% % surf(f,1:N,Yp)
% % shading flat
% % colormap(pink)
% % ylabel('epoch number');
% % axis([0 max(f)/2.5 1 N 0 1.2*max(max(Yp))]);
% % set(gca,'ZTickLabel',{[]})
% % view(90,0)
% % set(gca,'PlotBoxAspectRatio',[1 1 1]);
% % % Waveforms (XZ plane = amplitude vs. frequency)
% % subplot(222)
% % plot(f,Yp,'Color',[207/255 169/255 146/255]); hold on
% % plot(f,Yp(1,:),'r','LineWidth',1); hold off  % basic
% % xlabel('frequency (Hz)');
% % ylabel('normalized amplitude');
% % axis([0 max(f)/2.5 0 1.2*max(max(Yp))]);
% % % Widths, positions and jitter (XY plane = epoch number vs. frequency)
% % subplot(224)
% % pcolor(f,1:N,Yp);
% % shading flat
% % colormap(pink)
% % % hold on
% % % plot(onsets,1:N,'r','LineWidth',1);                  % onsetss
% % % plot(onsets+widths,1:N,'r','LineWidth',1); hold off  % onsets+widths
% % ylabel('epoch number');
% % set(gca,'XTickLabel',{[]})
% % axis([0 max(f)/2.5 1 N]);
% % colorbar;
% % % Info
% % subplot(223)
% % message1=['Waveform=',wave,' @ ',num2str(fs),'ksps'];
% % message2=['Shimmer variation: ',aml];
% % message3=['Trigger variation: ',pml];
% % message4=['Width variation: ',wml];
% % text(0.05,0.8,message1);
% % text(0.05,0.6,message2);
% % text(0.05,0.4,message3);
% % text(0.05,0.2,message4);
% % set(gca,'XTickLabel',{[]})
% % set(gca,'YTickLabel',{[]})
% % axis off
