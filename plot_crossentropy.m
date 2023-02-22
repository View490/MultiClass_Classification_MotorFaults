function plot_crossentropy(tr)    
    semilogy(0:tr.best_epoch, tr.perf, 'LineWidth',2);
    xlabel('Epoch Number');
    ylabel('Cross-Entropy');
    title("Performance of training dataset. Best Cross-Entropy (epoch "+num2str(tr.best_epoch)+") = "+num2str(tr.perf(end)));    
    hold on;
    plot(tr.best_epoch, tr.perf(end), 'bo','MarkerSize',16);
    yline(tr.perf(end),'-.')
    hold off;
end