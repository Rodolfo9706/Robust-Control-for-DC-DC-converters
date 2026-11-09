# Robust Nonlinear Control for Bilinear DC–DC Converters

Simulation, software-in-the-loop (SIL), and hardware files for a robust nonlinear voltage regulator for a class of bilinear second-order DC–DC converters, validated on an **inverting buck–boost converter** running on a **TI LaunchXL-F28379D** (C2000) DSP.

> **Paper:** R. Verdín and G. Flores, *"Robust Nonlinear Control for a General Class of Bilinear DC–DC Converters: Design, Stability, and Experimental Validation,"* submitted to *Control Engineering Practice*.
> A preliminary version appeared at the **2025 American Control Conference (ACC)** — see [Citation](#citation).

![Inverting buck–boost converter and control architecture](https://github.com/user-attachments/assets/ac972548-d740-4d3e-804b-bcf11292a359)

---

## Overview

The controller regulates the output voltage of second-order bilinear converters (buck, boost, inverting and non-inverting buck–boost) under bounded disturbances and source-voltage uncertainty, **without disturbance observers** and with few tuning gains. It combines:

- **Bilinear control allocation:** a virtual inductor-current target computed from the *nominal* duty ratio, so the target does not depend on the control input.
- **Command filter:** supplies the current reference and its derivative in closed form — no numerical differentiation of measured signals.
- **Terminal-type current loop** with a **two-sided saturation** that keeps the duty ratio inside $[0, M)$, $M<1$.

A Lyapunov analysis gives two explicit design conditions under which the loop leaves saturation in finite time, the current error converges in finite time (known source voltage), and the voltage error is uniformly ultimately bounded.

### Highlights

| Study | Result |
|---|---|
| Simulation (large setpoint steps + simultaneous $E, L, C, R$ variations) | Only controller among SMC-LESO, AMPC and IDA-PBC that kept regulation at all 5 setpoints |
| SIL (PSpice switched model + Simulink) | Lowest MSE, IAE, ITAE, ITSE vs. I/O linearization, FO-PI and nonlinear PI |
| Hardware (DSP prototype) | ~3× faster settling than SMC-LESO; faster load-disturbance recovery |
| Computation | < 4 µs per cycle on the 200 MHz C2000 (< 10% of the 40 µs control window) |

---

## Control law (inverting buck–boost)

With $e_1 = i_L - i_L^d$, $e_2 = v_o - v_o^d$, $\phi(e)=|e|^{1/2}\operatorname{sgn}(e)$ and nominal duty ratio $\bar u^\star = \dfrac{v_o^d}{v_o^d - E}$:

$$
K_\epsilon(e_2) = \frac{k_2\, e_2}{(e_2^2+\epsilon^2)^{1/4}}, \qquad
\alpha(e_2) = \frac{C}{1-\bar u^\star}\left[K_\epsilon(e_2) - \frac{e_2+v_o^d}{RC}\right]
$$

$$
\tau\,\dot i_L^d = \alpha(e_2) - i_L^d, \qquad
u = \sigma\!\left(1 + \frac{L\,k_1\phi(e_1) + E - L\,\dot i_L^d}{v_o - E}\right)
$$

where $\sigma(\cdot)$ is a hard lower limit at 0 and a smooth (`tanh`) upper limit below $M$. All parameters are **nominal** values; see Section 3 of the paper for the general class and the design conditions.

---

## Repository structure

> ⚠️ Adjust names to match the actual folders.

```
.
├── Simulations/                    # Averaged-model simulations (Section 4)
│   ├── SITLparameters.m
│   └── Robustcontrolsimulation.slx
├── SIL/                            # Software-in-the-loop, PSpice + Simulink (Section 5)
├── DSP/                            # Hardware implementation (Section 6)
│   ├── DSPbbparameters_ROB.m
│   └── read_ADC_scribe_PWM_ROB_1ver.slx
├── Hardware/                       # Schematics and prototype design files
└── README.md
```

---

## Requirements

- MATLAB / Simulink (tested with R20XX — *fill in*)
- **Embedded Coder** and **C2000 Microcontroller Blockset** / TI C2000 support package (hardware only)
- PSpice / Simulink co-simulation (SIL only)
- Texas Instruments Code Composer Studio (optional, for debugging)

---

## Quick start

### 1. Clone

```bash
git clone https://github.com/Rodolfo9706/Robust-Control-for-DC-DC-converters.git
cd Robust-Control-for-DC-DC-converters
```

### 2. Run the simulations

```matlab
cd Simulations
run('SITLparameters.m')                 % load plant parameters and gains
open('Robustcontrolsimulation.slx')     % then press Run
```

Results appear in the scopes of the model.

### 3. Run on the C2000 LaunchPad

1. Load the parameters:
   ```matlab
   cd DSP
   run('DSPbbparameters_ROB.m')
   ```
2. Open the model:
   ```matlab
   open('read_ADC_scribe_PWM_ROB_1ver.slx')
   ```
3. **Configure the target:** *Hardware Settings → Hardware Implementation →* Texas Instruments C2000, **F28379D**. Check the COM port.
4. **Build & deploy:** connect the LaunchPad via USB and click **Build, Deploy & Start**.
5. **Monitor** ADC readings and PWM output (oscilloscope or external mode). To try other gains, edit `DSPbbparameters_ROB.m` and redeploy.

> ⚠️ Power the converter only after the code is running, and start with low source voltage.

---

## Hardware setup

| Parameter | Value | Parameter | Value |
|---|---|---|---|
| Source $E$ | 5 V | Inductance $L$ | 2.1 mH |
| Capacitance $C$ | 2200 µF | Load $R$ | 23 Ω |
| PWM frequency | 25 kHz | Gate signal | 5 V |
| Diode | NFN306 | MOSFET | IRL744N |
| Current sensor | ACS712T | Controller | LaunchXL-F28379D |

The MOSFET is driven through an optocoupler stage; output voltage is measured with a differential op-amp circuit. The control law runs at 25 kHz, synchronized with the PWM.

### Gains used

| Study | $k_1$ | $k_2$ | $\epsilon$ | $\tau$ | $\ell$ | $M$ |
|---|---|---|---|---|---|---|
| Simulation | 300 | 120 | 9 | 0.1 ms | 0.95 | 0.98 |
| SIL | 130 | 35 | 0.25 | 0.5 ms | 0.95 | 0.98 |
| Hardware | 1120 | 80 | 2.25 | 0.1 ms | 0.95 | 0.98 |

**Tuning tip:** start from Remark 1 of the paper — choose $k_1 \ge \sqrt{2\delta / t_1^\star}$ for a desired current-loop settling time $t_1^\star$, then keep $k_2/\sqrt{\epsilon}$ below the small-gain bound. Refine in SIL before moving to hardware.

---

## Citation

If you use this code, please cite:

```bibtex
@inproceedings{verdin2025robust,
  author    = {Verd{\'i}n, Rodolfo and Flores, Gerardo},
  title     = {Robust control of an inverting buck-boost converter under exogenous disturbances},
  booktitle = {2025 American Control Conference (ACC)},
  pages     = {5034--5039},
  year      = {2025},
  doi       = {10.23919/ACC63710.2025.11107449}
}
```

The journal version will be added once published.

---

## Authors

- **Rodolfo Verdín** — Laboratorio de Percepción y Robótica (LAPyR), Centro de Investigaciones en Óptica (CIO), México · [@Rodolfo9706](https://github.com/Rodolfo9706)
- **Gerardo Flores** — RAPTOR Lab, Texas A&M International University · [@gfloresc](https://github.com/gfloresc)

<p align="center">
  <a href="https://github.com/Rodolfo9706/Robust-Control-for-DC-DC-converters/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Rodolfo9706/Robust-Control-for-DC-DC-converters" />
  </a>
</p>

## License

*Add a license (e.g., MIT) so others can reuse the code.*
