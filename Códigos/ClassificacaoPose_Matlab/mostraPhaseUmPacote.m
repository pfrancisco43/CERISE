function mostraPhaseUmPacote(phase_antenna1, phase_antenna2, pk)
    figure;
    hold on
    Q=size(phase_antenna1,2);
    m=linspace(-floor(Q/2),floor(Q/2),Q);
    plot(m, phase_antenna1(pk,:),'--<');
    plot(m, phase_antenna2(pk,:),'--O');
    xlabel('Subcarrier Index');
    ylabel('Phase (radians)');
    title('Phase por subportadora');
    legend('Antena 1', 'Antena 2')
    grid on;
end