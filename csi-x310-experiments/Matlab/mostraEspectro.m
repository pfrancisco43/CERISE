function mostraEspectro(sinal, nfft, fs)
    figure;
    [s, f] = periodogram(sinal, [], nfft, fs, 'centered', 'power');
    plot(f/1e6, 10*log10(s));
    xlabel('Frequência (MHz)');
    ylabel('Potência (dB)');
    title('Espectro da captura');
    grid on;
end