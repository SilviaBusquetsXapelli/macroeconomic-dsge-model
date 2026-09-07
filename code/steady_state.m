
% Auxiliar script from "assignment1main.m" to compute steady-state
% ================================================================

function f = assignment1_ss (z, p)
  % Unpacking parameters
    alpha = p(1); beta = p(2); delta = p(3); sigma = p(4); phi = p(5);
    rhoz = p(6); sigz = p(7); rhog = p(8); sigg = p(9); phiTb = p(10);
    zbar = p(11); chi = p(12);

  % Seed
    l_ss = z;

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

  % Check function
    f = c_ss^sigma*chi*l_ss^phi - w_ss;
end
