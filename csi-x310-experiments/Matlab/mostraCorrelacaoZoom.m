function mostraCorrelacaoZoom(corrs)
    figure;
    samples_per_ms = round(15.36e3);  % 1ms de amostras
    %meio = floor(size(corrs, 2)/2);
    %janela = corrs(:, meio:meio+samples_per_ms);
    janela = corrs(:, 2.5e7:2.6e7);  % apenas 1ms do meio da captura
  
    plot(janela(1,:), 'r'); hold on;
    plot(janela(2,:), 'g');
    plot(janela(3,:), 'b');
    legend('NID2=0','NID2=1','NID2=2');
    xlabel('Amostras'); ylabel('Correlação');
    title('Zoom na correlação (janela de 1ms)');
end