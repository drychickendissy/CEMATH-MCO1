# Machine Problem 1 – Area Under the Curve (AUC)

## Overview
This project computes the **Area Under the Curve (AUC)** of a given function using numerical integration methods in MATLAB.

The program allows the user to:
- Choose between **Trapezoidal Rule** and **Simpson’s Rule**
- Input function parameters and integration limits
- Visualize the function through plots
- Handle both **positive and negative regions** of the curve properly

---

## Problem Description

The goal is to compute the definite integral of a function:

### Version 1 (2 Members)
\[
y = \sin(ct)
\]

### Version 2 (3 Members)
\[
y = e^{dt} \sin(ct)
\]

Where:
- `c` and `d` are user-defined constants
- The integration is performed over a user-defined interval

---

## ⚙️ Features

- User input for:
  - Numerical method (Trapezoidal or Simpson’s)
  - Constants (`c`, `d`)
  - Lower and upper limits
  - Number of intervals
- Plot generation of the function
- Detection of **zero crossings**
- Partitioning of graph into:
  - Positive regions
  - Negative regions
- Individual AUC computation per region
- Total AUC calculation

---

## Numerical Methods Used

### 1. Trapezoidal Rule
Approximates the area using trapezoids.

### 2. Simpson’s Rule
Uses parabolic arcs for better accuracy (requires even number of intervals).

---

## How to Run

1. Open MATLAB
2. Run the script:
   ```matlab
   myMP1

Follow the prompts:
- Choose method (1 or 2)
- Enter function parameters
- Enter limits and intervals

## Sample Workflow
Choose an option:
'1' - Trapezoidal Rule
'2' - Simpson's Rule

```text
Enter choice: 1
Enter value of c: 1
Enter lower limit: 0
Enter upper limit: 2*pi
Enter number of intervals: 1000
```

## Output

- Graph of the function

- Highlighted regions (positive & negative)

- Zero-crossing points

- Individual AUC per segment

- Total AUC

## Important Notes

- Built-in functions like trapz are NOT allowed

- Use only:

  1. Basic math operations

  2. Loops and conditionals

  3. Standard plotting functions

- Must include:

  1. Input validation

  2.   Comments in code

  3. Negative areas must be handled separately before summation

## Error Handling

The program checks:

- Valid numeric inputs

- Lower limit < upper limit

- Proper interval values

## Project Structure
```text
/project-folder
│── myMP1.m              # Main script (Version 1)
│── README.md            # Project documentation
│── documentation.pdf    # Full report (derivations + screenshots)
```

## Notes

- Analytical solution must be shown in documentation

- Include screenshots of:

  1. Sample runs

  2. Generated plots

  3. Ensure results are verified manually

## Summary

This project demonstrates:

- Numerical integration techniques

- MATLAB programming fundamentals

- Proper handling of piecewise areas in definite integrals
