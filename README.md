# Nonlinear Robust Control for Inverting Buck-Boost Converters: Design, Stability, and Practical Implementation

This paper presents the design and practical implementation of a nonlinear robust control strategy for a DC-DC inverting buck-boost converter, leveraging Lyapunov stability
theory to guarantee almost global finite-time stability. The proposed controller effectively mitigates external disturbances, such as noise and voltage fluctuations, ensuring precise regulation of the output voltage. A pulse-width modulation (PWM) scheme is employed to interface the control signal with the actuator. The controller’s performance was validated through software-in-the-loop simulations and experimental tests on a low-cost prototype using the LaunchXL-F28379D DSP. Comparisons with state-of-the-art controllers, including nonlinear approaches, highlight significant improvements in disturbance rejection and stability, achieved with reduced complexity and tuning requirements. The results demonstrate the robustness and efficiency of the proposed control strategy, offering a practical and scalable solution for real-world applications. 

![image](https://github.com/user-attachments/assets/ac972548-d740-4d3e-804b-bcf11292a359)


## **Installation and Usage Guide**

### 1. **Clone the Repository**  
First, clone the repository to your local machine:  
```bash
git clone https://github.com/Rodolfo9706/Buck-boost-controllers.git
cd Buck-boost-controllers 
```

### 2. **Running the Code on the C2000 Launchpad DSP**

To execute the control implementation on the C2000 Launchpad DSP, follow these steps:

---

### **. Load System Parameters**

- Open MATLAB and navigate to the folder containing the repository.
- Run the **`DSPbbparameters_ROB.m`** file to initialize the parameters for the control system. This file sets up the required variables for the DSP program.

   ```matlab
   run('DSPbbparameters_ROB.m')
   ```
### **. Open the Simulink Model**

Navigate to the folder where the DSP implementation files are located.

Open the Simulink model read_ADC_scribe_PWM_ROB_1ver.slx by typing the following command in the MATLAB Command Window:
```matlab
open('read_ADC_scribe_PWM_ROB_1ver.slx')
```
### **.  Configure the Target Hardware**
Before running the model, ensure that the target hardware is properly configured:

- Connect the C2000 Launchpad DSP to your computer via USB.
- In Simulink, go to "Simulink Toolstrip" → "Hardware Settings".
- Under "Hardware Implementation", select the target hardware as Texas Instruments C2000 (e.g., F28379D).
- Ensure the communication interface (e.g., COM port) is correctly set up for the DSP.

### **. Build and Deploy the Model**

- Click on the "Build" button in the Simulink toolstrip to compile and upload the code to the DSP.
- Ensure the code is successfully loaded onto the hardware.

5. Run the System
- Once the code is deployed, the DSP will execute the control algorithm in real-time.
- You can monitor the system's behavior using the connected peripherals (e.g., ADC readings or PWM outputs).

7. Analyze and Debug
Use tools like Code Composer Studio (if needed) to debug or monitor the DSP's operation.
Adjust parameters in DSPbbparameters_ROB.m as necessary and re-deploy the model to test different scenarios.
Prerequisites


### **. Prerequisites**
To execute the code on the C2000 Launchpad DSP, ensure you have the following:

- MATLAB/Simulink with the Embedded Coder and C2000 support packages installed.
- Texas Instruments Code Composer Studio (optional, for advanced debugging).
- Proper hardware setup, including power supply, connections, and any necessary sensors or actuators.

 ### 3.**Running the Simulations**

To run the simulations provided in the repository, follow these steps:

---

### **. Load System Parameters**

- Open MATLAB and navigate to the folder where the repository is located.
- Run the **`SITLparameters.m`** file to load the system parameters into the MATLAB workspace. This file initializes the required variables for the simulation.

   ```matlab
   run('SITLparameters.m')

   2. Open the Simulink Model
   
After the parameters are loaded, navigate to the Simulations/ folder.

Open the Simulink model simulacionrobusto.slx by typing the following command in the MATLAB Command Window:
 ```
matlab
open('Robustcontrolsimulation.slx')
 ```
3. Run the Simulation
Once the model is open, click the "Run" button at the top of the Simulink interface to start the simulation.
Observe the results in the provided scopes or output blocks included in the model.

## Contributors  
- [@gfloresc](https://github.com/gfloresc)
- [@Rodolfo9706](https://github.com/Rodolfo9706)

<p align="center">
  <a href="https://github.com/Rodolfo9796/Buck-boost-controllers/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Rodolfo9706/Buck-boost-controllers" />
  </a>
</p>
