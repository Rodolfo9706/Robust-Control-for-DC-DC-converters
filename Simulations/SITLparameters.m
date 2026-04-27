
%system parameters
E  = 12;
C  = 1200*10^-6  ;
R  = 25 ;
L  = 1*10^-3 ;
vd = -5;


%{
E  = 12;
C  = 2610*10^-6    ;%470*10^-6  ;%220*10^-6
R  = 25 ; %10
L  = 2010*10^-6 ;
vd = -8;
%}

L1 = 0.91;
M = 1;
% Robust control smulacion

%kr1 = 100 ;
%kr2 = 50;

% Robust control SITL
 
%kr1 = 10000; %1200;%900;
%kr2 = 980;%350;800;
%-- 11/10/2023 01:49 p. m. --%

% Robust control SITL
 
%kr1 = 3000; %1200;%900;
%kr2 = 10;%350;800;
%-- 11/10/2024 01:49 p. m. --%

kr1 = 0; %1200;%900;
kr2 = 0;%350;800;

% PI non linear control parameters
delta1 = 0.022; %1;
delta2 = 0.012;%0.012;
kp = 0.0019;
id = vd*((vd - E)/(R*E));

%Fractional control PI parameter
kp1 = 0.0019 ;
k1 = 0.022 ;

%PI sliding mode controller
kp2 = 0.1 ;
k2 = 10 ;

% Input - output linearization method based controller

kp3 = 0.1 ;
k3 = 10 ;
kl =  1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



