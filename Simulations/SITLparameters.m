%% =====================================================================
%  SITLparameters.m
%  Parameters for the software-in-the-loop (SIL) simulations of the
%  inverting buck-boost converter and the controllers compared in the paper.
%
%  Run this script before opening the Simulink model.
%  Units: SI (V, F, Ohm, H, A).
%  ======================================================================

%% ---------------------------------------------------------------------
%  Converter parameters (active configuration)
%  ---------------------------------------------------------------------
E  = 12;            % Source voltage [V]
C  = 1200*10^-6;    % Output capacitance [F]
R  = 25;            % Nominal load resistance [Ohm]
L  = 1*10^-3;       % Inductance [H]
vd = -5;            % Output-voltage reference [V] (negative: inverting converter)

%  Alternative configuration (kept for reference)
%{
E  = 12;            % Source voltage [V]
C  = 2610*10^-6;    % Output capacitance [F]   (other values tested: 470e-6, 220e-6)
R  = 25;            % Load resistance [Ohm]    (other value tested: 10)
L  = 2010*10^-6;    % Inductance [H]
vd = -8;            % Output-voltage reference [V]
%}

%% ---------------------------------------------------------------------
%  Duty-ratio saturation (proposed controller)
%  ---------------------------------------------------------------------
L1 = 0.91;          % Start of the smooth upper saturation (ell in the paper)
M  = 1;             % Upper bound of the duty ratio

%% ---------------------------------------------------------------------
%  Proposed robust controller - gains
%  ---------------------------------------------------------------------
%  Averaged-model simulation
%kr1 = 100;
%kr2 = 50;

%  SIL tuning - 11/10/2023
%kr1 = 10000;       % other values tested: 1200, 900
%kr2 = 980;         % other values tested: 350, 800

%  SIL tuning - 11/10/2024
%kr1 = 3000;        % other values tested: 1200, 900
%kr2 = 10;          % other values tested: 350, 800

%  Active values
kr1 = 0;            % Current-loop gain k1    (other values tested: 1200, 900)
kr2 = 0;            % Voltage-loop gain k2    (other values tested: 350, 800)

%% ---------------------------------------------------------------------
%  Nonlinear PI-type controller
%  ---------------------------------------------------------------------
delta1 = 0.022;     % Delta_1                 (other value tested: 1)
delta2 = 0.012;     % Delta_2
kp     = 0.0019;    % Proportional gain
id     = vd*((vd - E)/(R*E));   % Equilibrium inductor current [A]

%% ---------------------------------------------------------------------
%  Fractional-order PI controller
%  ---------------------------------------------------------------------
kp1 = 0.0019;       % Proportional gain
k1  = 0.022;        % Integral gain

%% ---------------------------------------------------------------------
%  PI sliding-mode controller
%  ---------------------------------------------------------------------
kp2 = 0.1;          % Proportional gain
k2  = 10;           % Integral gain

%% ---------------------------------------------------------------------
%  Input-output linearization controller
%  ---------------------------------------------------------------------
kp3 = 0.1;          % Proportional gain of the current reference
k3  = 10;           % Integral gain of the current reference
kl  = 1;            % Current-loop gain
