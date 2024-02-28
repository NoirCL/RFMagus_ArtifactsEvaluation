function cal_mts_number(p1, p2, p3, p4)
    global flag_ris_num
    
    %% Calculate the angles between metasurfaces, Tx and metasurfaces, and metasurfaces and Rx.
    % Ang_ris1_ris2 is the angle from metasurface 1 to metasurface 2.
    % Ang_ris1_rxis the angle from metasurface 1 to Rx.
    % Ang_ris2_rx is the angle from metasurface 2 to Rx.
    % Ang_ris2_ris3 is the angle from metasurface 2 to metasurface 3.
    % Ang_ris3_rx is the angle from metasurface 3 to Rx.
    % Ang_ris3_ris4 is the angle from metasurface 3 to metasurface 4.
    % Ang_ris4_rx is the angle from metasurface 4 to Rx.
    [Ang_ris1_ris2, ~, Ang_ris1_rx, Ang_ris2_rx, Ang_ris2_ris3, Ang_ris3_rx, Ang_ris3_ris4, Ang_ris4_rx] = ccal_angle(p1,p2,p3,p4);

    %% Determine the number of metasurfaces.
    if ~isnan(Ang_ris1_rx)
        flag_ris_num = 1;
    end
    
    if ~isnan(Ang_ris1_ris2)&&~isnan(Ang_ris2_rx)
        flag_ris_num = 2;
    end
    
    if ~isnan(Ang_ris1_ris2)&&~isnan(Ang_ris2_ris3)&&~isnan(Ang_ris3_rx)
        flag_ris_num = 3;
    end
    
    if ~isnan(Ang_ris1_ris2)&&~isnan(Ang_ris2_ris3)&&~isnan(Ang_ris3_ris4)&&~isnan(Ang_ris4_rx)
        flag_ris_num = 4;
    end
end
