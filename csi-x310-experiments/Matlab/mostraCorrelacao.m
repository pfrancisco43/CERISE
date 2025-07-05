function mostraCorrelacao(corrs)
    figure;
    plot(corrs(1,:), 'r'); hold on;
    plot(corrs(2,:), 'g');
    plot(corrs(3,:), 'b');
    legend('NID2=0','NID2=1','NID2=2');
    xlabel('Amostras'); ylabel('Magnitude da correlação');
    title('Correlação com sequências PSS');
end