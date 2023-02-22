function output = cosine_distance(A, B)
    try
        A = reshape(A, 300, []);
        B = reshape(B, 300, []);
    catch
        fprintf('Not proper dimension')
    end
    m = size(A,2);
    n = size(B,2);
    output = zeros(m,n);
    for idx_m=1:m
        for idx_n=1:n           
            dot_product = dot(A(:,m), B(:,n), 1);
            magnitude_A = sqrt(sum(A(:,m).^2));
            magnitude_B = sqrt(sum(B(:,n).^2));
            output(m,n) = 1 - (dot_product / (magnitude_A * magnitude_B));
        end
    end
    output = mean(output,'all');
end
