%% SUBFUNCTIONS - NOT PART OF MAIN SCRIPT

% Function to make filter
function fil = MakeFil(x, y, sig)
    %exp(-x^2)*x^6
    if length(sig) == 1
        fil1 = exp(-x.*x/2/sig/sig - y.*y/2/sig/sig)/2/pi/sig/sig; 
        fil2 = -(y.*y - sig*sig)/sig^4;
        %EDIT FIL3
%         fil3 = exp(-x.^2/2/sig/sig)/sqrt(2*pi)/sig.*(x/sig).^2;
    elseif length(sig) == 2
        fil1 = exp(-x.*x/2/sig(1)/sig(1) - y.*y/2/sig(2)/sig(2))/2/pi/sig(1)/sig(2);
        fil2 = -(y.*y - sig(2)*sig(2))/sig(2)^4;
        %EDIT FIL3
%         fil3 = exp(-x.^2/2/sig(1)/sig(1))/sqrt(2*pi)/sig(1).*(x/sig(1)).^2;
    end
%     fil = fil1.*fil2.*fil3;
    fil = fil1.*fil2;
end