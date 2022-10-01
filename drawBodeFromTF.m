close all;
s = tf('s');
L = 20e-3;
R = 1;
Ps = 1/(L*s+R);
bode(Ps)
grid on;