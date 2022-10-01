close all;
load expResult; %実機結果をMATLABに取り込み
plot(expResult.Time, expResult.Current);
hold on; grid on;
plot(out.simCurrent, LineWidth = 1.5);
axis([-0.4, 1.0, -0.5, 3.0])