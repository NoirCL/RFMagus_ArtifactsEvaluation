function [phi1, phi2, phi3, phi4, phi1_d, phi2_d, phi3_d, phi4_d] = AO_4_ris_discrete
    global g1 g2 g3 g4
    global u1 u2 u3 u4
    global h12 h13 h14 h23 h24 h34 Los flag_ris_num
    global MTS_ele_num
    
    % Definition of metasurface code phase configuration variables.
    phi1 = exp(1i * rand(1, MTS_ele_num^2));
    phi2 = exp(1i * rand(1, MTS_ele_num^2));
    phi3 = exp(1i * rand(1, MTS_ele_num^2));
    phi4 = exp(1i * rand(1, MTS_ele_num^2));
    
    % Number of iterations for Gaussian randomization.
    len = 100;
    % Total number of metasurface elements.
    m = MTS_ele_num^2;
    % The intensity of the signal received at Rx, denoted by H.
    dB_H = [];

    %% Maximum number of iterations.
    for i = 1 : 100
        i
        %% Ris1
        if flag_ris_num >= 1
            A = diag(g1) * h12 * diag(phi2) * h23 * diag(phi3) * h34 * diag(phi4) * u4;
            B = diag(g1) * h12 * diag(phi2) * h23 * diag(phi3) * u3;
            C = diag(g1) * h12 * diag(phi2) * h24 * diag(phi4) * u4;
            D = diag(g1) * h12 * diag(phi2) * u2;
            E = diag(g1) * h13 * diag(phi3) * h34 * diag(phi4) * u4;
            F = diag(g1) * h13 * diag(phi3) * u3;
            G = diag(g1) * h14 * diag(phi4) * u4;
            H = diag(g1) * u1;
        
            I = g2 * diag(phi2) * h23 * diag(phi3) * u3;
            J = g2 * diag(phi2) * h23 * diag(phi3) * h34 * diag(phi4) * u4;
            K = g2 * diag(phi2) * h24 * diag(phi4) * u4;
            L = g2 * diag(phi2) * u2;
            M = g3 * diag(phi3) * h34 * diag(phi4) * u4;
            N = g3 * diag(phi3) * u3;
            O = g4 * diag(phi4) * u4;
            P = Los;
        
            Matrix1 = A * A' + A * B' + A * C' + A * D' + A * E' + A * F' + A * G' + A * H' + ...
                      B * A' + B * B' + B * C' + B * D' + B * E' + B * F' + B * G' + B * H' + ...
                      C * A' + C * B' + C * C' + C * D' + C * E' + C * F' + C * G' + C * H' + ...
                      D * A' + D * B' + D * C' + D * D' + D * E' + D * F' + D * G' + D * H' + ...
                      E * A' + E * B' + E * C' + E * D' + E * E' + E * F' + E * G' + E * H' + ...
                      F * A' + F * B' + F * C' + F * D' + F * E' + F * F' + F * G' + F * H' + ...
                      G * A' + G * B' + G * C' + G * D' + G * E' + G * F' + G * G' + G * H' + ...
                      H * A' + H * B' + H * C' + H * D' + H * E' + H * F' + H * G' + H * H'     ;
        
            Matrix2 = A * I' + A * J' + A * K' + A * L' + A * M' + A * N' + A * O' + A * P' + ...
                      B * I' + B * J' + B * K' + B * L' + B * M' + B * N' + B * O' + B * P' + ...
                      C * I' + C * J' + C * K' + C * L' + C * M' + C * N' + C * O' + C * P' + ...
                      D * I' + D * J' + D * K' + D * L' + D * M' + D * N' + D * O' + D * P' + ...
                      E * I' + E * J' + E * K' + E * L' + E * M' + E * N' + E * O' + E * P' + ...
                      F * I' + F * J' + F * K' + F * L' + F * M' + F * N' + F * O' + F * P' + ...
                      G * I' + G * J' + G * K' + G * L' + G * M' + G * N' + G * O' + G * P' + ...
                      H * I' + H * J' + H * K' + H * L' + H * M' + H * N' + H * O' + H * P'     ;
        
            Matrix3 = I * A' + I * B' + I * C' + I * D' + I * E' + I * F' + I * G' + I * H' + ...
                      J * A' + J * B' + J * C' + J * D' + J * E' + J * F' + J * G' + J * H' + ...
                      K * A' + K * B' + K * C' + K * D' + K * E' + K * F' + K * G' + K * H' + ...
                      L * A' + L * B' + L * C' + L * D' + L * E' + L * F' + L * G' + L * H' + ...
                      M * A' + M * B' + M * C' + M * D' + M * E' + M * F' + M * G' + M * H' + ...
                      N * A' + N * B' + N * C' + N * D' + N * E' + N * F' + N * G' + N * H' + ...
                      O * A' + O * B' + O * C' + O * D' + O * E' + O * F' + O * G' + O * H' + ...
                      P * A' + P * B' + P * C' + P * D' + P * E' + P * F' + P * G' + P * H'     ;
                   
            R = [Matrix1, Matrix2; Matrix3, 0];
            
            cvx_begin sdp quiet
            variable V(m+1,m+1) hermitian
            maximize(real(trace(R * V)));
            subject to
                diag(V) == 1;
                V >= 0;
            cvx_end
        
            max_F = 0;
            max_v = 0;
            [U, Sigma] = eigs(V, m+1);
            for l = 1 : len
                r = sqrt(2) / 2 * (randn(m+1, 1) + 1j * randn(m+1, 1));
                v = U * Sigma^(0.5) * r;
                if v' * R * v > max_F
                    max_v = v;
                    max_F = v' * R * v;
                end
            end
        
            v = exp(1j * angle(max_v / max_v(end)));
            v = v(1 : m);
        
            phi1 = (v').';
            phi1 = Q2bit(phi1);
        end

        %% Ris2
        if flag_ris_num >= 2
            A = diag(g1 * diag(phi1) * h12) * h23 * diag(phi3) * h34 * diag(phi4) * u4;
            B = diag(g1 * diag(phi1) * h12) * h23 * diag(phi3) * u3;
            C = diag(g1 * diag(phi1) * h12) * h24 * diag(phi4) * u4;
            D = diag(g1 * diag(phi1) * h12)  * u2;
            E = diag(g2) * h23 * diag(phi3) * u3;
            F = diag(g2) * h23 * diag(phi3) * h34 * diag(phi4) * u4;
            G = diag(g2) * h24 * diag(phi4) * u4;
            H = diag(g2) * u2;
        
            I = g1 * diag(phi1) * h13 * diag(phi3) * h34 * diag(phi4) * u4;
            J = g1 * diag(phi1) * h13 * diag(phi3) * u3;
            K = g1 * diag(phi1) * h14 * diag(phi4) * u4;
            L = g1 * diag(phi1) * u1;
            M = g3 * diag(phi3) * h34 * diag(phi4) * u4;
            N = g3 * diag(phi3) * u3;
            O = g4 * diag(phi4) * u4;
            P = Los;
        
            Matrix1 = A * A' + A * B' + A * C' + A * D' + A * E' + A * F' + A * G' + A * H' + ...
                      B * A' + B * B' + B * C' + B * D' + B * E' + B * F' + B * G' + B * H' + ...
                      C * A' + C * B' + C * C' + C * D' + C * E' + C * F' + C * G' + C * H' + ...
                      D * A' + D * B' + D * C' + D * D' + D * E' + D * F' + D * G' + D * H' + ...
                      E * A' + E * B' + E * C' + E * D' + E * E' + E * F' + E * G' + E * H' + ...
                      F * A' + F * B' + F * C' + F * D' + F * E' + F * F' + F * G' + F * H' + ...
                      G * A' + G * B' + G * C' + G * D' + G * E' + G * F' + G * G' + G * H' + ...
                      H * A' + H * B' + H * C' + H * D' + H * E' + H * F' + H * G' + H * H'     ;
        
            Matrix2 = A * I' + A * J' + A * K' + A * L' + A * M' + A * N' + A * O' + A * P' + ...
                      B * I' + B * J' + B * K' + B * L' + B * M' + B * N' + B * O' + B * P' + ...
                      C * I' + C * J' + C * K' + C * L' + C * M' + C * N' + C * O' + C * P' + ...
                      D * I' + D * J' + D * K' + D * L' + D * M' + D * N' + D * O' + D * P' + ...
                      E * I' + E * J' + E * K' + E * L' + E * M' + E * N' + E * O' + E * P' + ...
                      F * I' + F * J' + F * K' + F * L' + F * M' + F * N' + F * O' + F * P' + ...
                      G * I' + G * J' + G * K' + G * L' + G * M' + G * N' + G * O' + G * P' + ...
                      H * I' + H * J' + H * K' + H * L' + H * M' + H * N' + H * O' + H * P'     ;
        
            Matrix3 = I * A' + I * B' + I * C' + I * D' + I * E' + I * F' + I * G' + I * H' + ...
                      J * A' + J * B' + J * C' + J * D' + J * E' + J * F' + J * G' + J * H' + ...
                      K * A' + K * B' + K * C' + K * D' + K * E' + K * F' + K * G' + K * H' + ...
                      L * A' + L * B' + L * C' + L * D' + L * E' + L * F' + L * G' + L * H' + ...
                      M * A' + M * B' + M * C' + M * D' + M * E' + M * F' + M * G' + M * H' + ...
                      N * A' + N * B' + N * C' + N * D' + N * E' + N * F' + N * G' + N * H' + ...
                      O * A' + O * B' + O * C' + O * D' + O * E' + O * F' + O * G' + O * H' + ...
                      P * A' + P * B' + P * C' + P * D' + P * E' + P * F' + P * G' + P * H'     ;
        
            R = [Matrix1, Matrix2; Matrix3, 0];
            
        
            cvx_begin sdp quiet
            variable V(m+1,m+1) hermitian
            maximize(real(trace(R * V)));
            subject to
                diag(V) == 1;
                V >= 0;
            cvx_end
        
            max_F = 0;
            max_v = 0;
            [U, Sigma] = eigs(V, m+1);
            for l = 1 : len
                r = sqrt(2) / 2 * (randn(m+1, 1) + 1j * randn(m+1, 1));
                v = U * Sigma^(0.5) * r;
                if v' * R * v > max_F
                    max_v = v;
                    max_F = v' * R * v;
                end
            end
        
            v = exp(1j * angle(max_v / max_v(end)));
            v = v(1 : m);
        
            phi2 = (v').';
            phi2 = Q2bit(phi2);
        end

        %% Ris3
        if flag_ris_num >= 3
            A = diag(g1 * diag(phi1) * h12 * diag(phi2) * h23) * h34 * diag(phi4) * u4;
            B = diag(g1 * diag(phi1) * h12 * diag(phi2) * h23) * u3;
            C = diag(g1 * diag(phi1) * h13) * h34 * diag(phi4) * u4;
            D = diag(g1 * diag(phi1) * h13) * u3;
            E = diag(g2 * diag(phi2) * h23) * u3;
            F = diag(g2 * diag(phi2) * h23) * h34 * diag(phi4) * u4;
            G = diag(g3) * h34 * diag(phi4) * u4;
            H = diag(g3) * u3;
    
            I = g1 * diag(phi1) * h12 * diag(phi2) * h24 * diag(phi4) * u4;
            J = g1 * diag(phi1) * h12 * diag(phi2) * u2;
            K = g1 * diag(phi1) * h14 * diag(phi4) * u4;
            L = g1 * diag(phi1) * u1;
            M = g2 * diag(phi2) * h24 * diag(phi4) * u4;
            N = g2 * diag(phi2) * u2;
            O = g4 * diag(phi4) * u4;
            P = Los;
    
            Matrix1 = A * A' + A * B' + A * C' + A * D' + A * E' + A * F' + A * G' + A * H' + ...
                      B * A' + B * B' + B * C' + B * D' + B * E' + B * F' + B * G' + B * H' + ...
                      C * A' + C * B' + C * C' + C * D' + C * E' + C * F' + C * G' + C * H' + ...
                      D * A' + D * B' + D * C' + D * D' + D * E' + D * F' + D * G' + D * H' + ...
                      E * A' + E * B' + E * C' + E * D' + E * E' + E * F' + E * G' + E * H' + ...
                      F * A' + F * B' + F * C' + F * D' + F * E' + F * F' + F * G' + F * H' + ...
                      G * A' + G * B' + G * C' + G * D' + G * E' + G * F' + G * G' + G * H' + ...
                      H * A' + H * B' + H * C' + H * D' + H * E' + H * F' + H * G' + H * H'     ;
    
            Matrix2 = A * I' + A * J' + A * K' + A * L' + A * M' + A * N' + A * O' + A * P' + ...
                      B * I' + B * J' + B * K' + B * L' + B * M' + B * N' + B * O' + B * P' + ...
                      C * I' + C * J' + C * K' + C * L' + C * M' + C * N' + C * O' + C * P' + ...
                      D * I' + D * J' + D * K' + D * L' + D * M' + D * N' + D * O' + D * P' + ...
                      E * I' + E * J' + E * K' + E * L' + E * M' + E * N' + E * O' + E * P' + ...
                      F * I' + F * J' + F * K' + F * L' + F * M' + F * N' + F * O' + F * P' + ...
                      G * I' + G * J' + G * K' + G * L' + G * M' + G * N' + G * O' + G * P' + ...
                      H * I' + H * J' + H * K' + H * L' + H * M' + H * N' + H * O' + H * P'     ;
    
            Matrix3 = I * A' + I * B' + I * C' + I * D' + I * E' + I * F' + I * G' + I * H' + ...
                      J * A' + J * B' + J * C' + J * D' + J * E' + J * F' + J * G' + J * H' + ...
                      K * A' + K * B' + K * C' + K * D' + K * E' + K * F' + K * G' + K * H' + ...
                      L * A' + L * B' + L * C' + L * D' + L * E' + L * F' + L * G' + L * H' + ...
                      M * A' + M * B' + M * C' + M * D' + M * E' + M * F' + M * G' + M * H' + ...
                      N * A' + N * B' + N * C' + N * D' + N * E' + N * F' + N * G' + N * H' + ...
                      O * A' + O * B' + O * C' + O * D' + O * E' + O * F' + O * G' + O * H' + ...
                      P * A' + P * B' + P * C' + P * D' + P * E' + P * F' + P * G' + P * H'     ;
    
            R = [Matrix1, Matrix2; Matrix3, 0];
    
    
            cvx_begin sdp quiet
            variable V(m+1,m+1) hermitian
            maximize(real(trace(R * V)));
            subject to
                diag(V) == 1;
                V >= 0;
            cvx_end
        
            max_F = 0;
            max_v = 0;
            [U, Sigma] = eigs(V, m+1);
            for l = 1 : len
                r = sqrt(2) / 2 * (randn(m+1, 1) + 1j * randn(m+1, 1));
                v = U * Sigma^(0.5) * r;
                if v' * R * v > max_F
                    max_v = v;
                    max_F = v' * R * v;
                end
            end
        
            v = exp(1j * angle(max_v / max_v(end)));
            v = v(1 : m);
    
            phi3 = (v').';
            phi3 = Q2bit(phi3);
        end

        %% Ris4
        if flag_ris_num >= 4
            A = diag(g1 * diag(phi1) * h12 * diag(phi2) * h23 * diag(phi3) * h34) * u4;
            B = diag(g1 * diag(phi1) * h12 * diag(phi2) * h24) * u4;
            C = diag(g4) * u4;
            D = diag(g3 * diag(phi3) * h34) * u4;
            E = diag(g2 * diag(phi2) * h24) * u4;
            F = diag(g2 * diag(phi2) * h23 * diag(phi3) * h34) * u4;
            G = diag(g1 * diag(phi1) * h14) * u4;
            H = diag(g1 * diag(phi1) * h13 * diag(phi3) * h34) * u4;
    
            I = g1 * diag(phi1) * h12 * diag(phi2) * h23 * diag(phi3) * u3;
            J = g1 * diag(phi1) * h12 * diag(phi2) * u2;
            K = g1 * diag(phi1) * h13 * diag(phi3) * u3;
            L = g1 * diag(phi1) * u1;
            M = g2 * diag(phi2) * h23 * diag(phi3) * u3;
            N = g2 * diag(phi2) * u2;
            O = g3 * diag(phi3) * u3;
            P = Los;
    
            Matrix1 = A * A' + A * B' + A * C' + A * D' + A * E' + A * F' + A * G' + A * H' + ...
                      B * A' + B * B' + B * C' + B * D' + B * E' + B * F' + B * G' + B * H' + ...
                      C * A' + C * B' + C * C' + C * D' + C * E' + C * F' + C * G' + C * H' + ...
                      D * A' + D * B' + D * C' + D * D' + D * E' + D * F' + D * G' + D * H' + ...
                      E * A' + E * B' + E * C' + E * D' + E * E' + E * F' + E * G' + E * H' + ...
                      F * A' + F * B' + F * C' + F * D' + F * E' + F * F' + F * G' + F * H' + ...
                      G * A' + G * B' + G * C' + G * D' + G * E' + G * F' + G * G' + G * H' + ...
                      H * A' + H * B' + H * C' + H * D' + H * E' + H * F' + H * G' + H * H'     ;
    
            Matrix2 = A * I' + A * J' + A * K' + A * L' + A * M' + A * N' + A * O' + A * P' + ...
                      B * I' + B * J' + B * K' + B * L' + B * M' + B * N' + B * O' + B * P' + ...
                      C * I' + C * J' + C * K' + C * L' + C * M' + C * N' + C * O' + C * P' + ...
                      D * I' + D * J' + D * K' + D * L' + D * M' + D * N' + D * O' + D * P' + ...
                      E * I' + E * J' + E * K' + E * L' + E * M' + E * N' + E * O' + E * P' + ...
                      F * I' + F * J' + F * K' + F * L' + F * M' + F * N' + F * O' + F * P' + ...
                      G * I' + G * J' + G * K' + G * L' + G * M' + G * N' + G * O' + G * P' + ...
                      H * I' + H * J' + H * K' + H * L' + H * M' + H * N' + H * O' + H * P'     ;
    
            Matrix3 = I * A' + I * B' + I * C' + I * D' + I * E' + I * F' + I * G' + I * H' + ...
                      J * A' + J * B' + J * C' + J * D' + J * E' + J * F' + J * G' + J * H' + ...
                      K * A' + K * B' + K * C' + K * D' + K * E' + K * F' + K * G' + K * H' + ...
                      L * A' + L * B' + L * C' + L * D' + L * E' + L * F' + L * G' + L * H' + ...
                      M * A' + M * B' + M * C' + M * D' + M * E' + M * F' + M * G' + M * H' + ...
                      N * A' + N * B' + N * C' + N * D' + N * E' + N * F' + N * G' + N * H' + ...
                      O * A' + O * B' + O * C' + O * D' + O * E' + O * F' + O * G' + O * H' + ...
                      P * A' + P * B' + P * C' + P * D' + P * E' + P * F' + P * G' + P * H'     ;    
    
            R = [Matrix1, Matrix2; Matrix3, 0];
    
    
            cvx_begin sdp quiet
            variable V(m+1,m+1) hermitian
            maximize(real(trace(R * V)));
            subject to
                diag(V) == 1;
                V >= 0;
            cvx_end
        
            max_F = 0;
            max_v = 0;
            [U, Sigma] = eigs(V, m+1);
            for l = 1 : len
                r = sqrt(2) / 2 * (randn(m+1, 1) + 1j * randn(m+1, 1));
                v = U * Sigma^(0.5) * r;
                if v' * R * v > max_F
                    max_v = v;
                    max_F = v' * R * v;
                end
            end
        
            v = exp(1j * angle(max_v / max_v(end)));
            v = v(1 : m);
    
            phi4 = (v').';
            phi4 = Q2bit(phi4);
        end

        %% Calculate H.
        dB_H_temp = g1 * diag(phi1) * h12 * diag(phi2) * h23 * diag(phi3) * h34 * diag(phi4) * u4 + ...
            g1 * diag(phi1) * h12 * diag(phi2) * h23 * diag(phi3) * u3 + ...
            g1 * diag(phi1) * h12 * diag(phi2) * h24 * diag(phi4) * u4 + ...
            g1 * diag(phi1) * h12 * diag(phi2) * u2 + ...
            g1 * diag(phi1) * h13 * diag(phi3) * h34 * diag(phi4) * u4 + ...
            g1 * diag(phi1) * h13 * diag(phi3) * u3 + ...
            g1 * diag(phi1) * h14 * diag(phi4) * u4 + ...
            g1 * diag(phi1) * u1 + ...
            g2 * diag(phi2) * h23 * diag(phi3) * u3 + ...
            g2 * diag(phi2) * h23 * diag(phi3) * h34 * diag(phi4) * u4 + ...
            g2 * diag(phi2) * h24 * diag(phi4) * u4 + ...
            g2 * diag(phi2) * u2 + ...
            g3 * diag(phi3) * h34 * diag(phi4) * u4 + ...
            g3 * diag(phi3) * u3 + ...
            g4 * diag(phi4) * u4;
        
        dB_H = [dB_H, 20*log10(abs(dB_H_temp))];
        
        % If the difference in dB between the results of the optimization in two consecutive iterations does not exceed 0.1 dB, 
        % convergence is considered achieved, and the entire loop process is exited, ending the optimization process.
        if i ~= 1
            if abs(dB_H(i) - dB_H(i - 1)) <= 0.3
                break;
            end
        end
    end

    %% Quantize the phase configuration of the metasurface into a codebook format.
    phi1_d = [];
    phi2_d = [];
    phi3_d = [];
    phi4_d = [];

    phi1_d = Quantize(phi1);
    phi2_d = Quantize(phi2);
    phi3_d = Quantize(phi3);
    phi4_d = Quantize(phi4);
end

function Phase = Quantize(phi) 
    global MTS_ele_num
    Phase = [];
    phi1 = mod(angle(phi), 2 * pi);
    for i = 1 : MTS_ele_num * MTS_ele_num
        if (phi1(i)) < pi / 2
            Phase = [Phase; 0];
        elseif (phi1(i)) < pi
            Phase = [Phase; 1];
        elseif (phi1(i)) < pi / 2 * 3
            Phase = [Phase; 2];
        else
            Phase = [Phase; 3];
        end
    end
end