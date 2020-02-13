function mf = memoize(f)
    % Returns the memoized version of function f.
    % f must have exactly one numerical argument.
    % The memoized version cannot be called without an argument.
    % Memoizing functions of continous ranges 
	% may not be as useful as imagined...
    
    h = []; % our pseudo hashtable by abuse of the property list.
            % MatLab creates this fresh for every call of memoize
            % and retains it for the lifetime of the memoized function

    function r = ff(x)
	
	        % matlab allows only "MatLab words" as keys
            xstr= ['m', num2str(x)];
            if isfield(h, xstr)
                   r=h.(xstr);
            else
                   h.(xstr) = f(x);
                   r = h.(xstr);
            end
    end

    mf = @ff;
end

