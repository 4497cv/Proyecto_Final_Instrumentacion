close all; clc;

% LM35 Temperature Sensor Frequency Response
temp = 0:0.5:100;
slope_min = 9.8e-3;
slope_typ = 10e-3; %[mv/C]
slope_max = 10.2e-3;
offset = 0;
vout_min = slope_min*temp+offset; % y = 10mV*T + 0;
vout_typ = slope_typ*temp+offset; % y = 10mV*T + 0;
vout_max = slope_max*temp+offset; % y = 10mV*T + 0;
% Frequency Response
sensor = tf([1.22963],[1 1.22963]);
display(sensor);
fprintf("bandwidth = [0, %.2f] rad/s = [0, %.2f] Hz\n ", bandwidth(sensor),bandwidth(sensor)/(2*pi));

time = 0:0.1:8;
y_termal = 1-0.8*exp(-1.22963*time);
figure;
subplot(3,1,1);
plot(temp,vout_typ,'-r');
hold on;
plot(temp,vout_min,'--b');
hold on;
plot(temp,vout_max,'--b');
hold off;

xlabel('Temperatura');
ylabel('Voltaje de salida (Vout)');
grid on;
xlim([20 50]);
subplot(3,1,2);
plot(time,y_termal,'--r');
title('Respuesta al Escalón');
xlabel('Tiempo (segundos)');
ylabel('Amplitud');

subplot(3,1,3);
impulse(sensor);




