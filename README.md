# Robotic-Hand

**A Gesture Controlled Robotic Hand featuring a Digital Lock, Real time Hand Mimicry, and Controllable Palm LED (FPGA).**

https://www.youtube.com/watch?v=_u1SvZUec80&t=1s

---

## How It Works

This project seamlessly integrates a Python based hand gesture recognition system with a VHDL implemented control logic on a Xilinx Basys 3 FPGA board.

### 1. Hand Gesture Recognition & Communication (Python & UART)
The process begins with a Python script running on a host PC. This script continuously analyzes live camera feed to detect and interpret hand gestures, specifically focusing on the open/closed state of individual fingers. The real time finger state data is then transmitted via UART (Universal Asynchronous Receiver-Transmitter) to the Basys 3 FPGA board.

### 2. Digital Lock Mechanism (VHDL on FPGA)
Upon receiving finger state data through UART, the Basys 3 FPGA employs a **Finite State Machine (FSM)** implemented in VHDL. This FSM acts as a digital lock. When the user performs a predefined sequence of hand gestures, the FSM transitions through its states ultimately unlocking the robotic hand and preparing it for operation.

### 3. Real-time Hand Mimicry (VHDL on FPGA)
Once unlocked, the robotic hand begins to mimic the user's hand movements in real time. The VHDL logic on the Basys 3 board controls the robotic hand's servo motors based on the incoming finger state data from the Python script. The **FPGA's parallel processing capabilities** ensure rapid response of servo motors to user hand movements.

### 4. Controllable Palm LED (VHDL on FPGA)
The system also includes an interactive LED located in the palm of the robotic hand, controlled by the FPGA.
If all fingers are held in a closed position for a continuous duration of 3 seconds (tracked by an internal counter operating with the Basys 3's 100 MHz internal clock), the palm LED lights up, creating a "repulsor" like effect.
Conversely, if a "Spiderman hand move" gesture is maintained for 3 consecutive seconds, the palm LED is extinguished.

### 5. Manual Lock/Reset (FPGA Button)
For user convenience and control, a physical button on the Basys 3 board is integrated into the VHDL logic. Pressing this button instantly locks the robotic hand, resetting the digital lock mechanism and bringing the system back to its initial state.

---

## Short Project Demo

![Robotic Hand Short Demo GIF](images/Demonstration.gif)

---
