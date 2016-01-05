function ishappy = checkHappiness(S, c, pref)
%CHECKHAPPINESS   Check if the solution is resolved in space for SPINOP.
%   CHECKHAPPINESS 

% Copyright 2016 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Set-up:
nVars = S.numVars;
N = size(c{1}, 1)/nVars;
errTol = pref.errTol;

% Loop over the variables:
ishappy = zeros(nVars, 1);
for k = 1:nVars
    
    idx = (k-1)*N + 1;
    
    % IFFTSHIFT to use CHEBFUN indexing of wavenumbers:
    cCheb = ifftshift(c{1}(idx:idx+N-1));
    if ( mod(N,2) == 0 )
        cCheb = [cCheb(N); cCheb(N-1:-1:N/2+1) + cCheb(1:N/2-1); cCheb(N/2)];
    else
        cCheb = [cCheb(N:-1:(N+1)/2+1) + cCheb(1:(N+1)/2-1); cCheb((N+1)/2)];
    end
    
    % Trick used in TRIGTECH/STANDARCHECK to get decaying coefficients:
    cCheb = flipud(cCheb);
    cCheb = [cCheb(1,1); kron(cCheb(2:end,1), [1; 1])];
    
    % Use CHEBFUN STANDARDCHOP command:
    cutoff = standardChop(cCheb, errTol);
    ishappy(k) = ( cutoff < N );
    
end
ishappy = all(ishappy == 1);

end