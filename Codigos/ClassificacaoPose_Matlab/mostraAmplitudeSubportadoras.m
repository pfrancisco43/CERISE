function mostraAmplitudeSubportadoras(mg1)
    figure;
    hold on
    qs=size(mg1,1);
    for i=1:qs
        plot(mg1(i,:))
    end    
    xlabel('Subcarrier');
    ylabel('Amplitude');
    title('CSI');
end