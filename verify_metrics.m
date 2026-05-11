%% VERIFY ALL PERFORMANCE METRICS
T = feedback(pid(10,20,3)*tf(1,[1 2 5]),1);
info = stepinfo(T, 'SettlingTimeThreshold', 0.02); % 2% criterion

%% Overshoot (must be < 10%)
OS = info.Overshoot;
fprintf('Overshoot: %.2f%% → %s\n', OS, ternary_str(OS<10, '✅ PASS', '❌ FAIL'))

%% Settling Time (must be < 3s)
Ts = info.SettlingTime;
fprintf('Settling Time: %.2fs → %s\n', Ts, ternary_str(Ts<3, '✅ PASS', '❌ FAIL'))

%% Rise Time (info: 10% to 90%)
Tr = info.RiseTime;
fprintf('Rise Time: %.3fs\n', Tr)

%% Steady-State Error
SSE = abs(1 - dcgain(T));
fprintf('SSE: %.2e → %s\n', SSE, ternary_str(SSE<0.01, '✅ PASS', '❌ FAIL'))

%% Stability Margins
[Gm,Pm] = margin(pid(10,20,3)*tf(1,[1 2 5]));
fprintf('Gain Margin: %.2f dB → %s\n', 20*log10(Gm), ternary_str(20*log10(Gm)>6, '✅ ROBUST', '⚠️ CHECK'))
fprintf('Phase Margin: %.2f° → %s\n', Pm, ternary_str(Pm>45, '✅ ROBUST', '⚠️ CHECK'))

%% Helper function (define at end of script)
function s = ternary_str(cond, a, b)
if cond; s = a; else; s = b; end
end