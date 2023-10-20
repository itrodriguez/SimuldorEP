function [xm,os] = windowingmatrix(is,refm,rsa,lsa,window)
%  Windowing of vector os (original signal) around the reference marks, 
%  refm +rsa/-lsa                                        
%
% Format:
%    [xm,os] = windowingmatrix(is,refm,rsa,lsa,window)
%
% Arguments:
%     is = input signal (before windowing)
%   refm = position of reference marks in os (fid. marks for window.)
%    rsa = number of samples to the right of fid. marks
%    lsa = number of samples to the left of fid. marks
% window = window type vector (see window help) of length rsa+lsa
%
% Returns:
%     xm = matrix output
%     os = output vector obtained by windowing

% ATC

if nargin<5,
   window=boxcar(rsa+lsa+1);
end

[r,c]=size(is);
if r>c, is=is'; end
refm=refm(refm~=0);							% remove terms=0 from refm
k=length(refm);								% number of segments (beats)
os=zeros(1,k*(rsa+lsa+1));
xm=zeros(k,rsa+lsa+1);
for n=1:k,										% for each segment
   os(1,(n-1)*(rsa+lsa+1)+1:n*(rsa+lsa+1))=is(refm(n)-lsa:refm(n)+rsa).*window';
   xm(n,:)=is(refm(n)-lsa:refm(n)+rsa).*window';   
end
xm=detrend(xm','constant')';                % removes DC level from every heartbeat-row