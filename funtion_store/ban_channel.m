function ban_channel(p1, p2, p3, p4)
    global g1 g2 g3 g4
    global u1 u2 u3 u4
    global h12 h13 h14 h23 h24 h34 flag_ris_num MTS_ele_num
    
    %% Determine the number of metasurfaces.
    cal_mts_number(p1, p2, p3, p4);

    if flag_ris_num==1
        g2 = zeros(1, MTS_ele_num * MTS_ele_num);
        g3 = zeros(1, MTS_ele_num * MTS_ele_num);
        g4 = zeros(1, MTS_ele_num * MTS_ele_num);
        u2 = zeros(MTS_ele_num * MTS_ele_num ,1);
        u3 = zeros(MTS_ele_num * MTS_ele_num ,1);
        u4 = zeros(MTS_ele_num * MTS_ele_num ,1);
        h12 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h13 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h14 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h23 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h24 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h34 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
    
    elseif flag_ris_num==2
        g3 = zeros(1, MTS_ele_num * MTS_ele_num);
        g4 = zeros(1, MTS_ele_num * MTS_ele_num);
        u3 = zeros(MTS_ele_num * MTS_ele_num ,1);
        u4 = zeros(MTS_ele_num * MTS_ele_num ,1);
        h13 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h14 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h23 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h24 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h34 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
    elseif flag_ris_num==3
        g4 = zeros(1, MTS_ele_num * MTS_ele_num);
        u4 = zeros(MTS_ele_num * MTS_ele_num ,1);
        h14 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h24 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
        h34 = zeros(MTS_ele_num * MTS_ele_num, MTS_ele_num * MTS_ele_num);
    elseif flag_ris_num==4
    
    end
end