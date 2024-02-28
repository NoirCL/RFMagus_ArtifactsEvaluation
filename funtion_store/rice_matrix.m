function [ H ] = rice_matrix(H_los, Kdb, M, N)
    % H_los represents the channel for the line-of-sight path.
    % Kdb represents the Rayleigh channel factor.
    % M represents the number of elements in one row of the metasurface.
    % N represents the number of elements in one column of the metasurface.
    
    global Tx;
    global Rx;
    global BB;
    global MTS_ele_num

    K = 10^(Kdb / 10);
    
    H_nlos = (randn(M, N) + 1i * randn(M, N)) / sqrt(2);

    H = sqrt(K / (K + 1)) * H_los + sqrt(1 / (1 + K)) * abs(H_los) .* H_nlos;
end  
