% Assignment 1 - Macroeconomics I
% ===============================

% Main script:
% Run this code to compute the steady-state and dynamics of the model

% 1) GNU Octave/MATLAB configuration
% ----------------------------------

clear
clc
cd(fileparts(mfilename('fullpath')));


% 2) Assigning parameter values
% -----------------------------

alpha = 0.36;
beta  = 0.99;
delta = 0.025;
sigma = 1;
phi   = 0.5;
rhoz  = 0.95;
sigz  = 0.007;
rhog  = 0.95;
sigg  = 0.005;
phiTb = 0.25;
zbar  = 1;
chi = 6.1584; % l is calibrated

param = [alpha beta delta sigma phi rhoz sigz rhog sigg phiTb zbar chi];

% 3) Computing non-stochastic steady-state
% ----------------------------------------

% Seed
x0 = 1/3; % Labor

% Root finding algorithm

l_ss = fsolve(@(z) assignment1_ss(z, param), x0);

% Steady-state computation
  % Interest rates
    rb_ss = 1/beta - 1;
    rk_ss = rb_ss + delta;
  % Capital
    k_ss = (alpha*zbar/rk_ss)^(1/(1-alpha)) * l_ss;
  % Wage
    w_ss = (1-alpha)*zbar*(k_ss/l_ss)^alpha;
  % Production, public spending, public debt and consumption
    y_ss = zbar*k_ss^alpha*l_ss^(1-alpha);
    g_ss = 0.1*y_ss;
    b_ss = 2.4;
    c_ss = y_ss - delta*k_ss - g_ss;
  % Taxes (government budget in SS: T = rb*b + g; with rb=0, T=g)
    T_ss = g_ss;
  % Capital ratio
    kratio_p = k_ss/y_ss;

% 4) Computing public spending and TFP dynamics
% ---------------------------------------------

% Rename structural parameters (so Dynare doesn't shadow them)
alpha_p = alpha;  beta_p = beta;  delta_p = delta;
sigma_p = sigma;  phi_p = phi;    chi_p = chi;
rhoz_p = rhoz;    sigz_p = sigz;  rhog_p = rhog;
sigg_p = sigg;    phiTb_p = phiTb; zbar_p = zbar;

if beta == 1
  dynare assignment1_nobonds.mod noclearall
else
  dynare assignment1_bonds.mod noclearall
end
