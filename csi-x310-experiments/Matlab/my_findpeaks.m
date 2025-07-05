function [valores, posicoes, indices_maximos_filtrados] = my_findpeaks(valores_maximos, indices_maximos, qtd_picos, min_dist_samples)
% MY_FINDPEAKS - Encontra os maiores picos respeitando espaçamento mínimo.
%
% [valores, posicoes, indices_maximos_filtrados] = my_findpeaks(valores_maximos, indices_maximos, qtd_picos, min_dist_samples)
%
% - valores_maximos: vetor com os valores de correlação máxima (ex: max entre PSSs)
% - indices_maximos: vetor com os nid2 mais correlacionados por amostra
% - qtd_picos: número máximo de picos a retornar
% - min_dist_samples: distância mínima entre picos (em amostras)

    [~, ordenados] = sort(valores_maximos, 'descend');

    posicoes = [];
    valores = [];
    indices_maximos_filtrados = [];

    for i = 1:length(ordenados)
        p = ordenados(i);

        if isempty(posicoes) || all(abs(p - posicoes) > min_dist_samples)
            posicoes(end+1) = p;
            valores(end+1) = valores_maximos(p);
            indices_maximos_filtrados(end+1) = indices_maximos(p)-1;
        end

        if length(posicoes) >= qtd_picos
            break;
        end
    end
end
