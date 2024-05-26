# Micro-architecture modification in RTL for RISC-V in datat forwarding and branch prediction

This project is currently archived and no longer maintained, as a new revamped version is undergoing, aiming to implement advanced branch predictors such as TAGE and neural perceptron predictors, as well as instrcution and data level parallelisms. As the project files and modules are messy and has non-unified naming, the revamped version will start from scratch, from the baseline design by RipperJ at (https://github.com/RipperJ/RISC-V_CPU/tree/main/RV32i).

***

## Acknowledgements

The baseline processor is forked from the desgin by RipperJ, which can be accessed at [https://github.com/RipperJ/RISC-V_CPU/tree/main](url).

***

## Implemented modifications
### Data forwarding
Data forwarding is implemented to remove stalls caused by RAW hazards. Load-used hazards are partially resolved with a one-cycle stall.

### Branch prediction
The processor currently implements the follwowing branch predictors:
* Static branch predictor (always taken/nottaken)
* 2-bit saturating counter register
* Smith's predictor (with pattern history table)
* 2-bit correlating predictor (with PHT and branch history register)
* Gshare predictor
