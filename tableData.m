function [train_table_data, test_table_data, train_labels, test_labels] = tableData(data_filenames, f_max, labels, split_ratio)
    % Modify this syn_filenames for dataset files
    global sel_UBMA, global sel_UBMP, global sel_MAMP, global sel_UBMAMP
    global syn_UBMA, global syn_UBMP, global syn_MAMP, global syn_UBMAMP
    global sel_UBMA_less; global sel_UBMP_less;
    global sel_MAMP_less; global sel_UBMAMP_less;
    
    global sel_UB; global sel_MA; global sel_MP;

    % Start of X_train,Y_train, X_test, Y_test
    data_filenames, labels, f_max;
    % eval(data_filenames(i)) = m x n x s = [1-200Hx x 3axis x 50samples]
    
    train_features_V = [];
    train_features_H = [];
    train_features_A = [];
    train_labels = [];

    test_features_V = [];
    test_features_H = [];
    test_features_A = [];
    test_labels = [];

    train_idx = 1;
    test_idx = 1;
    train_onehot = [];
    test_onehot = [];

    for i=1:length(data_filenames)
        data_filenames(i);
        temp = eval(data_filenames(i));
        final_idx = uint16(split_ratio*size(temp,3));
        test_size = size(temp,3)-final_idx;
        train_size = final_idx;
        
        %train feature V,H,A >>> train_table_data
        %test feature V,H,A >>> test_table_data
        train_features_V = [train_features_V, reshape(temp(1:f_max,1,1:final_idx),f_max,final_idx)];
        train_features_H = [train_features_H, reshape(temp(1:f_max,2,1:final_idx),f_max,final_idx)];
        train_features_A = [train_features_A, reshape(temp(1:f_max,3,1:final_idx),f_max,final_idx)];
        test_features_V = [test_features_V, reshape(temp(1:f_max,1,final_idx+1:end),f_max,test_size)];
        test_features_H = [test_features_H, reshape(temp(1:f_max,2,final_idx+1:end),f_max,test_size)];
        test_features_A = [test_features_A, reshape(temp(1:f_max,3,final_idx+1:end),f_max,test_size)];

        %train labels
        %test labels
        train_labels = [train_labels,repmat(labels(i,:)',1,final_idx)];
        test_labels = [test_labels,repmat(labels(i,:)',1,test_size)];
        
        % train onehot >>> train_table_data
        % test onehot >>> test_table_data
        train_onehot(train_idx : train_idx + train_size - 1) = [repmat(i,train_size,1)];
        test_onehot(test_idx : test_idx+test_size-1) = [repmat(i,test_size,1)];
        train_idx = train_idx + train_size;
        test_idx = test_idx + test_size;
    end
    clear i; clear ans; clear temp;
    
    %%% prepare train table
    train_table_data=table;
    train_table_data(1:size(train_features_V,2),1) = {zeros(f_max,1)};
    train_table_data(1:size(train_features_H,2),2) = {zeros(f_max,1)};
    train_table_data(1:size(train_features_A,2),3) = {zeros(f_max,1)};
    %%% prepare test table
    test_table_data=table;
    test_table_data(1:size(test_features_V,2),1) = {zeros(f_max,1)};
    test_table_data(1:size(test_features_H,2),2) = {zeros(f_max,1)};
    test_table_data(1:size(test_features_A,2),3) = {zeros(f_max,1)};

    %%% train_table_data assign
    if size(train_features_V,2)>0
        for i=1:size(train_features_V,2) %%% error here
            train_table_data(i,1)={train_features_V(1:f_max,i)};
            train_table_data(i,2)={train_features_H(1:f_max,i)};
            train_table_data(i,3)={train_features_A(1:f_max,i)};
        end
        train_table_data(:,4)=array2table(train_onehot'); %%% might be fixed here, if error
    end

    %%% test_table_data assign
    if size(test_features_V,2)>0
        for i=1:size(test_features_V,2)
            test_table_data(i,1)={test_features_V(1:f_max,i)};
            test_table_data(i,2)={test_features_H(1:f_max,i)};
            test_table_data(i,3)={test_features_A(1:f_max,i)};
        end
        test_table_data(:,4)=array2table(test_onehot'); %%%
    end

    countlabels(train_onehot)
    countlabels(test_onehot)
end