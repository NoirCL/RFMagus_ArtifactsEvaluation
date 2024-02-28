function [angle_ris1_ris2,angle_ris1_ris3,angle_ris1_rx,angle_ris2_rx,angle_ris2_ris3,angle_ris3_rx,angle_ris3_ris4,angle_ris4_rx] = ccal_angle(p1,p2,p3,p4)
    global Tx;
    global Rx;
    global cor_z;
    
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

    global  cor_ris1_x;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    global  cor_ris1_y;
    
    global  cor_ris2_x;
    global  cor_ris2_y;
    
    global  cor_ris3_x;
    global  cor_ris3_y;
    
    global  cor_ris4_x;
    global  cor_ris4_y;

    location_ris1=[center_ris1_x;center_ris1_y];
    location_ris2=[center_ris2_x;center_ris2_y];
    location_ris3=[center_ris3_x;center_ris3_y];
    location_ris4=[center_ris4_x;center_ris4_y];
    location_tx=Tx(1:2)';
    location_rx=Rx(1:2)';

    p1=deg2rad(540-p1);
    p2=deg2rad(540-p2);
    p3=deg2rad(540-p3);
    p4=deg2rad(540-p4);
    %% RIS1
    angle_ris1_rx=make_angle(location_ris1,location_rx,p1)
    angle_ris1_ris2=make_angle(location_ris1,location_ris2,p1)
    angle_ris1_ris3=make_angle(location_ris1,location_ris3,p1)
    %% RIS2
    angle_ris2_rx=make_angle(location_ris2,location_rx,p2)
    angle_ris2_ris3=make_angle(location_ris2,location_ris3,p2)
    %% RIS3
    angle_ris3_rx=make_angle(location_ris3,location_rx,p3)
    angle_ris3_ris4=make_angle(location_ris3,location_ris4,p3)
    %% RIS4
    angle_ris4_rx=make_angle(location_ris4,location_rx,p4)
end

function angle_risa_risb=make_angle(location_risa,location_risb,p_risa)
     % RIS a is the starting point and RIS b is the endpoint.
     rotate_risa=[cos(p_risa),-sin(p_risa);sin(p_risa),cos(p_risa)];
     shift_risa=location_risa;

     location_risa_temp=location_risa-shift_risa;
     location_risa_temp=rotate_risa*location_risa_temp;

     location_risb_temp=location_risb-shift_risa;
     location_risb_temp=rotate_risa*location_risb_temp;


     angle_risa_risb=location_risb_temp;  
     [angle_risa_risb,~]=cart2pol(angle_risa_risb(1),angle_risa_risb(2));
     
     % Prevent data fluctuation that may result in the inability to calculate zero.
     if angle_risa_risb<pi/2+10^(-13)&&angle_risa_risb>pi/2-10^(-13)
         angle_risa_risb=0;
     elseif pi/2<angle_risa_risb&&angle_risa_risb<pi
           angle_risa_risb=rad2deg(angle_risa_risb)-90;
     elseif angle_risa_risb<pi/2&&0<angle_risa_risb
           angle_risa_risb=-(90-rad2deg(angle_risa_risb));
     else
         angle_risa_risb=nan;
     end
end
