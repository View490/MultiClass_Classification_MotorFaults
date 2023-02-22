function  L1_distance = Manhattan(A,B)
    try
        A = reshape(A,300,[]);
        B = reshape(B,300,[]);
    catch
        fprintf('not proper input shape')
    end

    m = size(A, 2);
    n = size(B, 2);
    
    % distance matrix with zeros
    L1_distance = zeros(m, n);
    
    % loop through each row of A and B
    for i = 1:m
        for j = 1:n
            L1_distance(i,j) = sum(abs(A(:,i)-B(:,j)));
        end
    end
end