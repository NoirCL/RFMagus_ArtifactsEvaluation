function [cor_x, cor_y, cor_z, center_x, center_y, center_z] = sset_ris(z, ds, theta, phi)
    % theta is angle between the line connecting the bottom left corner element to the origin and the X-axis.
    % phi is angle between RIS and the X-axis.
    % d is spacing between each element.
    % z is the height of the closest element from the ground.
    
    global d;
    global MTS_ele_num
    
    theta = deg2rad(theta);
    phi = deg2rad(phi);
    
    start_x = ds * cos(theta);
    start_y = ds * sin(theta);
    
    cor_x = rand(1, MTS_ele_num);
    cor_y = rand(1, MTS_ele_num);
    
    cor_x(1) = start_x;
    cor_y(1) = start_y;
    
    % calculate the x and y coordinates of the elements.
    for i = 2 : MTS_ele_num
        cor_x(i) = start_x + (i - 1) * d * cos(phi);
        cor_y(i) = start_y + (i - 1) * d * sin(phi);
    end

    for i = 1 : MTS_ele_num
        cor_z(i) = (MTS_ele_num - i) * d + z;
    end

    center_x = start_x + (MTS_ele_num / 2 - 0.5) * d * cos(phi);
    center_y = start_y + (MTS_ele_num / 2 - 0.5) * d * sin(phi);
    center_z = z + (MTS_ele_num / 2 - 0.5) * d;
end