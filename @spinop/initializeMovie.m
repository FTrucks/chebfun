function [p, plotOptions] = initializeMovie(S, dt, pref, v, gridPoints)
%INITIALIZEMOVIE   Initialize a movie when solving a PDE specified by a SPINOP.
%   INITIALIZEMOVIE

% Copyright 2016 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Set-up:
dom = S.domain;
xx = gridPoints;
N = size(xx, 1);
nVars = S.numVars;
vscale = max(abs(v));
dataToPlot = str2func(pref.dataToPlot);

% Grid of the computation:
xxplot = [xx; 2*xx(end) - xx(end-1)];

% Finer grid for interploation:
Nplot = 1024;
xxxplot = trigpts(Nplot, dom);
xxxplot = [xxxplot; 2*xxxplot(end) - xxxplot(end-1)];

% Loop over the variables:
p = cell(nVars, 1); clf
for k = 1:nVars
    
    % Extract each variable:
    idx = (k-1)*N + 1;
    vvplot = dataToPlot(real(v(idx:idx+N-1)));
    vvplot = [vvplot; vvplot(1)]; %#ok<*AGROW>
    
    % Get the YLIM for the y-axis:
    if ( isempty(pref.Ylim) == 1 )
        Ylim(2*(k-1) + 1) = min(vvplot) - .1*vscale;
        Ylim(2*(k-1) + 2) = max(vvplot) + .1*vscale;
    else
        Ylim = pref.Ylim;
    end
    
    % Interpolate each variable on a finer grid:
    vvvplot = interp1(xxplot, vvplot, xxxplot, 'spline');
    
    % Plot each variable:
    subplot(nVars, 1, k)
    p{k} = plot(xxxplot, vvvplot, 'linewidth', 3);
    axis([dom(1), dom(2), Ylim(2*(k-1) + 1), Ylim(2*(k-1) + 2)])
    if ( nVars == 1 )
        xlabel('x'), ylabel('u(t,x)'), grid on
    else
        xlabel('x'), ylabel(['u_',num2str(k),'(t,x)']), grid on
    end
    set(gca, 'FontSize', 16), box on
    
    % Title:
    if ( k == 1 )
        lin = ['L: ', func2str(S.linearPart)];
        nonlin = ['N: ', func2str(S.nonlinearPart)];
        data = sprintf('Nx = %i (DoFs = %i), dt = %1.1e, t = %.4f', N, ...
            nVars*N, dt, 0);
        titleString = {[]; lin; []; nonlin; []; data; []};
        title(p{k}.Parent, titleString, 'interpreter', 'none')
    end
    drawnow
    
end
disp('Type <space> when ready.'), shg, pause
plotOptions{1} = Ylim;
plotOptions{2} = dataToPlot;

end