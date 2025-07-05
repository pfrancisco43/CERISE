function mostrarGrid(ssbGrid)
    figure;
    imagesc(abs(ssbGrid));
    xlabel('Símbolos OFDM'); ylabel('Subportadoras');
    title('Magnitude da SSB Grid (PBCH + PSS + SSS)');
    colorbar;
end