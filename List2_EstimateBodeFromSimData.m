close all;
%% 実験データよりボード線図を推定する
x = out.simVoltage.Data;
y = out.simCurrent.Data;
x = reshape(x, [], 1);
y = reshape(y, [], 1);

Ts = out.simVoltage.Time(2)-out.simVoltage.Time(1);
Fs = 1/Ts;

[txy,Freq_fromData] = tfestimate(x,y,[],[],[],Fs);
Gain_fromData = 20*log10(abs(txy));
Phase_fromData = angle(txy) * 180 / pi;


% 伝達関数ベースでボード線図を描画する
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

%% 推定したボード線図と伝達関数ベースのボード線図を重ねる
tiledlayout('flow')
nexttile;
semilogx(Freq_b, Gain_b);
hold on; grid on;
semilogx(Freq_fromData, Gain_fromData);
axis([0.1, 100, -30, 0])

nexttile;
semilogx(Freq_b, Phase_b);
hold on; grid on;
semilogx(Freq_fromData, Phase_fromData);
axis([0.1, 100, -90, 0])