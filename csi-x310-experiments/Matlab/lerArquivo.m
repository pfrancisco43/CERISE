function sinal_complexo = lerArquivo(filename)
    fid = fopen(filename, 'rb');
    if fid == -1
        error('Arquivo não encontrado: %s', filename);
    end
    raw = fread(fid, 'float');
    fclose(fid);
    sinal_complexo = raw(1:2:end) + 1j * raw(2:2:end);
end