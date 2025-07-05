function corrs = correlacaoPSS(sinal_complexo)
    corrs = zeros(3, length(sinal_complexo));
    for nid2 = 0:2
        pss = generate_pss(nid2);
        corrs(nid2+1, :) = abs(conv(sinal_complexo, fliplr(conj(pss)), 'same'));
    end
end