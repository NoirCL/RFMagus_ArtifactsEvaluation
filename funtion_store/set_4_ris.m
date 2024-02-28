function  set_4_ris(x1, y1, z1, p1, x2, y2, z2, p2, x3, y3, z3, p3, x4, y4, z4, p4)
    %% Input
    % Coordinates of each central element in the metasurface and the placement angle of the metasurface.
    %% output
    % x, y, z coordinates of each element on each metasurface.

    %% Predefined parameters.
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

    global MTS_ele_num d
    
    %% Initialization.
    if x1~=0 && y1~=0 && z1~=0
        x1 = x1 - MTS_ele_num/2 * d * cos(deg2rad(p1));
        y1 = y1 - MTS_ele_num/2 * d * sin(deg2rad(p1));
        z1 = z1 - MTS_ele_num/2 * d ;
    end
    if x2~=0 && y2~=0 && z2~=0
        x2 = x2 - MTS_ele_num/2 * d * cos(deg2rad(p2));
        y2 = y2 - MTS_ele_num/2 * d * sin(deg2rad(p2));
        z2 = z2 - MTS_ele_num/2 * d ;
    end
    if x3~=0 && y3~=0 && z3~=0
        x3 = x3 - MTS_ele_num/2 * d * cos(deg2rad(p3));
        y3 = y3 - MTS_ele_num/2 * d * sin(deg2rad(p3));
        z3 = z3 - MTS_ele_num/2 * d ;
    end
    if x4~=0 && y4~=0 && z4~=0
        x4 = x4 - MTS_ele_num/2 * d * cos(deg2rad(p4));
        y4 = y4 - MTS_ele_num/2 * d * sin(deg2rad(p4));
        z4 = z4 - MTS_ele_num/2 * d ;
    end

    %% Placement of Ris1.
    theta1 = atan (y1 / x1) * 180 / pi;
    r1 = sqrt(x1^2+y1^2);
    [cor_ris1_x, cor_ris1_y, cor_ris1_z, center_ris1_x, center_ris1_y, center_ris1_z] = sset_ris(z1, r1, theta1, p1);

    %% Placement of Ris2.
    theta2 = atan (y2 / x2) * 180 / pi;
    r2 = sqrt(x2^2+y2^2);
    [cor_ris2_x, cor_ris2_y, cor_ris2_z, center_ris2_x, center_ris2_y, center_ris2_z] = sset_ris(z2, r2, theta2, p2);

    %% Placement of Ris3.
    theta3=atan(y3/x3) * 180 / pi;
    r3 = sqrt(x3^2 + y3^2);
    [cor_ris3_x, cor_ris3_y, cor_ris3_z, center_ris3_x, center_ris3_y, center_ris3_z] = sset_ris(z3, r3, theta3, p3);

    %% Placement of Ris4.
    theta4=atan(y4/x4)*180/pi;
    r4=sqrt(x4^2+y4^2);
    [cor_ris4_x, cor_ris4_y, cor_ris4_z, center_ris4_x, center_ris4_y, center_ris4_z] = sset_ris(z4, r4, theta4, p4);

end