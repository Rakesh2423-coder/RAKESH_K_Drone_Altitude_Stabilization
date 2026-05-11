%% ROBUSTNESS: Test with plant uncertainty (+/-30% gain variation)
G_nom = tf(1, [1 2 5]);          % Nominal plant
C = pid(10, 20, 3);

t = 0:0.01:8;
gains = [0.7, 1.0, 1.3];          % ±30% plant gain variation
colors = {'b-', 'g-', 'r-'};

figure('Color','w','Position',[100 100 900 500])
hold on
for i = 1:3
    G_var = gains(i) * G_nom;          % Perturbed plant
    T_var = feedback(C*G_var, 1);
    [y,~] = step(T_var, t);
    plot(t, y, colors{i}, 'LineWidth', 2)
end
yline(1,'k--'); yline(1.1,'m:')
legend('Gain -30%', 'Nominal', 'Gain +30%', 'Target', 'Overshoot Limit')
xlabel('Time (s)'); ylabel('Altitude (m)')
title('Robustness Test: ±30% Plant Gain Uncertainty')
grid on

%% If all 3 curves satisfy specs → ROBUST CONTROLLER!%% DISTURBANCE REJECTION ANALYSIS
G = tf(1, [1 2 5]);
C = pid(10, 20, 3);

% Transfer functions for disturbance analysis
% Reference → Output
T_ref = feedback(C*G, 1);

% Disturbance → Output (input disturbance)
% T_d = G / (1 + C*G)
T_dist = feedback(G, C);

% Simulation timeline
t = 0:0.01:15;
r = ones(size(t));                          % Step reference
d = 0.5 * (t >= 5);                       % Wind gust at t=5s

% Simulate both effects using superposition (linear system)
[y1, ~] = lsim(T_ref, r, t);              % Reference tracking
[y2, ~] = lsim(T_dist, d, t);             % Disturbance effect
y_total = y1 + y2;                          % Total output

% Plot
figure('Color','w','Position',[100 100 900 500])
subplot(2,1,1)
plot(t, y_total, 'b-', 'LineWidth', 2); hold on
plot(t, y1, 'g--', 'LineWidth', 1.5)
yline(1,'k--','LineWidth',1)
xline(5,'r--','Wind Gust','LineWidth',1.5)
ylabel('Altitude (m)'); title('Altitude with Wind Disturbance at t=5s')
legend('Actual Altitude','Without Disturbance','Target')
grid on; xlim([0 15]); ylim([0.7 1.2])

subplot(2,1,2)
plot(t, d, 'r-', 'LineWidth', 2)
ylabel('Wind (m/s)'); xlabel('Time (s)')
title('Disturbance Signal (Wind Gust)')
grid on; xlim([0 15])

%% Measure recovery time after disturbance
idx5 = find(t >= 5, 1);
deviation = max(abs(y_total(idx5:end) - 1));
recovery_idx = find(abs(y_total(idx5:end) - 1) < 0.02, 1);
recovery_time = t(idx5 + recovery_idx - 1) - 5;

fprintf('Max deviation from disturbance: %.4f m\n', deviation)
fprintf('Recovery time after disturbance: %.2f s\n', recovery_time)