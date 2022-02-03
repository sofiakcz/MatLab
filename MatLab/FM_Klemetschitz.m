fs = 500e3;
Ts = 1/fs;
t= 0:Ts:1-Ts;

% generate Waves:
% wave 1 -> carrier (Träger)

fc = 20000;	%Hz
uc = cos(2 * pi * fc * t);

% wave 2 -> baseband (Audiosignal)

fb= 2000; %Hz
ub=cos(2 * pi * fb * t);

% Modulation
% delta_f = 4800;
eta = 3;	% Modulationsindex eta <1 -> Schmalband-FM (NBFM)
delta_f = eta * fb;
int_ub = 1/fs * cumsum(ub);
ufm = cos(2 * pi * fc * t +2 * pi * delta_f * int_ub);

% Plot Time Domain (Zeitbereichsdarstellung)

figure(1);
subplot(2, 1, 1);	% 2 rows, 1 column, 1st row
plot(t,ub ,t,ufm), grid on;
axis([0.0 0.001 -2.2 2.2]);	% Achsenskalierung ändern axis([xbeginn xend ybegin yend])
title('time domain')
xlabel('time');
ylabel('voltage');
legend('FM signal','baseband');

F = fft(ufm);	% fourier coefficient (=amplitude) at each frequrncy
n = length(ufm);	% number of samples
f = (0 : n-1)*(fs/n);	% vector of frequencies
volt = 2/n * abs(F);	% absolute value of amplitude

% Plot Frequency Domain (Frequenzbereichsdarstellung)

subplot(2, 1, 2);	% 2nd row
plot(f, volt);	% volt(f)
grid on;
axis([0 100e3 0 1.2]);
title('frequency doamin')
xlabel('frequency');
ylabel('voltage');