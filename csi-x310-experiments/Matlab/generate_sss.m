function sss = generate_sss(NID1, NID2)
    % Baseado no 3GPP 38.211 - Seção 7.4.3.1
    M = 127;
    n = 0:M-1;

    % Parâmetros de pseudoaleatoriedade
    x0 = zeros(1, 127); x0(1:7) = [1 0 0 0 0 0 0];
    x1 = zeros(1, 127); x1(1:7) = [1 0 0 0 0 0 0];

    for i = 8:M
        x0(i) = mod(x0(i-7) + x0(i-4), 2);
        x1(i) = mod(x1(i-7) + x1(i-5) + x1(i-3) + x1(i-2), 2);
    end

    m0 = mod(NID1, 112);
    m1 = floor(NID1 / 112);

    s_tilda0 = x0(mod(n + m0, M) + 1);
    s_tilda1 = x1(mod(n + m1, M) + 1);

    d = 1 - 2 * mod(s_tilda0 + s_tilda1 + NID2, 2);
    sss = d;
end