function mostraCSI(csi)
    figure;
    subplot(2,1,1);
    plot(abs(csi));
    title('Magnitude do CSI estimado');
    xlabel('Subportadora'); ylabel('|H(f)|');

    subplot(2,1,2);
    plot(angle(csi));
    title('Fase do CSI estimado');
    xlabel('Subportadora'); ylabel('Fase (rad)');
end