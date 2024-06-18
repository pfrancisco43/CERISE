function mostraAmplitudeTempo(mg1)
    figure;
    hold on
    qs=size(mg1,2);
    for i=1:qs
        plot(mg1(:,i))
    end    
    xlabel('Number of Packets');
    ylabel('Amplitude');
    title('CSI');
end