# 2.4 GHz Low-Noise Amplifier — Input Matching Network Design (Qucs-S)

A 2.4 GHz LNA input matching network designed around the Infineon BFP420 SiGe
bipolar transistor (biased at Vce=2V, Ic=5mA), simulated in **Qucs-S** using the
transistor's real small-signal S-parameters (manufacturer S2P file).

---

## 1. Design target

- Frequency: **2.4 GHz** (ISM band)
- Target: S11 < -10 dB at 2.4 GHz (conjugate-matched input)
- Device: Infineon BFP420, Vce = 2V, Ic = 5mA (per `BFP420_2V_5mA.s2p`)

## 2. Method

The transistor's input impedance at 2.4 GHz, derived directly from its S11
(0.608∠-165.2°), is **Zin ≈ 12.4 − j6.1 Ω**. Matching this low, capacitive
impedance to a 50 Ω source requires an L-section matching network.

**Two L-section topologies were evaluated algebraically** (not by trial and
error) by solving the exact impedance-matching equations for both orderings:

- **Series-element-first, then shunt** (the initially-built topology):
  solving the matching equations for this ordering requires taking the square
  root of a *negative* discriminant (−428.6) — **no real-valued
  inductor/capacitor combination can match this load in this topology, at
  this frequency.** This was proven symbolically, not just found empirically
  by a failed sweep.
- **Shunt-element-first, then series** (the corrected topology): the same
  equations yield a valid real solution — **shunt inductor, series
  capacitor.**

The analytic (unilateral) solution was cross-checked against a full two-port
S-parameter model (including the transistor's S12 feedback, via ABCD-matrix
cascading) and the two methods agreed to within simulation precision,
confirming the result wasn't an artifact of ignoring feedback.

## 3. Final circuit

```
Port1 (50Ω) ── L1 (1.9 nH, shunt to ground) ── C1 (4.8 pF, series) ── X1 (BFP420) ── Port2 (50Ω)
```

| Component | Type | Value | Position |
|---|---|---|---|
| L1 | Inductor | 1.9 nH | Shunt to ground, at Port1 |
| C1 | Capacitor | 4.8 pF | Series, between L1 node and transistor input |

## 4. Results (simulated, 2.4 GHz)

| Parameter | Target | Simulated |
|---|---|---|
| S11 | < -10 dB | **-23.5 dB** |
| Gain (S21) | > 12 dB | **15.5 dB** |
| Resonance Frequency | 2.40 GHz | **2.4 GHz** |

S11 reaches a sharp null close to 2.4 GHz (visible in the Cartesian plot as
the red curve's deep dip), well exceeding the -10 dB design target. Full-band
behavior (1.5–3.5 GHz) is shown in the results plot.

## 5. Engineering finding worth documenting

The original matching network attempt used a series-inductor-first topology,
chosen before checking whether it was mathematically capable of matching this
specific transistor's impedance at this frequency. It wasn't — proven by a
negative discriminant in the closed-form L-match equations, not just by
failing to find good values through tuning. Switching to the shunt-first
topology (the only one with a real solution for this load) immediately gave
a clean, deep match. This is the core lesson of L-section matching network
design: **topology choice is determined by whether the load resistance is
above or below the system impedance (here, RL=12.4Ω < Z0=50Ω), not by
arbitrary circuit layout** — the wrong topology cannot be fixed by retuning
component values, no matter how long you search.

## 6. Scope and limitations

- Only the **input** is matched. The output (Port2) is connected directly to
  the transistor with no output matching network; raw S22 is roughly -2 to
  -5 dB across the band, well short of a well-matched output. A complete LNA
  design would add an output matching network using the same method.
- **Noise figure was not simulated** in this pass — the S2P file contains
  noise parameters (Fmin, GammaOpt, Rn) that Qucs-S can use if the SP
  simulation block's `Noise` option is enabled; this is a natural next step
  rather than a claimed result here.
- **Stability factor K** is computed (equation block in the schematic) and
  plotted across the band; values should be confirmed above 1 across the
  full swept range before claiming unconditional stability.
- This is a circuit-level (lumped-element) simulation only — no PCB layout,
  parasitic, or electromagnetic verification was performed.

## 7. Tools

[Qucs-S](https://ricardojlrufino.github.io/qucs-s/) (S-parameter circuit
simulator, free), transistor S-parameters from the manufacturer-published
S2P file. No paid software required.

## 8. Directory structure

```
2.4GHz-LNA-QucsS-Design/
├── data/
│   └── BFP420_2V_5mA.s2p
├── lna_2g4.sch
├── lna_2g4.dpl
├── assets/
│   ├── lna_schematic.png
│   └── lna_results.png
├── LICENSE
└── README.md
```

## 9. How to reproduce

1. Install Qucs-S.
2. Open `lna_2g4.sch`, confirm the `X1` component's `File=` path points to
   your local copy of `data/BFP420_2V_5mA.s2p`.
3. Run the S-parameter simulation (already configured: 1.5–3.5 GHz, 201
   points).
4. Open `lna_2g4.dpl` to view the Cartesian gain/S11 plot, Smith charts, and
   data table.
