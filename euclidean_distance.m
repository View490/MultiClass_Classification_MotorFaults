function distance = euclidean_distance(A, B)
    % A and B are matrices with the same number of rows (features)
    % The function returns the Euclidean distance between each row of A and each row of B
    try
        A = reshape(A, 300,[]);
        B = reshape(B, 300,[]);
    catch
        fprintf('input shape not proper \n')
    end
    % number of rows in A and B
    m = size(A, 2);
    n = size(B, 2);
    
    % distance matrix with zeros
    distance = zeros(m, n);
    
    % loop through each row of A and B
    for i = 1:m
        for j = 1:n
        % subtract each row of A from B
        diff = A(:,i) - B(:,j);
        % compute the sum of squared differences
        distance(i,j) = sqrt(sum(diff .^ 2));
        end        
    end    
end