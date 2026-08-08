# UART using Verilog HDL

## Introduction

UART stands for Universal Asynchronous Receiver Transmitter.

UART is a serial communication protocol used to transfer data between two devices.
It sends data one bit at a time through a serial communication line.

This project implements a basic UART transmitter and receiver using Verilog HDL.

## Features

- 8-bit data transmission
- 1 start bit
- 1 stop bit
- No parity bit
- Separate transmitter and receiver
- Loopback testing
- Verilog HDL implementation
- Testbench included
- Waveform simulation supported

## UART Frame Format

A UART frame consists of:

1. Start Bit
2. 8 Data Bits
3. Stop Bit

The frame format is:

Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
-----|-------|----|----|----|----|----|----|----|----|-----
  1  |   0   |    DATA    |              |  1

## Block Diagram

             +----------------+
data_in ---> | UART Transmitter| ---> uart_tx
             +----------------+
                                      |
                                      | Serial Data
                                      |
             +----------------+
data_out <-- |  UART Receiver | <--- uart_rx
             +----------------+

## Files

- `uart_tx.v` - UART transmitter module
- `uart_rx.v` - UART receiver module
- `uart_top.v` - Top-level UART module
- `uart_tb.v` - Testbench
- `simulation/` - Simulation waveform files

## Working

### Transmitter

The transmitter converts parallel 8-bit data into serial data.

When transmission starts:

1. UART sends a start bit (0).
2. Eight data bits are transmitted.
3. UART sends a stop bit (1).
4. The transmitter becomes idle.

### Receiver

The receiver receives serial data and converts it back into an 8-bit parallel value.

It detects:

1. Start bit
2. Eight data bits
3. Stop bit

After receiving the complete byte, `data_valid` becomes high.

## Applications

- Computer serial communication
- Microcontroller communication
- Embedded systems
- GPS communication
- Bluetooth modules
- Serial debugging
- FPGA communication

## Tools Required

- Icarus Verilog
- GTKWave

## Simulation

Compile the project:

```bash
iverilog -o uart_sim uart_tx.v uart_rx.v uart_top.v uart_tb.v