function output = dataset_generator(ratio, varargin)            
    
    output.training = [];
    output.testing = [];
    output.training_labels = [];
    output.testing_labels = [];
    
    output.training_labels_major = [];
    output.testing_labels_major = [];
    

    for i = 1:size(varargin,2)
        
        data = reshape(varargin{i},300,[]);
        
        try ratio(i); catch ratio(i)=.5; end %#ok<*SEPEX> 
        idx = randperm(size(varargin{i},3));
        idx_training = idx(1:round(ratio(i)*size(varargin{i},3)));
        idx_testing = idx(round(ratio(i)*size(varargin{i},3))+1:end);

        output.training = cat(2, output.training, data(:, idx_training));
        output.testing = cat(2, output.testing, data(:, idx_testing));
        
        response_i = zeros(size(varargin,2),size(data,2));
        response_i(i,:) = 1;
        output.training_labels = cat(2, output.training_labels, response_i(:,idx_training));
        output.testing_labels = cat(2, output.testing_labels, response_i(:,idx_testing));
        

        response_major = zeros(3,size(data,2));
        i
        if i <= 4
            response_major(1,:) = 1;
        elseif i <= 8
            response_major(2,:) = 1;
        else
            response_major(3,:) = 1;
        end
        output.training_labels_major = cat(2, output.training_labels_major, response_major(:,idx_training));
        output.testing_labels_major = cat(2, output.testing_labels_major, response_major(:,idx_testing));
        
    end
    
end