# Arduino Sodar System

## Overview
An **Arduino-based ultrasonic scanning system** that emulates a basic sonar/radar. An **HC-SR04 ultrasonic sensor** mounted on a **servo motor** sweeps from **0° to 180° and back**, measuring object distance at each angle. Angle–distance data is transmitted over **serial communication** and visualised in real time using a **Processing-based radar GUI**.

Distance measurements are performed in **centimetres** on the microcontroller and converted to **inches** at the GUI layer for display.

---

## System Summary
- Servo-driven 180° sweep  
- Ultrasonic distance measurement (**cm**)  
- Real-time radar-style visualisation (**inches**)  
- Audible proximity alert for close objects  

---

## Hardware
- Arduino (e.g. Uno)  
- HC-SR04 ultrasonic sensor  
- SG90 micro servo  
- Active buzzer  

---

## Software
- Arduino (C/C++)
- Processing (Java-based GUI)
- Libraries: `Servo.h`, `Ultrasonic.h`, `processing.serial.*`

---

## Data Interface
Serial output format:
```

<angle>,<distance_cm>.

```

---

## Behaviour
### Arduino
- Sweeps **0 → 180 → 0°** in 1° steps  
- Measures distance in **centimetres**  
- Serial baud rate: **9600**  
- Activates buzzer when `distance < 40 cm`  

### Processing GUI
- Parses serial data  
- Converts distance from **cm → inches** for display  
- Highlights targets detected within **100 cm**  
- Displays radar sweep with fading afterglow  

---

## Known Limitations
- **Unit conversion occurs only at the GUI layer**, which can be confusing during debugging. A more robust design would standardise units across the system or encode them explicitly in the serial protocol.
- **Buzzer alerts are not always perfectly synchronised with the GUI**, due to blocking delays in the Arduino control loop.

---

## Skills Demonstrated
- Embedded systems programming  
- Sensor and actuator integration  
- Serial communication design  
- Real-time data visualisation  
- Debugging timing and unit-consistency issues  

---

## Author
**Abdulrahman Mustafa**  
Electronic & Electrical Engineering  
University of Surrey  
https://www.linkedin.com/in/abdulrahman-m-92a7392a0/
