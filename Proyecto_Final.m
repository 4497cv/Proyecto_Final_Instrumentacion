close all; clc;

% LM35 Temperature Sensor Frequency Response
temp = 0:1:100;
slope_min = 9.8e-3;
slope_typ = 10e-3; %[mv/C]
slope_max = 10.2e-3;
offset = 0;
vout_min = slope_min*temp+offset; % y = 10mV*T + 0;
vout_typ = slope_typ*temp+offset; % y = 10mV*T + 0;
vout_max = slope_max*temp+offset; % y = 10mV*T + 0;
% Frequency Response
sensor = tf([1],[1 1.25964e7 3.96673e13]);
display(sensor);
bandwidth(sensor)/(2*pi);

figure;
subplot(3,1,1);
plot(temp,vout_typ,'-r');
hold on;
plot(temp,vout_min,'--b');
hold on;
plot(temp,vout_max,'--b');
hold off;

xlabel('Temperature');
ylabel('Vout');
grid on;
subplot(3,1,2);
step(sensor);
title('Step response');
grid on;
subplot(3,1,3);
bodemag(sensor,'r');
title('Frequency response');
grid on;

