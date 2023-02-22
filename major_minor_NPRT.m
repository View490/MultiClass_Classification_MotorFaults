function output = major_minor_NPRT(inputs,varargin)
    mkdir result_MajorMinor/
    cd result_MajorMinor/
    [net.major, tr.major, predicted] = train_NPRT_single( ...
        inputs.training, inputs.training_labels_major, ...
        inputs.testing, inputs.testing_labels_major,'MAJOR');
    saveas(figure(1),'performance_Major.png')
    saveas(figure(2),'confusion_training_Major.png')
    saveas(figure(3),'confusion_testing_Major.png')
    close all

    % train the NPRT with multi severity of UB - minor network UB
    idx_training = inputs.training_labels_major(1,:)==1;
    idx_predicted = predicted(1,:)>=.5;

    data.UB.training = inputs.training(:,idx_training);
    data.UB.training_labels = inputs.training_labels(:,idx_training);
    data.UB.testing = inputs.testing(:,idx_predicted);
    data.UB.testing_labels = inputs.testing_labels(:,idx_predicted);

    idx_remove = [];
    for i = 1: size(data.UB.training_labels,1)
        if sum(data.UB.training_labels(i,:))==0
            idx_remove = [idx_remove, i]; %#ok<AGROW> 
        end
    end
    data.UB.training_labels(idx_remove,:)=[];
    data.UB.testing_labels(idx_remove,:)=[];
    
    % remove out of bound labels from the testing dataset <<< sum(1,labels
    % = 0) <<< these samples are major failure prediction.
    % let the testing label that is major failed predicted be 1 at the last
    % row class.
    n_class = size(data.UB.training_labels,1);
    data.UB.training_labels(n_class+1,:) = 0;
    data.UB.testing_labels(n_class+1,:) = 0;    
    data.UB.testing_labels(end,sum(data.UB.testing_labels,1)==0) = 1;    

    [net_UB, tr_UB, predicted_UB ] = train_NPRT_single( ...
        data.UB.training, data.UB.training_labels, ...
        data.UB.testing, data.UB.testing_labels,"UB");
    saveas(figure(1),'performance_UB.png')
    saveas(figure(2),'confusion_training_UB.png')
    saveas(figure(3),'confusion_testing_UB.png')
    close all
    
    % train the NPRT with multi severity of MP - minor network MP
    idx_training = inputs.training_labels_major(2,:)==1;
    idx_predicted = predicted(2,:)>=.5;

    data.MP.training = inputs.training(:,idx_training);
    data.MP.training_labels = inputs.training_labels(:,idx_training);
    data.MP.testing = inputs.testing(:,idx_predicted);
    data.MP.testing_labels = inputs.testing_labels(:,idx_predicted);

    idx_remove = [];
    for i = 1: size(data.MP.training_labels,1)
        if sum(data.MP.training_labels(i,:))==0
            idx_remove = [idx_remove, i]; %#ok<AGROW> 
        end
    end
    data.MP.training_labels(idx_remove,:)=[];
    data.MP.testing_labels(idx_remove,:)=[];
    
    n_class = size(data.MP.training_labels,1);
    data.MP.training_labels(n_class+1,:) = 0;
    data.MP.testing_labels(n_class+1,:) = 0;    
    data.MP.testing_labels(end,sum(data.MP.testing_labels,1)==0) = 1;

    [net_MP, tr_MP, predicted_MP ] = train_NPRT_single( ...
        data.MP.training, data.MP.training_labels, ...
        data.MP.testing, data.MP.testing_labels,"MP");
    saveas(figure(1),'performance_MP.png')
    saveas(figure(2),'confusion_training_MP.png')
    saveas(figure(3),'confusion_testing_MP.png')
    close all

    % train the NPRT with multi severity of UBMP - minor network UBMP
    idx_training = inputs.training_labels_major(3,:)==1;
    idx_predicted = predicted(3,:)>=.5;

    data.UBMP.training = inputs.training(:,idx_training);
    data.UBMP.training_labels = inputs.training_labels(:,idx_training);
    data.UBMP.testing = inputs.testing(:,idx_predicted);
    data.UBMP.testing_labels = inputs.testing_labels(:,idx_predicted);

    idx_remove = [];
    for i = 1: size(data.UBMP.training_labels,1)
        if sum(data.UBMP.training_labels(i,:))==0
            idx_remove = [idx_remove, i]; %#ok<AGROW> 
        end
    end
    data.UBMP.training_labels(idx_remove,:)=[];
    data.UBMP.testing_labels(idx_remove,:)=[];
    
    n_class = size(data.UBMP.training_labels,1);
    data.UBMP.training_labels(n_class+1,:) = 0;
    data.UBMP.testing_labels(n_class+1,:) = 0;    
    data.UBMP.testing_labels(end,sum(data.UBMP.testing_labels,1)==0) = 1;

    [net_UBMP, tr_UBMP, predicted_UBMP ] = train_NPRT_single( ...
        data.UBMP.training, data.UBMP.training_labels, ...
        data.UBMP.testing, data.UBMP.testing_labels,"UBMP");
    saveas(figure(1),'performance_UBMP.png')
    saveas(figure(2),'confusion_training_UBMP.png')
    saveas(figure(3),'confusion_testing_UBMP.png')
    close all

    % take the predicted label of Major classifier to be input of these 3
    % minor network

    % visualizae results

    % output

    output.data = data;    
    output.net.net_UB = net_UB;
    output.net.net_MP = net_MP;
    output.net.net_UBMP = net_UBMP;
    output.tr.tr_UB = tr_UB;
    output.tr.tr_MP = tr_MP;
    output.tr.tr_UBMP = tr_UBMP;
    output.predicted.predicted_UB = predicted_UB ;
    output.predicted.predicted_MP = predicted_MP ;
    output.predicted.predicted_UBMP = predicted_UBMP ;
    
    correct_predicted.UB = sum(sum(output.predicted.predicted_UB == output.data.UB.testing_labels,1))
    correct_predicted.MP = sum(sum(output.predicted.predicted_MP == output.data.MP.testing_labels,1))
    correct_predicted.UBMP = sum(sum(output.predicted.predicted_UBMP == output.data.UBMP.testing_labels,1))
    accuracy_overall = (correct_predicted.UB+correct_predicted.MP+correct_predicted.UBMP)/length(inputs.testing)
    accuracy_imbalance = ...
    (...
    (correct_predicted.UB/sum(inputs.testing_labels_major(1,:)==1)) + ...
    (correct_predicted.MP/sum(inputs.testing_labels_major(2,:)==1)) + ...
    (correct_predicted.UBMP/sum(inputs.testing_labels_major(3,:)==1)) ...
    ) / 3
    output.accuracy_overall = accuracy_overall;
    output.accuracy_imbalance = accuracy_imbalance;

    save('output_majorminor','-struct','output')
    cd ..
end