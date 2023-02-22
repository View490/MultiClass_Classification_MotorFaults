function compare_plotting(syn_data, actual_data, titles)
    total_sample = 10;    

    figure; tiledlayout(3,2);
    set(gcf, 'units','normalized','outerposition',[0 0 1 1])
% % % % %     
    nexttile; hold on; grid on;
    for i=1:total_sample
            plot(syn_data.data_norm(:,1,i))
    end
    title(strcat(titles," Syn-X"));
    
    nexttile; hold on; grid on;
    for i=1:total_sample
            plot(actual_data.norm_minmax(:,1,i))
    end
    title(strcat(titles," Actual-X"));
% % % % % 
    nexttile; hold on; grid on;
    for i=1:total_sample
            plot(syn_data.data_norm(:,2,i))
    end
    title(strcat(titles," Syn-Y"));
    
    nexttile; hold on; grid on;
    for i=1:total_sample
            plot(actual_data.norm_minmax(:,2,i))
    end
    title(strcat(titles," Actual-Y"));
% % % % %     
nexttile; hold on; grid on;
    for i=1:total_sample
            plot(syn_data.data_norm(:,3,i))
    end
    title(strcat(titles," Syn-Z"));
    
    nexttile; hold on; grid on;
    for i=1:total_sample
            plot(actual_data.norm_minmax(:,3,i))
    end
    title(strcat(titles," Actual-Z"));
    
end