function [g1, g2, g3, g4,...
          u1, u2, u3, u4, ...
          h12, h13, h14, h23, h24, h34, ...
          Los] = ccal_channel_multi_rx(K_dB_channel, K_dB_Los, ...
                                    N_g1, N_g2, N_g3, N_g4, ...
                                    N_u1, N_u2, N_u3, N_u4, ...
                                    N_h12, N_h13, N_h14, N_h23, N_h24, N_h34,...
                                    N_Los) 
    global dis_g1
    global dis_g2
    global dis_g3
    global dis_g4
    global dis_h12
    global dis_h23
    global dis_h34
    global dis_h13
    global dis_h14
    global dis_h24
    global dis_u1
    global dis_u2
    global dis_u3
    global dis_u4
    global dis_Los
    global MTS_ele_num
    
    g1 = rreshape(rice_matrix(cal_g1(N_g1), K_dB_channel, MTS_ele_num, MTS_ele_num), 1, MTS_ele_num*MTS_ele_num);
    g2 = rreshape(rice_matrix(cal_g2(N_g2), K_dB_channel, MTS_ele_num, MTS_ele_num), 1, MTS_ele_num*MTS_ele_num);
    g3 = rreshape(rice_matrix(cal_g3(N_g3), K_dB_channel, MTS_ele_num, MTS_ele_num), 1, MTS_ele_num*MTS_ele_num);
    g4 = rreshape(rice_matrix(cal_g4(N_g4), K_dB_channel, MTS_ele_num, MTS_ele_num), 1, MTS_ele_num*MTS_ele_num);
    u1 = rreshape(rice_matrix(cal_u1(N_u1), K_dB_channel, MTS_ele_num, MTS_ele_num), MTS_ele_num*MTS_ele_num, 1);
    u2 = rreshape(rice_matrix(cal_u2(N_u2), K_dB_channel, MTS_ele_num, MTS_ele_num), MTS_ele_num*MTS_ele_num, 1);
    u3 = rreshape(rice_matrix(cal_u3(N_u3), K_dB_channel, MTS_ele_num, MTS_ele_num), MTS_ele_num*MTS_ele_num, 1);
    u4 = rreshape(rice_matrix(cal_u4(N_u4), K_dB_channel, MTS_ele_num, MTS_ele_num), MTS_ele_num*MTS_ele_num, 1);
    h12 = rice_matrix(cal_h12(N_h12), K_dB_channel, MTS_ele_num*MTS_ele_num,MTS_ele_num*MTS_ele_num);
    h13 = rice_matrix(cal_h13(N_h13), K_dB_channel, MTS_ele_num*MTS_ele_num,MTS_ele_num*MTS_ele_num);
    h14 = rice_matrix(cal_h14(N_h14), K_dB_channel, MTS_ele_num*MTS_ele_num,MTS_ele_num*MTS_ele_num);
    h23 = rice_matrix(cal_h23(N_h23), K_dB_channel, MTS_ele_num*MTS_ele_num,MTS_ele_num*MTS_ele_num);
    h24 = rice_matrix(cal_h24(N_h24), K_dB_channel, MTS_ele_num*MTS_ele_num,MTS_ele_num*MTS_ele_num);
    h34 = rice_matrix(cal_h34(N_h34), K_dB_channel, MTS_ele_num*MTS_ele_num,MTS_ele_num*MTS_ele_num);
    Los = rice_matrix(cal_Los(N_Los), K_dB_Los, 1 ,1);
end

