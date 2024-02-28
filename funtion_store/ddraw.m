function ddraw
    %%
    global d;
    global BB;
    global f;
    global lambda;
    global Tx;
    global Rx;
    global cor_z;
    global MTS_ele_num
    
    global  cor_ris1_x;
    global  cor_ris1_y;
    global  cor_ris1_z;
    
    global  cor_ris2_x;
    global  cor_ris2_y;
    global  cor_ris2_z;
    
    global  cor_ris3_x;
    global  cor_ris3_y;
    global  cor_ris3_z;
    
    global  cor_ris4_x;
    global  cor_ris4_y;
    global  cor_ris4_z;

    global temp;
    global start_z;
    
    global center_ris1_x;
    global center_ris1_y;
    global center_ris1_z;
    
    global center_ris2_x;
    global center_ris2_y;
    global center_ris2_z;
    
    global center_ris3_x;
    global center_ris3_y;
    global center_ris3_z;
    
    global center_ris4_x;
    global center_ris4_y;
    global center_ris4_z;
    
    global dis_correct1;
    global dis_correct2;
    global dis_correct3;
    global dis_correct4;
    
    global dis_center_rx;
    global dis_center_tx;
    
    global dis_g1
    global dis_g2
    global dis_u1
    global dis_u2
    global dis_u3
    global dis_h1
    global dis_h2
    global dis_h3
    global g1 g2 h1 h2 h3 u1 u2 u3
    global Nx
    global Ny
    global flag_need_dir_graph;
    global flag_deg
    global flag
    global MTS_ele_Num

    %%
    figure
    title("Metasurface deployment diagram.");
    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            plot3(cor_ris1_x(j), cor_ris1_y(j), cor_ris1_z(i),'r.');
            grid on;
            hold on;
        end
    end
    
    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            plot3(cor_ris2_x(j), cor_ris2_y(j), cor_ris2_z(i),'g.');
            grid on;
            hold on;
        end
    end
    
    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            plot3(cor_ris3_x(j), cor_ris3_y(j), cor_ris3_z(i),'m.');
            grid on;
            hold on;
        end
    end

    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            plot3(cor_ris4_x(j), cor_ris4_y(j), cor_ris4_z(i),'y.');
            grid on;
            hold on;
        end
    end

    axis equal
    plot3(Tx(1), Tx(2), Tx(3), 'b*');
    text(Tx(1), Tx(2), Tx(3), 'Tx', 'FontSize', 12)
    hold on;
    axis equal
    plot3(Rx(1), Rx(2), Rx(3), 'r*');
    text(Rx(1), Rx(2), Rx(3), "Rx", 'FontSize', 12)
    hold on;
    axis equal
    plot3(center_ris1_x, center_ris1_y, center_ris1_z, 'k.');
    text(center_ris1_x, center_ris1_y, center_ris1_z, "MTS_1", 'FontSize', 12)
    hold on;
    axis equal
    plot3(center_ris2_x, center_ris2_y, center_ris2_z, 'k.');
    text(center_ris2_x, center_ris2_y, center_ris2_z, "MTS_2", 'FontSize', 12)
    axis equal
    plot3(center_ris3_x, center_ris3_y, center_ris3_z, 'k.');
    text(center_ris3_x, center_ris3_y, center_ris3_z, "MTS_3", 'FontSize', 12)
    axis equal
    plot3(center_ris4_x, center_ris4_y, center_ris4_z, 'k.');
    text(center_ris4_x, center_ris4_y, center_ris4_z, "MTS_4", 'FontSize', 12)
    axis equal

    view(0,90)
end