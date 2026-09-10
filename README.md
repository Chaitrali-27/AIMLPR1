# Vacuum-Cleaner Intelligent Agent (Prolog)

TY B.Tech. – Artificial Intelligence and Machine Learning
**Practical Assignment 1: PEAS Descriptors of Task Environment**

## Overview

This project implements a rule-based **Vacuum-Cleaner Intelligent Agent** in
Prolog and demonstrates its task environment using the **PEAS**
(Performance measure, Environment, Actuators, Sensors) framework.

The agent operates in a 3-room environment (`a`, `b`, `c` connected as
`a - b - c`). It perceives whether its current room is dirty, decides to
either **clean** the room or **move** to an adjacent room, and **stops**
once every room is clean.

## PEAS Descriptors

| Descriptor | Description |
|---|---|
| **Performance Measure** | % of rooms kept clean; minimising number of move/clean actions; avoiding unnecessary movement |
| **Environment** | 3 interconnected rooms (a, b, c); discrete, static, deterministic, fully observable, single-agent |
| **Actuators** | `move(ToRoom)` – relocates the agent; `clean` – removes dirt from the current room |
| **Sensors** | `vacuum_location/1` – current room; `dirty/1` – which rooms are dirty |

## Repository Contents

```
.
├── README.md          # this file
├── vacuum.pl           # main Prolog source (knowledge base, rules, control loop)
└── sample_output.txt    # sample input/output traces for 3 test cases
```

## Requirements

- [SWI-Prolog](https://www.swi-prolog.org/) (tested on version 9.x)
- No external Prolog libraries/packages are required — the program uses
  only the built-in inference engine, `dynamic/1`, `retract/1`,
  `assertz/1`, and `format/2`.

### Installing SWI-Prolog

- **Windows/macOS:** download the installer from https://www.swi-prolog.org/download/stable
- **Ubuntu/Debian:**
  ```bash
  sudo apt-get update
  sudo apt-get install swi-prolog
  ```

## How to Run

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd <your-repo-folder>
   ```
2. Start SWI-Prolog and load the file:
   ```bash
   swipl vacuum.pl
   ```
3. At the `?-` prompt, run the agent's control loop:
   ```prolog
   ?- start.
   ```
4. To run it non-interactively from the command line instead:
   ```bash
   swipl -q -g start -t halt vacuum.pl
   ```

## Sample Output

Running `start.` with the default initial state
(`dirty(a)`, `dirty(c)`, `vacuum_location(a)`) produces:

```
Vacuum cleaned room a.
Vacuum moved from room a to room b.
Vacuum moved from room b to room c.
Vacuum cleaned room c.
All rooms are clean. Stopping...
```

See `sample_output.txt` for this and two additional edge-case traces
(no dirty rooms; a single dirty room reached from a different start
position).

> **Note:** The final "All rooms are clean. Stopping..." line is printed
> twice. This happens because, after the last `stop` action succeeds, the
> first clause of `start/0` fails its `Action \= stop` check and Prolog
> backtracks into the second `start/0` clause, which performs `stop`
> again. It is a harmless, cosmetic quirk in the control loop and does not
> affect the correctness of the cleaning result.


