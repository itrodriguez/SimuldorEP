function [psi,xval] = mywavefun(wname,iter);
%MYWAVEFUN Wavelet function 1-D (modified from WAVEFUN by ATC, May 2006)
%   MYWAVEFUN returns approximations of the wavelet function 'wname'
%
%   [PSI,XVAL] = MYWAVEFUN('wname',ITER)
%   returns the wavelet function on the 2^ITER points grid XVAL
%   The positive integer ITER is the number of iterations
%
%   WAVEFUN('wname')   is equivalent to WAVEFUN('wname',8).
%      
%   See also WAVEFUN, INTWAVE, WAVEINFO, WFILTERS.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 04-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
%   $Revision: 1.18.4.2 $
%   Modified by A. Taboada, May 2006

% Check arguments.
wname = deblankl(wname);
debut = wname(1:2);

[wtype,fname,family,bounds] =  ...
    wavemngr('fields',wname,'type','file','fn','bounds');

if  nargin == 1,
    iter = 8; 
elseif  nargin == 2
    if iter == 0, 
        iter = 8
    end
end

coef = (sqrt(2)^iter);
pas  = 1/(2^iter);

switch wtype
    case 1
      [Lo_R,Hi_R] = wfilters(wname,'r');
      long  = length(Lo_R);
      nbpts = (long-1)/pas+1;
      psi   = coef*upcoef('d',1,Lo_R,Hi_R,iter);

      [nbpts,nb,dn] = getNBpts(nbpts,iter,long);
      psi = [0 wkeep1(psi,nb) zeros(1,1+dn)];

      % sign depends on wavelet
      if strcmp(debut,'co') | strcmp(debut,'sy') | ... % coiflet or symlet
         strcmp(debut,'dm')                            % dmeyer
         psi = -psi ;
      end
      xval = linspace(0,(nbpts-1)*pas,nbpts);

    case 3
      np = 2^iter;
      lb = bounds(1); ub = bounds(2);
      [out1,psi,xval] = feval(fname,lb,ub,np,wname);

    case 4
      np = 2^iter;
      lb = bounds(1); ub = bounds(2);
      [psi,xval] = feval(fname,lb,ub,np,wname);
end

%----------------------%
% Internal Function(s) %
%----------------------%
function [nbpts,nb,dn] = getNBpts(nbpts,iter,long)
%
lplus = long-2;
nb = 1; for kk = 1:iter, nb = 2*nb+lplus; end
dn = nbpts-nb-2;
if dn<0 , nbpts = nbpts-dn; dn = 0; end    % HAAR 
