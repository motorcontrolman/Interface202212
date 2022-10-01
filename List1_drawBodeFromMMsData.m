close all;

% 実測データをワークスペースに定義
Freq = [1, 5, 10];          % 交流周波数[Hz]
Vamp = [1, 1, 1];           % 各周波数における電圧振幅(Vpeak)

Iamp = [0.99, 0.85, 0.62];  % 各周波数における電流振幅(Ipeak)
Phase = [-8.2, -31.7, -50.8]; % 各周波数における位相差(deg)

% ゲイン(dB) の算出
Gain = 20 * log10( Iamp ./ Vamp ); %

% 伝達関数を定義しボード線図を算出
s = tf('s');
L = 2e-2;
R = 1;
Ps = 1/(L*s+R);
[Mag_b, Phase_b, w_b] = bode(Ps);
Mag_b = reshape(Mag_b, [], 1);
Phase_b = reshape(Phase_b, [], 1);
w_b = reshape(w_b, [], 1);

Gain_b = 20*log10(Mag_b);
Freq_b = w_b/(2*pi);

% 実測データとボード線図を重ねる
tiledlayout('flow')
nexttile;
semilogx(Freq_b, Gain_b);
hold on; grid on;
semilogx(Freq, Gain, 'ro');

nexttile;
semilogx(Freq_b, Phase_b);
hold on; grid on;
semilogx(Freq, Phase, 'ro');