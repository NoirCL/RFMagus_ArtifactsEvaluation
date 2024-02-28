%% Clearing the window and variable area.
clc;
clear;
close all;

%% Adding the function path.
addpath('funtion_store')

%% The predefinition of parameters.

% Definition of parameters for Spacing between elements., frequency, speed of light, and wavelength.
global d;
global f c;
global lambda;

% Parameters for path attenuation coefficient.
% global BB;

% Definition of positions for transmitter and receiver.
global Tx;
global Rx;

% Definition of x, y, z coordinates for metasurface 1.
global cor_z;
global  cor_ris1_x;
global  cor_ris1_y; 
global  cor_ris1_z;

% Definition of x, y, z coordinates for metasurface 2.
global  cor_ris2_x;
global  cor_ris2_y;
global  cor_ris2_z;

% Definition of x, y, z coordinates for metasurface 3.
global  cor_ris3_x;
global  cor_ris3_y;
global  cor_ris3_z;

% Definition of x, y, z coordinates for metasurface 4.
global  cor_ris4_x;
global  cor_ris4_y;
global  cor_ris4_z;

% Definition of the central coordinates for metasurface 1.
global center_ris1_x;
global center_ris1_y;
global center_ris1_z;

% Definition of the central coordinates for metasurface 2.
global center_ris2_x;
global center_ris2_y;
global center_ris2_z;

% Definition of the central coordinates for metasurface 3.
global center_ris3_x;
global center_ris3_y;
global center_ris3_z;

% Definition of the central coordinates for metasurface 4.
global center_ris4_x;
global center_ris4_y;
global center_ris4_z; 

% Definition of channel parameters.
global g1 g2 g3 g4
global u1 u2 u3 u4
global h12 h13 h14 h23 h24 h34
global Los

% Definition of some additional parameters in channel modeling.
global dis_g1
global dis_g2
global dis_u1
global dis_u2
global dis_u3
global dis_h1
global dis_h2
global dis_h3

global Nx % Number of elements on the x-axis.
global Ny % Number of elements on the y-axis. 
global flag_need_dir_graph;  % Flag indicating whether a radiation pattern plot is required.
global flag_ris_num % Number of metasurfaces.
global MTS_ele_num % Number of elements on one side of the square metasurface.

MTS_ele_num = 16;
f = 5.25*1e9;
c = 3*1e8; 
lambda = c/f; 

d = 0.0195;

Nx = MTS_ele_num;
Ny = MTS_ele_num;

%% Definition of parameters for the transmission power, transmit gain, and receive gain of the antenna used.
global Pt % transmission power
global Gt % transmit gain
global Gr % receive gain
Pt = db2pow(15);
Gt = db2pow(13);
Gr = db2pow(13);

%% Definition of metasurface coordinates.
% shift = 5; % Initial offset of metasurface position.

% Placement angle of the metasurface.
% We define the angle at which the metasurface operates vertically downwards as o degrees.
% We define the rotation direction of the metasurface as counterclockwise.
p1 = 0;
p2 = 180;
p3 = 0;
p4 = 180;

% Definition of the position of the central element in the metasurface.
% We define the valid position of the central element in the metasurface as coordinates greater than 0 along the x, y, and z axes.
% If the x, y, and z coordinates of the central element in the metasurface are all defined as 0, then the definition of this metasurface position is invalid.
x1 = 0;
y1 = 0;
z1 = 0;

x2 = 0;
y2 = 0;
z2 = 0;

x3 = 0;
y3 = 0;
z3 = 0;

x4 = 0;
y4 = 0;
z4 = 0;

x1 = 6; 
y1 = 6;
z1 = 1;

x2 = 7;
y2 = 4;
z2 = 1;

% x3 = 8;
% y3 = 6;
% z3 = 1;
% 
% x4 = 9;
% y4 = 4;
% z4 = 1;

set_4_ris(x1, y1, z1, p1, x2, y2, z2, p2, x3, y3, z3, p3, x4, y4, z4, p4);

% Definition of the positions of Tx and Rx.
Tx = [5, 5, 1];
Rx = [10 ,5, 1];

ddraw

%% Calculate the channels between metasurfaces, Tx and metasurfaces, and metasurfaces and Rx.
% We define the channel according to the following symbols.
% g1 is the channel from Tx to metasurface 1,
% g2 is the channel from Tx to metasurface 2,
% g3 is the channel from Tx to metasurface 3,
% g4 is the channel from Tx to metasurface 4.
% u1 is the channel from metasurface 1 to Rx,
% u2 is the channel from metasurface 2 to Rx,
% u3 is the channel from metasurface 3 to Rx,
% u4 is the channel from metasurface 4 to Rx.
% h12 is the channel from metasurface 1 to metasurface 2,
% h13 is the channel from metasurface 1 to metasurface 3,
% h14 is the channel from metasurface 1 to metasurface 4,
% h23 is the channel from metasurface 2 to metasurface 3,
% h24 is the channel from metasurface 2 to metasurface 4,
% h34 is the channel from metasurface 3 to metasurface 4.

% Definition of the common channel attenuation K value in  Rayleigh factor.
% Here is the definition of the Rayleigh factor.
K_dB_channel = 10; 
K_dB_Los = 0.1;
% Here is the definition of the Friis free space channel fading factor.
% For simplicity of calculation, we have chosen typical values of fading factors commonly seen in indoor environments.
N_g1 = 2;
N_g2 = 2;
N_g3 = 2;
N_g4 = 2;
N_u1 = 2;
N_u2 = 2;
N_u3 = 2;
N_u4 = 2;
N_h12 = 2;
N_h13 = 2;
N_h14 = 2;
N_h23 = 2;
N_h24 = 2;
N_h34 = 2;
N_Los = 2;

% Channel calculation.
[g1, g2, g3, g4,...
     u1, u2, u3, u4, ...
     h12, h13, h14, h23, h24, h34, ... 
     Los] = ccal_channel_multi_rx(K_dB_channel, K_dB_Los, ...
                               N_g1, N_g2, N_g3, N_g4, ...
                               N_u1, N_u2, N_u3, N_u4, ...
                               N_h12, N_h13, N_h14, N_h23, N_h24, N_h34,...
                               N_Los);



% Should a radiation pattern be plotted?
flag_need_dir_graph  = 1;

%% Determine the number of metasurfaces.
cal_mts_number(p1, p2, p3, p4);

%% Redundant channel deletion.
% Sometimes, we may not define all four metasurfaces to work simultaneously. Therefore, when a certain metasurface is not present, 
% the corresponding channels related to that metasurface should be removed from the system.
ban_channel();

%% discrete Alternate optimization.
[phi1, phi2, phi3, phi4, phi1_d, phi2_d, phi3_d, phi4_d] = AO_4_ris_discrete;

%% Plotting the radiation pattern.
draw_beam(phi1, phi2, phi3, phi4)

%% Display the codebook of metasurface phase configurations.
drawCodeBook(phi1_d, phi2_d, phi3_d, phi4_d)