function output = dataset_generator_add(dataset, label_start, varargin)
    output = dataset;
    
    for i = 1:size(varargin,2)
        data = reshape(varargin{i}, 300, []);
        data = data(:,:);
        output.training = cat(2, output.training, data);
        
        response_i = zeros(size(dataset.training_labels,1),size(data,2));
        response_i(label_start+i-1,:) = 1;
        output.training_labels = cat(2, output.training_labels, response_i);
        
        response_major = zeros(3,size(data,2));
        response_major(3,:) = 1;
        output.training_labels_major = cat(2, output.training_labels_major, response_major);        

    end
end