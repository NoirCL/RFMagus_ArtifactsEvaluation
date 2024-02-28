function [actual] = draw_ris_dir(R, C, index)
    % lambda: Wavelength.
    % d: Inter-element spacing (i.e., element size), in meters.
    % R: Distance between the feed source and the planar array, in meters.
    % Nx: Number of elements along the x-axis.
    % Ny: Number of elements along the y-axis.
    
    global d f c lambda
    global MTS_ele_num

    Nx = MTS_ele_num; 
    Ny = MTS_ele_num; 
    NA = 181; % Sampling rate.
    NE = 181;
    
    %% Convert input to radians.
    C=reshape(C,MTS_ele_num,MTS_ele_num).';
    C=angle(C);
    
    position_x=Nx*d/2+0;
    position_y=Ny*d/2; % Feed source position.
    D0=zeros(Ny,Nx);
    
    for i=1:Ny
        for j=1:Nx
            dy=d/2+(i-1)*d-position_y;
            dx=d/2+(j-1)*d-position_x;
            D0(i,j)=sqrt(dy^2+dx^2+R^2);
        end
    end
    
    D=2*pi/lambda*D0; % Actual phase of the transmitted beam.
    
    D = 0;
    actual=C+D;
    actual=mod(actual,2*pi);
    actual=actual*lambda/(2*pi);
    
    phi = linspace(0,pi,NA);
    theta = linspace(-pi/2,pi/2,NE);

    aa = d/2:d:(Ny-1)*d+d/2;
    DD1 = repmat(aa',1,Nx);
    bb = d/2:d:(Nx-1)*d+d/2;
    DD2 = repmat(bb,Ny,1);
    DD = DD1+sqrt(-1).*DD2;
    
    for jj = 1:length(phi)
        for ii = 1:length(theta)
            pattern0 = exp(sqrt(-1)*2*pi/lambda*(sin(theta(ii))*cos(phi(jj))*real(DD)+sin(theta(ii))*sin(phi(jj))*imag(DD)-actual));
            pattern(jj,ii) = sum(sum(pattern0));  
        end
    end
    
    pattern_dbw = [];
    max_p=max(max(abs(pattern) ) ) ;
    pattern_dbw=20*log10(abs(pattern) /max_p + eps);
    
    number=find(pattern_dbw<-50);
    g_temp=-50+unifrnd(-1,1,1,length(number) );
    
    for ii=1:length(number)
        pattern_dbw(number(ii)) = g_temp(ii) ;
    end
    
    figure('Position', [100, 100, 1200, 500]);
    subplot(1,2,1);
    mesh(theta*180/pi,phi*180/pi,pattern_dbw);
    hold on
    xlabel('Azimuth angle (deg)');
    ylabel('Elevation angle (deg)');
    view([0, 90]);
    subtitle("2D radiation pattern")

    for n=1:length(theta)
        for m=1:length(phi)
            if n==91
                temp1(m)=pattern_dbw(n,m);
            end
        end
    end

    % subplot(1,2,2);
    % plot(theta*180/pi,temp1);
    % xlabel('Azimuth angle (deg)');
    % ylabel('SNR (dB)');

    subplot(1,2,2);
    subtitle("3D radiation pattern")
    theta2 = -90:1:90;
    phi2 = -90:1:90;
    patternCustom(pattern_dbw,theta2,phi2);
end

