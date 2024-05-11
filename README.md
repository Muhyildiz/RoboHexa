# RoboHexa 🕷️

This repository contains the codebase for a hexapod robot designed for traversing hard terrain.

![VID-20240511-WA0005_1](https://github.com/Muhyildiz/RoboHexa/assets/155567113/dfd2762d-f673-4357-960f-891b1bb95ebf)

The steps line of the project:
* Literature Research
* Mechanical Design Building
* Motor Calibration
* Basic Behaviour and Motion Control

## Components

- **MG996R Servo Motors:** Actuates the six legs of the hexapod.
- **STM32 Microcontroller:** Controls servo motors by PWM signal and processes sensor data.
- **IMU6050 Sensor:** Provides orientation and acceleration data for balance control.
- **NRF24L01 Transceiver Module:** Remotely controlling the Robot using NRF24L01.
- **Mini Switch:** To get data when each leg touches the ground.

  
## Electrical 

- **PCB**: The custom PCB was meticulously engineered to maximize power efficiency and optimize heat dissipation capabilities. It also handles the connection of 18 PWM signals, SPI, and I2C communication, highlighting its advanced functionality in electronic systems.

- <img src="https://github.com/Muhyildiz/RoboHexa/assets/155567113/c14f24c9-7653-4df8-bcc6-7aafd2688536" width="500" height="350" /> <img src="https://github.com/Muhyildiz/RoboHexa/assets/155567113/7ab93820-57e4-4a7c-8d72-4899a8903242" width="500" height="350" />

![file_2024-04-26_15 31 03](https://github.com/Muhyildiz/RoboHexa/assets/155567113/c14f24c9-7653-4df8-bcc6-7aafd2688536)

![file_2024-04-26_15 31 44](https://github.com/Muhyildiz/RoboHexa/assets/155567113/7ab93820-57e4-4a7c-8d72-4899a8903242)


  
## Features

- **PID:** Utilizes six legs for versatile movement on rough terrain.
![HexaScan Control System Diagram](https://github.com/Muhyildiz/RoboHexa/assets/96660754/903fce0b-9ca5-4269-8033-fd94f4282ce0)

  
- **LIDAR:** Integrated the sensor to make mapping the environment.
- **RF Control:** Controlling the robot remotely with a self-designed controller.





![Adaptive Behavioral Methods for a Hexapod Robot A Multidisciplinary Approach in Robotics and Artificial Intelligence (3)](https://github.com/Muhyildiz/RoboHexa/assets/96660754/4995fdb5-3b1c-4585-aa92-a35a1eb86b6e)