%% Calculate the channel h12.
function channel = cal_h12(K)
    global  cor_z;
    global  cor_ris1_x cor_ris1_y cor_ris1_z
    global  cor_ris2_x cor_ris2_y cor_ris2_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global dis_h12;
    global Pt;
    global Gt;
    global Gr;
    global MTS_ele_num

    dis = rand(MTS_ele_num*MTS_ele_num, MTS_ele_num*MTS_ele_num);
    BB  = 1 * 1 * 1 * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    for i = 1 : MTS_ele_num*MTS_ele_num
        for j = 1 : MTS_ele_num*MTS_ele_num
            ris1_x = cor_ris1_x(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris1_y = cor_ris1_y(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris1_z = cor_ris1_z(floor((i-1) / MTS_ele_num) +  1);
    
            ris2_x = cor_ris2_x(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris2_y = cor_ris2_y(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris2_z = cor_ris2_z(floor((j - 1) / MTS_ele_num) +  1);
    
            dis(i, j) = sqrt((ris1_x - ris2_x)^2 + (ris1_y - ris2_y)^2 + (ris1_z - ris2_z)^2);
        end
    end


    dis_h12 = sqrt(BB) ./ (dis.^ (K / 2));
    channel =  dis_h12 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel h13.
function channel = cal_h13(K)
    global  cor_z;
    global  cor_ris1_x cor_ris1_y cor_ris1_z
    global  cor_ris3_x cor_ris3_y cor_ris3_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global dis_h13;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    dis = rand(MTS_ele_num*MTS_ele_num, MTS_ele_num*MTS_ele_num);
    BB  = 1 * 1 * 1 * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    for i = 1 : MTS_ele_num*MTS_ele_num
        for j = 1 : MTS_ele_num*MTS_ele_num
            ris1_x = cor_ris1_x(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris1_y = cor_ris1_y(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris1_z = cor_ris1_z(floor((i - 1) / MTS_ele_num) +  1);
    
            ris3_x = cor_ris3_x(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris3_y = cor_ris3_y(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris3_z = cor_ris3_z(floor((j - 1) / MTS_ele_num) +  1);
    
            dis(i, j) = sqrt((ris1_x - ris3_x)^2 + (ris1_y - ris3_y)^2 + (ris1_z - ris3_z)^2);
        end
    end
    
    dis_h13 = sqrt(BB) ./ (dis.^ (K / 2));
    channel =  dis_h13 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel h14.
function channel = cal_h14(K)
    global  cor_z;
    global  cor_ris1_x cor_ris1_y cor_ris1_z
    global  cor_ris4_x cor_ris4_y cor_ris4_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global dis_h14;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    dis = rand(MTS_ele_num*MTS_ele_num, MTS_ele_num*MTS_ele_num);
    BB  = 1 * 1 * 1 * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    for i = 1 : MTS_ele_num*MTS_ele_num
        for j = 1 : MTS_ele_num*MTS_ele_num
            ris1_x = cor_ris1_x(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris1_y = cor_ris1_y(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris1_z = cor_ris1_z(floor((i - 1) / MTS_ele_num) +  1);
    
            ris4_x = cor_ris4_x(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris4_y = cor_ris4_y(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris4_z = cor_ris4_z(floor((j - 1) / MTS_ele_num) +  1);

            dis(i, j) = sqrt((ris1_x - ris4_x)^2 + (ris1_y - ris4_y)^2 + (ris1_z - ris4_z)^2);
        end
    end
    
    dis_h14 = sqrt(BB) ./ (dis.^ (K / 2));
    channel =  dis_h14 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel h23.
function channel = cal_h23(K)
    global  cor_z;
    global  cor_ris2_x cor_ris2_y cor_ris2_z
    global  cor_ris3_x cor_ris3_y cor_ris3_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global dis_h23;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    dis = rand(MTS_ele_num*MTS_ele_num, MTS_ele_num*MTS_ele_num);
    BB  = 1 * 1 * 1 * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    for i = 1 : MTS_ele_num*MTS_ele_num
        for j = 1 : MTS_ele_num*MTS_ele_num
            ris2_x = cor_ris2_x(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris2_y = cor_ris2_y(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris2_z = cor_ris2_z(floor((i - 1) / MTS_ele_num) +  1);
    
            ris3_x = cor_ris3_x(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris3_y = cor_ris3_y(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris3_z = cor_ris3_z(floor((j - 1) / MTS_ele_num) +  1);
    
            dis(i, j) = sqrt((ris2_x - ris3_x)^2 + (ris2_y - ris3_y)^2 + (ris2_z - ris3_z)^2);
        end
    end
    
    dis_h23 = sqrt(BB) ./ (dis.^ (K / 2));
    channel =  dis_h23 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel h24.
function channel = cal_h24(K)
    global  cor_z;
    global  cor_ris2_x cor_ris2_y cor_ris2_z
    global  cor_ris4_x cor_ris4_y cor_ris4_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_h24;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    dis = rand(MTS_ele_num*MTS_ele_num, MTS_ele_num*MTS_ele_num);
    BB  = 1 * 1 * 1 * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    for i = 1 : MTS_ele_num*MTS_ele_num
        for j = 1 : MTS_ele_num*MTS_ele_num
            ris2_x = cor_ris2_x(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris2_y = cor_ris2_y(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris2_z = cor_ris2_z(floor((i - 1) / MTS_ele_num) +  1);
    
            ris4_x = cor_ris4_x(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris4_y = cor_ris4_y(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris4_z = cor_ris4_z(floor((j - 1) / MTS_ele_num) +  1);
    
            dis(i, j) = sqrt((ris2_x - ris4_x)^2 + (ris2_y - ris4_y)^2 + (ris2_z - ris4_z)^2);
        end
    end
    
    dis_h24 = sqrt(BB) ./ (dis.^ (K / 2));
    channel =  dis_h24 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel h34.
function channel = cal_h34(K)
    global  cor_z;
    global  cor_ris3_x cor_ris3_y cor_ris3_z
    global  cor_ris4_x cor_ris4_y cor_ris4_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_h34;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    dis = rand(MTS_ele_num*MTS_ele_num, MTS_ele_num*MTS_ele_num);
    BB  = 1 * 1 * 1 * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    for i = 1 : MTS_ele_num*MTS_ele_num
        for j = 1 : MTS_ele_num*MTS_ele_num
            ris3_x = cor_ris3_x(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris3_y = cor_ris3_y(i - MTS_ele_num * floor((i - 1) / MTS_ele_num));
            ris3_z = cor_ris3_z(floor((i - 1) / MTS_ele_num) +  1);
    
            ris4_x = cor_ris4_x(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris4_y = cor_ris4_y(j - MTS_ele_num * floor((j - 1) / MTS_ele_num));
            ris4_z = cor_ris4_z(floor((j - 1) / MTS_ele_num) +  1);
    
            dis(i, j) = sqrt((ris3_x - ris4_x)^2 + (ris3_y - ris4_y)^2 + (ris3_z - ris4_z)^2);
        end
    end
    
    dis_h34 = sqrt(BB) ./ (dis.^ (K / 2));
    channel =  dis_h34 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel u4.
function channel = cal_u4(K)
    global  cor_z;
    global  cor_ris4_x cor_ris4_y cor_ris4_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global dis_u4;
    global Pt;
    global Gt;
    global Gr;
    global MTS_ele_num

    BB  = 1 * 1 * Gr * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]

    channel=[];


        for i = 1 : MTS_ele_num
            for j = 1 : MTS_ele_num
                dis(i, j) = sqrt((cor_ris4_x(j) - Rx(1))^2 + (cor_ris4_y(j) - Rx(2))^2 + (cor_ris4_z(i) - Rx(3))^2);
            end
        end
        dis_u4 = sqrt(BB) ./ (dis.^ (K / 2));  
        channel =dis_u4.*exp(1i*2*pi*dis/lambda);

end

%% Calculate the channel u3.
function channel = cal_u3(K)
    global  cor_z;
    global  cor_ris3_x cor_ris3_y cor_ris3_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_u3;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = 1 * 1 * Gr * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]

    channel=[];

    for k = 1:size(Rx,1)
        for i = 1 : MTS_ele_num
            for j = 1 : MTS_ele_num
                dis(i, j) = sqrt((cor_ris3_x(j) - Rx(1))^2 + (cor_ris3_y(j) - Rx(2))^2 + (cor_ris3_z(i) - Rx(3))^2);
            end
        end
        dis_u3 = sqrt(BB) ./ (dis.^ (K / 2));  
        channel =dis_u3.*exp(1i*2*pi*dis/lambda);
    end   
end

%% Calculate the channel u2.
function channel = cal_u2(K)
    global  cor_z;
    global  cor_ris2_x cor_ris2_y cor_ris2_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global dis_u2;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = 1 * 1 * Gr * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]

    channel=[];

    for k = 1:size(Rx,1)
        for i = 1 : MTS_ele_num
            for j = 1 : MTS_ele_num
                dis(i, j) = sqrt((cor_ris2_x(j) - Rx(1))^2 + (cor_ris2_y(j) - Rx(2))^2 + (cor_ris2_z(i) - Rx(3))^2);
            end
        end
        dis_u2 = sqrt(BB) ./ (dis.^ (K / 2));  
        channel =dis_u2 .* exp(1i * 2 * pi * dis / lambda);
    end   
end

%% Calculate the channel u1.
function channel = cal_u1(K)
    global  cor_z;
    global  cor_ris1_x cor_ris1_y cor_ris1_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global dis_u1;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = 1 * 1 * Gr * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);

    ["BB = " BB]

    channel=[];

    for k = 1:size(Rx,1)
        for i = 1 : MTS_ele_num
            for j = 1 : MTS_ele_num
                dis(i, j) = sqrt((cor_ris1_x(j) - Rx(1))^2 + (cor_ris1_y(j) - Rx(2))^2 + (cor_ris1_z(i) - Rx(3))^2);
            end
        end
        dis_u1 = sqrt(BB) ./ (dis.^ (K / 2)); 
        channel =dis_u1 .* exp(1i * 2 * pi * dis / lambda);
    end 
end

%% Calculate the channel g1.
function channel = cal_g1(K)
    global  cor_z;
    global  cor_ris1_x cor_ris1_y cor_ris1_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_g1;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = Pt * Gt * 1 * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]
    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            dis(i, j) = sqrt((cor_ris1_x(j) - Tx(1))^2 + (cor_ris1_y(j) - Tx(2))^2 + (cor_ris1_z(i) - Tx(3))^2);
        end
    end
    
    dis_g1 = sqrt(BB) ./ (dis.^ (K / 2));
    channel = dis_g1 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel g2.
function channel = cal_g2(K)
    global  cor_z;
    global  cor_ris2_x cor_ris2_y cor_ris2_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_g2;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = Pt * Gt * 1 * c^2 / (4 * pi * f)^2;

    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]
    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            dis(i, j) = sqrt((cor_ris2_x(j) - Tx(1))^2 + (cor_ris2_y(j) - Tx(2))^2 + (cor_ris2_z(i) - Tx(3))^2);
        end
    end
    
    dis_g2 = sqrt(BB) ./ (dis.^ (K / 2));
    channel = dis_g2 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel g3.
function channel = cal_g3(K)
    global  cor_z;
    global  cor_ris3_x cor_ris3_y cor_ris3_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_g3;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = Pt * Gt * 1 * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]

    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            dis(i, j) = sqrt((cor_ris3_x(j) - Tx(1))^2 + (cor_ris3_y(j) - Tx(2))^2 + (cor_ris3_z(i) - Tx(3))^2);
        end
    end
    
    dis_g3 = sqrt(BB) ./ (dis.^ (K / 2));
    channel = dis_g3 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel g4.
function channel = cal_g4(K)
    global  cor_z;
    global  cor_ris4_x cor_ris4_y cor_ris4_z
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_g4;
    global Pt;
    global Gt;
    global Gr;
        global MTS_ele_num

    BB  = Pt * Gt * 1 * c^2 / (4 * pi * f)^2;
    dis = rand(MTS_ele_num, MTS_ele_num);
    ["BB = " BB]

    for i = 1 : MTS_ele_num
        for j = 1 : MTS_ele_num
            dis(i, j) = sqrt((cor_ris4_x(j) - Tx(1))^2 + (cor_ris4_y(j) - Tx(2))^2 + (cor_ris4_z(i) - Tx(3))^2);
        end
    end
    
    dis_g4 = sqrt(BB) ./ (dis.^ (K / 2));
    channel = dis_g4 .* exp(1i * 2 * pi * dis / lambda);
end

%% Calculate the channel Los.
function channel = cal_Los(K)
    global  cor_z;
    global Tx;
    global Rx;
    global f;
    global c;
    global lambda;
    global BB;
    global temp;
    global dis_Los;
    global Pt;
    global Gt;
    global Gr;
    global MTS_ele_num

    BB  = Pt * Gt * Gr * c^2 / (4 * pi * f)^2;
    ["BB = " BB]

    dis = sqrt((Tx(1) - Rx(1))^2 + (Tx(2) - Rx(2))^2 + (Tx(3) - Rx(3))^2);

    dis_Los = sqrt(BB) ./ (dis.^ (K / 2));
    channel = dis_Los .* exp(1i * 2 * pi * dis / lambda);
end