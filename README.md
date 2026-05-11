# RAKESH_K_Drone_Altitude_Stabilization
# Drone Altitude Stabilization using PID Control

## CONTROL CRAFT Hackathon Project – BNMIT

A robust closed-loop drone altitude stabilization system designed using PID control in MATLAB and Simulink. The controller maintains the drone at a desired altitude while rejecting external disturbances such as wind gusts.

This project demonstrates:
- Classical control system design
- Closed-loop feedback implementation
- Disturbance rejection
- Robustness verification
- Professional simulation and visualization techniques

---

# Problem Statement

Design a control system to regulate the altitude of a drone subjected to external disturbances such as wind.

### System Description
- Input: Thrust command
- Output: Drone altitude
- Disturbance: External wind force acting at t = 5 seconds

### Transfer Function
G(s) = 1 / (s^2 + 2s + 5)

---

# Control Objectives

The controller was designed to satisfy the following specifications:

- Overshoot < 10%
- Settling Time < 3 seconds
- Steady-State Error ≈ 0
- Stable operation under disturbance conditions

---

# Tools & Technologies Used

- MATLAB
- Simulink
- PID Controller
- Control System Toolbox
- MATLAB Visualization Tools

---

# Project Workflow

The project was implemented using the following workflow:

1. System Analysis & PID Design
2. PID Tuner Optimization
3. Performance Metric Verification
4. Simulink Closed-Loop Implementation
5. Disturbance Injection Analysis
6. MATLAB Disturbance Simulation
7. Robustness & System Comparison
8. Sensitivity Analysis
9. Professional Visualization
10. Real-Time Drone Animation

---

# System Analysis & PID Design

The drone altitude dynamics were analyzed using the transfer function:

G(s) = 1 / (s^2 + 2s + 5)

The open-loop response was first studied to understand:
- Stability characteristics
- Rise time
- Overshoot behavior
- Need for feedback control

A PID controller was then designed to improve transient and steady-state performance.

---

# PID Controller Parameters

| Parameter | Value |
|---|---|
| Proportional Gain (Kp) | 10 |
| Integral Gain (Ki) | 20 |
| Derivative Gain (Kd) | 3 |
| Filter Coefficient (N) | 100 |

### Purpose of PID Terms

- **Kp:** Improves response speed
- **Ki:** Eliminates steady-state error
- **Kd:** Reduces oscillation and overshoot
- **N:** Filters derivative noise for smoother response

---

# PID Tuner — Step by Step

MATLAB PID Tuner was used to:
- Automatically tune controller gains
- Improve response speed
- Reduce overshoot
- Achieve stable settling behavior

The tuning process helped optimize the controller while maintaining robustness.

---

# Verifying Performance Metrics

Performance metrics were verified using MATLAB scripts.

### Verified Parameters
- Overshoot
- Settling Time
- Rise Time
- Steady-State Error
- Gain Margin
- Phase Margin

The controller successfully satisfied all required specifications.

---

# Simulink — Complete Implementation

The complete closed-loop system was implemented in Simulink using:
- Reference Step Input
- Error Calculation
- Disturbance Injection
- Transfer Function
- Feedback Loop
- Scope Visualization

---

# Simulink Model Configuration

| Block | Parameter | Value |
|---|---|---|
| Step (Reference) | Step Time | 0 |
|  | Initial Value | 0 |
|  | Final Value | 1 |
| Step (Disturbance) | Step Time | 5 |
|  | Initial Value | 0 |
|  | Final Value | 0.5 |
| Sum (Error) | Signs | +- |
| Sum (Plant Input) | Signs | ++ |
| Transfer Function | Numerator | [1] |
|  | Denominator | [1 2 5] |
| Scope | Axes | 2 |

---

# Disturbance Injection at t = 5s

A wind disturbance was injected at t = 5 seconds to evaluate robustness.

The disturbance simulates:
- Wind gusts
- Environmental uncertainty
- External force acting on the drone

The controller successfully compensated for the disturbance and restored stable altitude.

---

# MATLAB Simulation with Disturbance

Additional MATLAB simulations were performed to:
- Analyze disturbance rejection
- Measure recovery time
- Observe deviation from target altitude
- Validate closed-loop stability

The results confirmed:
- Fast recovery
- Stable behavior
- Strong disturbance rejection capability

---

# Robustness & System Comparison

The system was tested under:
- ±30% plant gain variation
- Different operating conditions
- Disturbance scenarios

Comparisons were made between:
- Open-loop response
- Closed-loop PID response

Results showed that PID control significantly improved:
- Stability
- Response speed
- Disturbance rejection
- Tracking accuracy

---

# Sensitivity Analysis

Sensitivity analysis was performed to study:
- Effect of parameter variation
- Controller robustness
- Stability under uncertainty

This ensured that the system remains stable even when plant dynamics vary.

---

# Professional Plots

Publication-quality plots were generated using MATLAB to visualize:
- Open-loop response
- Closed-loop response
- Settling time
- Overshoot limits
- Disturbance response

Professional visualization techniques were used to improve readability and presentation quality.

---

# Drone Altitude Animation

A real-time animated drone visualization was developed to demonstrate:
- Drone altitude movement
- Target altitude tracking
- Disturbance occurrence
- Closed-loop control behavior

The animation provides an intuitive understanding of system performance.

---

# Features

- Closed-loop altitude stabilization
- PID-based feedback control
- Wind disturbance rejection
- Stable transient response
- Robustness testing
- Sensitivity analysis
- MATLAB verification scripts
- Professional response plots
- Real-time drone animation

---

# Results

## Performance Achieved
- Stable altitude tracking
- Low overshoot
- Fast settling response
- Near-zero steady-state error
- Effective disturbance rejection
- Stable operation under uncertainty

---

# MATLAB Scripts Included

| Script | Purpose |
|---|---|
| verification.m | Verify control system performance metrics |
| disturbance_analysis.m | Analyze disturbance rejection |
| robustness_test.m | Evaluate robustness under uncertainty |
| professional_plot.m | Generate publication-quality plots |
| drone_animation.m | Real-time drone visualization |

---

# Expected Console Output

The MATLAB scripts generate outputs related to:
- PID tuning
- Stability verification
- Performance metrics
- Disturbance analysis
- Robustness testing
- Recovery time evaluation

---

# How to Run

## Simulink Simulation
1. Open MATLAB
2. Open the Simulink model file
3. Click Run
4. Observe altitude response on Scope

## MATLAB Scripts
Run the following scripts individually:

```matlab
verification
disturbance_analysis
robustness_test
professional_plot
drone_animation
```

---

# Future Improvements

- Adaptive PID tuning
- AI-based controller optimization
- 3D drone simulation
- Hardware implementation using embedded systems
- Real-time sensor integration
- Autonomous navigation integration

---

# Team Members

- Rakesh K
- Kiran

---

# Conclusion

This project successfully demonstrates a robust PID-based drone altitude stabilization system capable of maintaining stable flight under external disturbances. The controller satisfies all required specifications while demonstrating strong disturbance rejection and robustness characteristics.

The project combines:
- Classical control theory
- MATLAB analysis
- Simulink implementation
- Professional visualization
- Real-time animation

to create a complete and practical drone control solution.

---

# License

This project was developed for educational and hackathon purposes.
