function noisePower = noisePowerSNR(M, SNR)
%noisePowerSNR Summary of this function goes here
%   Function:
%   noisePower = noisePowerSNR(M, SNR)
%
%   Returns the variance of the noise power (noisePower)
%   for a given Mixing Matrix (M) and SNR (in dB) value.

[L,R] = size(M);

Q = M'*M;

%Raa = zeros(size(Q));

mu_a = 0.5/(R-1);
var_a = 1/(12*(R-1)^2);


% from a symmetric Dirichlet distribution D(1,1,...,1) 
% source http://en.wikipedia.org/wiki/Dirichlet_distribution
%mu_a = 1/(R);
%var_a = (R-1)/((R^2)*(R+1));


Rp = ones(R-1,R-1)*(mu_a.^2) + eye(size(R-1,R-1))*var_a;

rl = ones(1,R-1)*( mu_a*(1- (R-1)*mu_a ) - var_a );
rR = 1 - 2*(R-1)*mu_a + (R-1)*(R-2)*(mu_a^2) + (R-1)*(var_a + mu_a^2);

Raa = [Rp rl';rl rR];

Py = trace(Raa*Q);

noisePower = Py/(L* 10^(SNR/10) );


end

