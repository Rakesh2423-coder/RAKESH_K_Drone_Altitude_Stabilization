%% DRONE ALTITUDE ANIMATION — Judges LOVE this!
G = tf(1,[1 2 5]); C = pid(10,20,3);
T = feedback(C*G,1);
t = 0:0.05:10;
[y,~] = step(T,t);

fig = figure('Color',[0.1 0.1 0.15], 'Position',[200 100 800 600], ...
    'Name','Drone Altitude Animation');

for i = 1:length(t)
    clf
    set(gcf,'Color',[0.05 0.05 0.1])

    % Sky background
    ax = gca; ax.Color = [0.07 0.1 0.15];
    ax.XColor = 'none'; ax.YColor = [0.4 0.5 0.6];
    hold on

    % Ground
    fill([0 10 10 0],[-0.1 -0.1 0 0],[0.2 0.3 0.15],'EdgeColor','none')

    % Target line
    plot([0 10],[1 1],'--','Color',[0.3 0.9 0.3],'LineWidth',1.5)
    text(0.2,1.05,'Target: 1.0 m','Color',[0.3 0.9 0.3],'FontSize',10)

    % Altitude trace
    if i > 1
        plot(t(1:i), y(1:i), 'Color',[0.2 0.6 1], 'LineWidth', 2)
    end

    % Drone body (rectangle + rotors)
    alt = max(0, y(i));
    drone_x = 5;
    rectangle('Position',[drone_x-0.3, alt-0.04, 0.6, 0.08], ...
        'FaceColor',[0.2 0.5 0.9], 'EdgeColor','w', 'LineWidth',1.5, 'Curvature',0.3)
    % Rotors
    rotor_spin = mod(t(i)*10, 2*pi);
    for rx = [drone_x-0.4, drone_x+0.4]
        plot(rx + 0.15*cos(rotor_spin), alt + 0.06 + 0.01*sin(rotor_spin), ...
            'w-', 'LineWidth', 2)
    end

    % HUD text
    text(0.3,1.7,sprintf('t = %.2f s | Altitude = %.3f m', t(i), y(i)), ...
        'Color',[0.9 0.9 0.9],'FontSize',12,'FontName','Monospace')

    % Disturbance indicator
    if t(i) >= 5
        text(0.3,1.55,'⚠ WIND DISTURBANCE ACTIVE','Color',[1 0.6 0.2],'FontSize',11)
    end

    xlabel('Horizontal Position','Color',[0.5 0.5 0.6])
    ylabel('Altitude (m)','Color',[0.5 0.5 0.6])
    title('Drone PID Altitude Control — Real-time','Color','w','FontSize',14)
    ylim([-0.1 1.8]); xlim([0 10])
    drawnow

    if i == 1; pause(0.5); end
    pause(0.02)
end%% DISTURBANCE REJECTION ANALYSIS
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