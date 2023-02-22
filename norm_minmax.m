function output = norm_minmax(signal)
    try
        signal = reshape(signal, 300, []);        
    catch
        fprintf('Not proper dimension')
    end

    minSignal = min(signal,[],1);
    maxSignal = max(signal,[],1);    
    output = (signal - minSignal) ./ (maxSignal - minSignal);
    output = reshape(output, 100, 3, []);
end