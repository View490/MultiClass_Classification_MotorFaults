function outputs = concat_dataset_label_single(labels, ratio, labels_name, varargin)
    
    model_dataset = [];
    data=[]; target=[]; data_test=[]; target_test=[];
    
    if (numel(ratio)==1)        
        ratio = repmat(ratio,1,numel(varargin));   
    end

    for i =1:numel(varargin)
        size_data = size(varargin{i},3);

        tmp = reshape(varargin{i}(1:100,:),300,[]);
        data = cat(2,data, tmp(:,1:floor(size_data*ratio(i))));
%         tmp = reshape(varargin{i}(1:100,:),300,[]);        
        data_test = cat(2,data_test, tmp(:, floor(size_data*(ratio(i))) +1:end));
        
        target = cat(2, target, ...
            repmat(labels(i,:)',1,size(1:floor(size_data*ratio(i)),2 )));          
        target_test = cat(2, target_test, ...
            repmat(labels(i,:)',1,size(tmp(:, floor(size_data*(ratio(i))) +1:end),2 )));  
        
        model_dataset.class.label{i} = labels(i,:);

        size(varargin{i}),ratio(i)
        size(data_test)
        size(target_test)
    end

end