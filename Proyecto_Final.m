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
sensor = tf([0.0204937],[1 0.0204937]);
display(sensor);
fprintf("bandwidth = [0, %.2f] rad/s = [0, %.4f] Hz\n ", bandwidth(sensor),bandwidth(sensor)/(2*pi));

time = 0:0.1:480;
y_termal = 1-0.8*exp(-0.0204937*time);
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

title('Respuesta al escalón');
xlabel('Tiempo (segundos)');
ylabel('Amplitud');

subplot(3,1,3);
step(sensor);

%% Caudalímetro
figure;
Vout = 0:1:10;
Q = -0.2789*(Vout.^4)+7.9169*(Vout.^3)-68.083*(Vout.^2)+457.79*Vout;

Kc = 0.13565823;
sensor2 = tf([Kc],[1]);

subplot(3,1,1);
plot(Vout,Q,'--r');
title('Relación entre el caudal y tensión del caudalimetro');
xlabel('Vc(v)');
ylabel('Q (cm^3/min)');
grid on;

Q = [1.33:0.01:2.0];
Vc = 0.13565823*Q;
subplot(3,1,2);
plot(Q,Vc,'-r');
title('Relación entre el caudal y tensión del caudalimetro');
ylabel('Vc(v)');
xlabel('Q (cm^3/seg)');
grid on;


subplot(3,1,3);
step(sensor2);
ylim([0.10 0.14]);

%% Moisture Sensor
resolution = 0:1:255;
c1 = -2.0468;
c2 = 0.5872;
c3 = -4.0845e-4;
Vout = c1+(c2*resolution)+c3*(resolution.^2);
sensor3 = tf([0.124282],[1 0.124282]);
figure;
subplot(3,1,1);
plot(resolution,Vout,'--r');
ylim([0 100]);
title('Gráfica de Humedad Relativa');
xlabel('Lectura del sensor(8-bit)');
ylabel('Humedad relativa (%RH)');
subplot(3,1,2);
RH = 0:1:100;
sensor_val = 1.98*RH;
plot(RH,sensor_val,'-r');
title('Gráfica de Humedad Relativa');
ylabel('Sensor val');
xlabel('Humedad relativa (%RH)');

subplot(3,1,3);
bodemag(sensor3);
fprintf("bandwidth = [0, %.2f] rad/s = [0, %.4f] Hz\n ", bandwidth(sensor3),bandwidth(sensor3)/(2*pi));

Vout = c1+(c2*resolution)+c3*(resolution.^2);

