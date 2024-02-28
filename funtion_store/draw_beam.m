function draw_beam(phi1_d, phi2_d, phi3_d, phi4_d)
    global g1 g2 g3 g4
    global u1 u2 u3 u4
    global h12 h13 h14 h23 h24 h34
    global flag_need_dir_graph flag_ris_num

    if flag_need_dir_graph == 1

        if flag_ris_num >= 1
            Phase1 = g1 * diag(phi1_d);
            draw_ris_dir(0, Phase1, 12);
            sgtitle('Radiation pattern: MTS_1');
        end

        if flag_ris_num >= 2
            Phase2 = g1 * diag(phi1_d) * h12 * diag(phi2_d) + g2 * diag(phi2_d);
            draw_ris_dir(0, Phase2, 12);
            sgtitle('Radiation pattern: MTS_2');
        end

        if flag_ris_num >= 3
            Phase3 = g1 * diag(phi1_d) * h12 * diag(phi2_d) * h23 * diag(phi3_d) + ...
                g1 * diag(phi1_d) * h13 * diag(phi3_d) + ...
                g3 * diag(phi3_d) + ...
                g2 * diag(phi2_d) * h23 * diag(phi3_d);
            draw_ris_dir(0, Phase3, 12);
            sgtitle('Radiation pattern: MTS_3');
        end

        if flag_ris_num >= 4 
            Phase4 = g1 * diag(phi1_d) * h12 * diag(phi2_d) * h23 * diag(phi3_d) * h34 * diag(phi4_d) + ...
                g1 * diag(phi1_d) * h12 * diag(phi2_d) * h24 * diag(phi4_d) + ...
                g1 * diag(phi1_d) * h13 * diag(phi3_d) * h34 * diag(phi4_d) + ...
                g1 * diag(phi1_d) * h14 * diag(phi4_d) + ...
                g2 * diag(phi2_d) * h23 * diag(phi3_d) * h34 * diag(phi4_d) + ...
                g2 * diag(phi2_d) * h23 * diag(phi3_d) * u3 + ...
                g3 * diag(phi3_d) * h34 * diag(phi4_d) + ...
                g4 * diag(phi4_d);
            draw_ris_dir(0, Phase4, 12);
            sgtitle('Radiation pattern: MTS_4');
        end
        
    end
end