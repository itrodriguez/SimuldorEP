%reader.m
%I'm guessing oliver had 3 records which we can see in the file output
%RB had 6 records

%native format and the various little-endian formats "look right" on screen.
%int16, int32, int64 all seem to show waveforms of the approximately correct shape.

function a = readerEd(filename,machineformat,precision)

if nargin < 3
%clear a
%filename='oliver.ep';
%filename='rb.ep';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AAHD\0D95B422.ABR';%'30B3F7AD.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AAHD\0D95024D.ABR';%'30B3F7AD.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AAHD\0D964E94.ABR';%'30B3F7AD.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AAHD\0766C1D2.ABR';%'30B3F7AD.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AC\EB212202.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AC\EB224A01.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AC\EB228F83.ABR';
%filename= 'C:\Users\Velarde\Desktop\Documentos EPU Integrado\ABR\BD_15-10-2013_Gold_standard\AC\EB21C9FD.ABR';

machineformat='native';       %or 'n' - local machine format - the default OK with int32
%machineformat='ieee-le'     %or 'l' - IEEE floating point with little-endian byte ordering. OK with int32
%machineformat='ieee-be'     %or 'b' - IEEE floating point with big-endian byte ordering. funny with int32
%machineformat='vaxd'        %or 'd' - VAX D floating point and VAX ordering. ok with int32
%machineformat='vaxg'        %or 'g' - VAX G floating point and VAX ordering. ok with int32
%machineformat='cray'        %or 'c' - Cray floating point with big-endian byte ordering. funny with int32
%machineformat='ieee-le.l64' %or 'a' - IEEE floating point with little-endian  byte ordering and 64 bit long data type. ok with int32
%machineformat='ieee-be.l64' %or 's' - IEEE floating point with big-endian byte ordering and 64 bit long data type.. funny with int32

%FOLLOWING FOR STANDARD MACHINE FORMAT 'n'
precision='int16';   %'integer*2'      integer, 16 bits. *[ ] LOOKS PRETTY REASONABLE.
%precision='int32';   %'integer*4'      integer, 32 bits. *[ ] LOOKS PRETTY REASONABLE.  Perhaps best?
%precision='int64'   %'integer*8'      integer, 64 bits. *[ ] LOOKS PRETTY REASONABLE.

%precision='uchar'   %'unsigned char'  unsigned character,  8 bits. uchar = shows that there are 6 clumps of data
%precision='schar'   %'signed char'    signed character,  8 bits.schar = shows that there are 6 clumps of data
%precision='int8'    %'integer*1'      integer, 8 bits.. shows that there are 6 clumps of data
%precision='uint8'   %'integer*1'      unsigned integer, 8 bits.
%precision='uint16'  %'integer*2'      unsigned integer, 16 bits. looks funny
%precision='uint64'  %'integer*8'      unsigned integer, 64 bits. looks funny
%precision='single'  %'real*4'         floating point, 32 bits. weird
%precision='float32' %'real*4'         floating point, 32 bits. weird.
%precision='double'  %'real*8'         floating point, 64 bits. weird.
%precision='float64' %'real*8'         floating point, 64 bits. looks funny
%precision='uint32'  %'integer*4'      unsigned integer, 32 bits.

end

fid=fopen(filename,'r',machineformat);
%try different machine formats.

size=inf;
[a,~]=fread(fid,size,precision);
%plot(a/1000000)

fclose(fid);