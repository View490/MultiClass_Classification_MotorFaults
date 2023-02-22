function classifier_evaluation(y,t)
    predictionClasses = vec2ind(y);    
    trueClasses = vec2ind(t);    
    confMat = confusionmat(trueClasses, predictionClasses)
    
    % Compute the precision, recall, and f1-score
    precision = diag(confMat)' ./ sum(confMat, 1)
    recall = (diag(confMat) ./ sum(confMat, 2))'
    f1 = 2 * precision .* recall ./ (precision + recall)
    
    % Compute the accuracy
    accuracy = sum(diag(confMat)) / sum(confMat(:))

end