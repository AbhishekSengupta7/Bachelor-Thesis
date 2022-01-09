function fine_CFO_est = fine_CFO_estimate(tx,coarse_CFO_est,Nfft,STO)
% Input : tx = Received signal
%         coarse_CFO_est = coarse CFO estimate
%         Nfft = FFT size
%         STO  = Symbol Time Offset 
% Output: fine_CFO_est = Estimated carrier frequency offset 
if nargin<4, STO = 0; end
if nargin<3, Nfft = 64; end
if nargin<2, coarse_CFO_est = 0; end
tx1 = CFO_compensation(tx,coarse_CFO_est,Nfft,STO);
nn = STO + Nfft/2 + [1:Nfft];
cfo_est = angle(tx1(nn+Nfft)*tx1(nn)')/(2*pi); % Eq.(11.3.2b)
fine_CFO_est = CFO_est - mod(CFO_est,1/128); % Stored with 8 bits