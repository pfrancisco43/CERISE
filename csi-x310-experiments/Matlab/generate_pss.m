function pss_seq = generate_pss(nid2)
    N_ZC = 127;
    u_vals = [25, 29, 34];
    u = u_vals(nid2+1);
    n = 0:N_ZC-1;
    pss_seq = exp(-1j * pi * u * n .* (n+1) / N_ZC);
end