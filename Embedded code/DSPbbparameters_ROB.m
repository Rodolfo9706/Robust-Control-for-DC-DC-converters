%% =====================================================================
%  DSPbbparameters_ROB.m
%  Parameters for the hardware implementation of the robust controller
%  on the TI LaunchXL-F28379D (C2000) DSP, inverting buck-boost converter.
%
%  Run this script before building and deploying
%  read_ADC_scribe_PWM_ROB_1ver.slx.
%  Units: SI (V, F, Ohm, H, A, s).
%  ======================================================================

%% ---------------------------------------------------------------------
%  Converter parameters
%  ---------------------------------------------------------------------
E  = 5;             % Source voltage [V]
C  = 2610*10^-6;    % Output capacitance [F]   (other values tested: 470e-6, 220e-6)
R  = 1000000;       % Load resistance [Ohm]    (other value tested: 10)
L  = 2010*10^-6;    % Inductance [H]

x2d = -6;           % Output-voltage reference [V] (negative: inverting converter)

%% ---------------------------------------------------------------------
%  Nonlinear PI-type controller (not used in this model)
%  ---------------------------------------------------------------------
%delta1 = 0.2;
%delta2 = 0.1;

%% ---------------------------------------------------------------------
%  Robust controller - gains
%  ---------------------------------------------------------------------
%  Previous control law (October 2024) - active values
k1 = 3000;          % Current-loop gain   (other values tested: 2000, 8000;
                    %  0.925 in simulation; 0.2 in an earlier DSP version)
k2 = 10;            % Voltage-loop gain   (other values tested: 8000, 5, 16;
                    %  20 in an earlier DSP version)

%  New control law
%k1 = 0;            % Current-loop gain   (same reference values as above)
%k2 = 0;            % Voltage-loop gain   (same reference values as above)

%  Additional gain of an earlier DSP version
%k = 1000;          % other value tested: 10000

%% ---------------------------------------------------------------------
%  Other settings
%  ---------------------------------------------------------------------
%vd = -10;          % Alternative output-voltage reference [V]
Ts = 0.01;          % Sample time [s]
%id = vd*((vd - E)/(R*E));   % Equilibrium inductor current [A]
