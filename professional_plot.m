%% PROFESSIONAL PUBLICATION-QUALITY FIGURE
G = tf(1,[1 2 5]); C = pid(10,20,3);
T = feedback(C*G,1);
t = 0:0.01:8;
[y_ol,~] = step(G,t);
[y_cl,~] = step(T,t);
info = stepinfo(T);

fig = figure('Color',[0.05 0.07 0.1],'Position',[50 50 1100 650]);

ax = axes('Color',[0.08 0.1 0.15],'XColor',[0.6 0.7 0.8],'YColor',[0.6 0.7 0.8], ...
    'GridColor',[0.2 0.25 0.3],'GridAlpha',0.5);
hold on; grid on;

plot(t, y_ol, 'Color',[1 0.4 0.3], 'LineWidth',2, 'LineStyle','--')
plot(t, y_cl, 'Color',[0.2 0.8 1], 'LineWidth',2.5)
yline(1,  'Color',[0.9 0.9 0.9], 'LineWidth',1, 'LineStyle','--')
yline(1.1,'Color',[1 0.8 0.2], 'LineWidth',1, 'LineStyle',':')

% Annotations
xline(info.SettlingTime,'Color',[0.5 1 0.5],'LineWidth',1)
text(info.SettlingTime+0.05, 0.3, sprintf('Ts=%.2fs',info.SettlingTime), ...
    'Color',[0.5 1 0.5], 'FontSize',10, 'FontName','Monospace')

xlabel('Time (seconds)','Color',[0.8 0.8 0.9],'FontSize',13)
ylabel('Altitude (meters)','Color',[0.8 0.8 0.9],'FontSize',13)
title('Drone Altitude Control — PID Closed-Loop vs Open-Loop', ...
    'Color',[0.95 0.95 1],'FontSize',15,'FontWeight','bold')
leg = legend('Open-Loop (No Control)','PID Controller','Target','10% Limit', ...
    'TextColor',[0.8 0.8 0.9],'Location','southeast');
leg.Color = [0.1 0.12 0.18];
leg.EdgeColor = [0.2 0.25 0.35];

xlim([0 8]); ylim([-0.05 1.3])
exportgraphics(fig, 'drone_response.png', 'Resolution', 300)%% DISTURBANCE REJECTION ANALYSIS
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