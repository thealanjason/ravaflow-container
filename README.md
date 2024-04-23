# r.avaflow Container
This repository contains a MWE to build a apptainer container for the ![r.avaflow](https://www.landslidemodels.org/r.avaflow/) solver.

## How to Use
0. Install Apptainer using the ![Installation Instructions](https://apptainer.org/docs/admin/main/installation.html#install-from-pre-built-packages). For a compute cluster with apptainer already installed, load the Apptainer module instead.
1. Clone this repository 
2. Change directory: `cd ravaflow-container`
3. Build the apptainer container: `apptainer build ravalfow-full-x86_64.sif ravaflow-full.def`
4. Run a test case with the following command in the terminal
    ``` 
    apptainer exec ravaflow-full-x86_64.sif grass --tmp-location XY --exec sh <path_to_ravaflow_shell_script>
    ```
    
    where, <path_to_ravaflow_shell_script> could be:
    - test/Cascadia_G20230414/ca.avaflow.rockavalanche.sh
    - test/Cascadia_G20230414/ca.avaflow.start.sh
    - test/Acheron_G20230122/ac.avaflow.start.sh


## Reproducibility
This container is currently built and tested on Linux for the following architectures:
    - [x] x86_64
    - [ ] aarch64

