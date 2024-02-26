# RoboHexa

This repository contains the codebase for a hexapod robot designed for traversing hard terrain.
                           ![HexaScan](https://github.com/Muhyildiz/RoboHexa/assets/96660754/79c3b4e5-5bf7-4a70-b193-3a2b2a3b2c7f)

## Components

- **MG996R Servo Motors:** Actuates the six legs of the hexapod.
- **STM32 Microcontroller:** Controls servo motors and processes sensor data.
- **IMU6050 Sensor:** Provides orientation and acceleration data for balance control.
- **Mini Switch:** To get data when each leg touches the ground.

  
## Components

- **PCB**: Custom designed to manage wires and power.

  
## Features

- **PID:** Utilizes six legs for versatile movement on rough terrain.
- **LIDAR:** Integrated IMU6050 sensor ensures stability and adaptation to surface conditions.
- **RF Control:** Includes a button for user interaction, enabling manual control or predefined actions.
