// Problem Set 1 - Fiscal policy in the RBC model (without bonds)

// AUXILIAR SCRIPT
// This script is NOT meant to be run. Instead, RUN "assigment1main.m" SCRIPT

var c l k b y w rk T z g; // rb excluded
varexo eps_z eps_g;

parameters alpha beta delta sigma phi chi rhoz sigz rhog sigg phiTb;
parameters zbar lbar rkbar rbbar ybar kbar wbar gbar bbar Tbar cbar kratio;

// Structural parameters (from workspace via _p suffix to avoid shadowing)

alpha = alpha_p;
beta = beta_p;
delta = delta_p;
sigma = sigma_p;
phi = phi_p;
rhoz = rhoz_p;
sigz = sigz_p;
rhog = rhog_p;
sigg = sigg_p;
phiTb = phiTb_p;
zbar = zbar_p;
chi = chi_p;

// Steady state

lbar = l_ss;
rbbar = rb_ss;
rkbar = rk_ss;
kbar = k_ss;
wbar = w_ss;
ybar = y_ss;
gbar = g_ss;
bbar = b_ss;
cbar = c_ss;
Tbar = T_ss;
kratio = kratio_p;

// Model
model;

  sigma*c(+1) = sigma*c + beta*rkbar*rk(+1);
  w = z + alpha*k(-1) - alpha*l;
  rk = z + (alpha - 1)*k(-1) + (1-alpha)*l;
  w = sigma*c + phi*l;
  y = z + alpha*k(-1) + (1-alpha)*l;
  ybar*y = cbar*c + kbar*k - (1-delta)*kbar*k(-1) + gbar*g;
  bbar*b = bbar*b(-1) + gbar*g - Tbar*T;
  T = phiTb*b(-1);
  z = rhoz*z(-1) + eps_z;
  g = rhog*g(-1) + eps_g;

end;

// Shocks

shocks;
  var eps_z; stderr 0.01;
  var eps_g;  stderr 0.01;
end;

// Initial values

initval;
  c  = 0;
  l  = 0;
  k  = 0;
  b  = 0;
  y  = 0;
  w  = 0;
  rk = 0;
  T  = 0;
  z  = 0;
  g  = 0;
end;

steady;

// Solve and simulate

check;
set(0, 'DefaultFigurePosition', [100 100 1200 600]); // Graphs output configuration
stoch_simul(order=1, irf=150) y l c k b T g;



