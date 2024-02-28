function Ans = Q2bit(phi)
    global g1 g2 h1 h2 h3 u1 u2 u3
    global MTS_ele_num
    % The parameters passed in are all diagonal matrices.
    phi = diag(phi);

    Phase = [];

    phi11 = diag(mod(angle(phi), 2 * pi));
    
    for i = 1 : MTS_ele_num * MTS_ele_num
        if (phi11(i)) < pi / 2
            Phase =[Phase; exp(deg2rad(0) * 1i)];

        elseif  (phi11(i)) < pi
            Phase = [Phase; exp(deg2rad(90) * 1i)];

        elseif (phi11(i)) < pi / 2 * 3
            Phase =[Phase; exp(deg2rad(180) * 1i)];

        else
            Phase =[Phase; exp(deg2rad(270) * 1i)];
        end
    end

    Ans = Phase;
end

