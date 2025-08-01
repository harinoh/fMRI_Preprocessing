# fMRI_Preprocessing 

A pipeline for preprocessing resting-state fMRI data in NIfTI format using FSL.

<br><br/>

## 📋 Overview

1. Remove first 4 EPIs

2. Motion correction

3. Distortion correction (LR & RL)

4. Brain extraction

5. Co-registration of functional to structural image

6. Nonlinear registration to standard space (T1 --> MNI152)

7. Nuisance signal regression

8. Band-pass filtering (0.01 - 0.08 Hz)

9. Spatial smoothing

*Note: Slice timing correction should be considered if TR > 1.5s*

<br><br/>

## 📁 Input & Output

- **Input**: Raw fMRI (`.nii.gz`), structural T1 image, Spin-echo EPI images acquired with opposite phase-encoding directions
- **Output**: Preprocessed fMRI aligned to MNI152 space (*_prepFinal.nii.gz)

<br><br/>

## 🛠 Tools & Dependencies
- FSL (v6.0+)
- Bash shell scripting
