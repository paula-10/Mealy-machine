#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2023.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu May 30 14:16:17 EEST 2024
# SW Build 3865809 on Sun May  7 15:04:56 MDT 2023
#
# IP Build 3864474 on Sun May  7 20:36:21 MDT 2023
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim tb_vending_machine_behav -key {Behavioral:sim_1:Functional:tb_vending_machine} -tclbatch tb_vending_machine.tcl -log simulate.log"
xsim tb_vending_machine_behav -key {Behavioral:sim_1:Functional:tb_vending_machine} -tclbatch tb_vending_machine.tcl -log simulate.log

