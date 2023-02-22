

function [net, tr, y_testing] = train_NPRT_single(x,t,testData,testTargets,varargin)
    trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
    
    % Create a Pattern Recognition Network
    hiddenLayerSize = 10;
    net = patternnet(hiddenLayerSize, trainFcn);
    
    % Choose Input and Output Pre/Post-Processing Functions
    % For a list of all processing functions type: help nnprocess
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    
    % Train&Test Splitter
    
    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivision
    net.divideFcn = 'dividerand';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainRatio = 100/100;
    net.divideParam.valRatio = 0/100;
    net.divideParam.testRatio = 0/100;
    
    % % Perform setting 
    % Choose a Performance Function
    net.performFcn = 'crossentropy';  % Cross Entropy
    
    % Choose Plot Functions
    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
        'plotconfusion', 'plotroc'};
    
    % % Training
    % Train the Network
    [net,tr] = train(net,x,t);
    % Test the Network
    y = net(x);
    e = gsubtract(t,y);
    performance = perform(net,t,y);
    tind = vec2ind(t);
    yind = vec2ind(y);
    percentErrors = sum(tind ~= yind)/numel(tind);
    % Evaluate with training dataset
    figure;
    plot_crossentropy(tr); set(gcf, 'units','normalized','outerposition',[0 .5 .5 .5])
    figure;
    plotconfusion(t, y); set(gcf, 'units','normalized','outerposition',[0 0 .5 .5])      
    try 
        title("Confusion Matrix - training dataset: "+varargin{1})
    catch
        title('Confusion Matrix - training dataset'); 
    end     
    
    % Evaluate with testing dataset
    y_testing = net(testData);
    performance = perform(net,testTargets, net(testData));
    % Plot the confusion matrix
    figure
    plotconfusion(testTargets, y_testing); set(gcf, 'units','normalized','outerposition',[0.5 0 0.5 1])    
    try 
        title("Confusion Matrix - testing dataset: "+varargin{1})
    catch
        title('Confusion Matrix - testing dataset'); 
    end

    classifier_evaluation(y_testing,testTargets)
    
end