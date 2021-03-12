
################################################################
# This is a generated script based on design: microblaze_3
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source microblaze_3_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# DVIClocking

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k325tffg900-2
   set_property BOARD_PART digilentinc.com:genesys2:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name microblaze_3

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
digilentinc.com:user:AXI_BayerToRGB:1.0\
digilentinc.com:user:AXI_GammaCorrection:1.0\
digilentinc.com:ip:MIPI_CSI_2_RX:1.2\
digilentinc.com:ip:MIPI_D_PHY_RX:1.3\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_iic:2.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:axi_vdma:6.3\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:mig_7series:4.2\
digilentinc.com:ip:rgb2vga:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:v_axi4s_vid_out:4.0\
xilinx.com:ip:clk_wiz:6.0\
digilentinc.com:video:video_scaler:1.0\
xilinx.com:ip:v_tc:6.2\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
DVIClocking\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}


##################################################################
# MIG PRJ FILE TCL PROCs
##################################################################

proc write_mig_file_microblaze_3_mig_7series_0_0 { str_mig_prj_filepath } {

   file mkdir [ file dirname "$str_mig_prj_filepath" ]
   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {﻿<?xml version="1.0" encoding="UTF-8" standalone="no" ?>}
   puts $mig_prj_file {<Project NoOfControllers="1">}
   puts $mig_prj_file {  }
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {  <ModuleName>microblaze_3_mig_7series_0_0</ModuleName>}
   puts $mig_prj_file {  <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {  <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {  <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {  <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {  <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {  <XADC_En>Enabled</XADC_En>}
   puts $mig_prj_file {  <TargetFPGA>xc7k325t-ffg900/-2</TargetFPGA>}
   puts $mig_prj_file {  <Version>4.2</Version>}
   puts $mig_prj_file {  <SystemClock>Differential</SystemClock>}
   puts $mig_prj_file {  <ReferenceClock>No Buffer</ReferenceClock>}
   puts $mig_prj_file {  <SysResetPolarity>ACTIVE LOW</SysResetPolarity>}
   puts $mig_prj_file {  <BankSelectionFlag>FALSE</BankSelectionFlag>}
   puts $mig_prj_file {  <InternalVref>0</InternalVref>}
   puts $mig_prj_file {  <dci_hr_inouts_inputs>50 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {  <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {  <Controller number="0">}
   puts $mig_prj_file {    <MemoryDevice>DDR3_SDRAM/Components/MT41J256m16XX-107</MemoryDevice>}
   puts $mig_prj_file {    <TimePeriod>1250</TimePeriod>}
   puts $mig_prj_file {    <VccAuxIO>1.8V</VccAuxIO>}
   puts $mig_prj_file {    <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {    <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {    <UIExtraClocks>1</UIExtraClocks>}
   puts $mig_prj_file {    <MMCM_VCO>800</MMCM_VCO>}
   puts $mig_prj_file {    <MMCMClkOut0> 4.000</MMCMClkOut0>}
   puts $mig_prj_file {    <MMCMClkOut1>4</MMCMClkOut1>}
   puts $mig_prj_file {    <MMCMClkOut2>16</MMCMClkOut2>}
   puts $mig_prj_file {    <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {    <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {    <DataWidth>32</DataWidth>}
   puts $mig_prj_file {    <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {    <DataMask>1</DataMask>}
   puts $mig_prj_file {    <ECC>Disabled</ECC>}
   puts $mig_prj_file {    <Ordering>Normal</Ordering>}
   puts $mig_prj_file {    <BankMachineCnt>4</BankMachineCnt>}
   puts $mig_prj_file {    <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {    <NewPartName/>}
   puts $mig_prj_file {    <RowAddress>15</RowAddress>}
   puts $mig_prj_file {    <ColAddress>10</ColAddress>}
   puts $mig_prj_file {    <BankAddress>3</BankAddress>}
   puts $mig_prj_file {    <MemoryVoltage>1.5V</MemoryVoltage>}
   puts $mig_prj_file {    <C0_MEM_SIZE>1073741824</C0_MEM_SIZE>}
   puts $mig_prj_file {    <UserMemoryAddressMap>BANK_ROW_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {    <PinSelection>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AC12" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AB8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[10]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AA8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[11]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AB12" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[12]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AA12" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[13]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AH9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[14]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AE8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AD8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AC10" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AD9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AA13" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AA10" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AA11" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="Y10" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[8]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="Y11" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_addr[9]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AE9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_ba[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AB10" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_ba[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AC11" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_ba[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AF11" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_cas_n"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15" PADName="AC9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_ck_n[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15" PADName="AB9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_ck_p[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AJ9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_cke[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AH12" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_cs_n[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AD4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dm[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AF3" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dm[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AH4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dm[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AF8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dm[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AD3" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AF1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[10]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AE4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[11]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AE3" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[12]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AE5" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[13]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AF5" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[14]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AF6" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[15]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AJ4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[16]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AH6" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[17]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AH5" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[18]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AH2" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[19]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AC2" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AJ2" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[20]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AJ1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[21]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AK1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[22]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AJ3" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[23]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AF7" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[24]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AG7" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[25]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AJ6" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[26]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AK6" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[27]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AJ8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[28]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AK8" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[29]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AC1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AK5" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[30]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AK4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[31]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AC5" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AC4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AD6" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AE6" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AC7" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AF2" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[8]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15_T_DCI" PADName="AE1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dq[9]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AD1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_n[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AG3" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_n[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AH1" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_n[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AJ7" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_n[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AD2" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_p[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AG4" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_p[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AG2" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_p[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AH7" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_dqs_p[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AK9" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_odt[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AE11" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_ras_n"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="LVCMOS15" PADName="AG5" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_reset_n"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="SSTL15" PADName="AG13" SLEW="" VCCAUX_IO="NORMAL" name="ddr3_we_n"/>}
   puts $mig_prj_file {    </PinSelection>}
   puts $mig_prj_file {    <System_Clock>}
   puts $mig_prj_file {      <Pin Bank="33" PADName="AD12/AD11(CC_P/N)" name="sys_clk_p/n"/>}
   puts $mig_prj_file {    </System_Clock>}
   puts $mig_prj_file {    <System_Control>}
   puts $mig_prj_file {      <Pin Bank="Select Bank" PADName="No connect" name="sys_rst"/>}
   puts $mig_prj_file {      <Pin Bank="Select Bank" PADName="No connect" name="init_calib_complete"/>}
   puts $mig_prj_file {      <Pin Bank="Select Bank" PADName="No connect" name="tg_compare_error"/>}
   puts $mig_prj_file {    </System_Control>}
   puts $mig_prj_file {    <TimingParameters>}
   puts $mig_prj_file {      <Parameters tcke="5" tfaw="35" tras="34" trcd="13.91" trefi="7.8" trfc="260" trp="13.91" trrd="6" trtp="7.5" twtr="7.5"/>}
   puts $mig_prj_file {    </TimingParameters>}
   puts $mig_prj_file {    <mrBurstLength name="Burst Length">8 - Fixed</mrBurstLength>}
   puts $mig_prj_file {    <mrBurstType name="Read Burst Type and Length">Sequential</mrBurstType>}
   puts $mig_prj_file {    <mrCasLatency name="CAS Latency">11</mrCasLatency>}
   puts $mig_prj_file {    <mrMode name="Mode">Normal</mrMode>}
   puts $mig_prj_file {    <mrDllReset name="DLL Reset">No</mrDllReset>}
   puts $mig_prj_file {    <mrPdMode name="DLL control for precharge PD">Slow Exit</mrPdMode>}
   puts $mig_prj_file {    <emrDllEnable name="DLL Enable">Enable</emrDllEnable>}
   puts $mig_prj_file {    <emrOutputDriveStrength name="Output Driver Impedance Control">RZQ/7</emrOutputDriveStrength>}
   puts $mig_prj_file {    <emrMirrorSelection name="Address Mirroring">Disable</emrMirrorSelection>}
   puts $mig_prj_file {    <emrCSSelection name="Controller Chip Select Pin">Enable</emrCSSelection>}
   puts $mig_prj_file {    <emrRTT name="RTT (nominal) - On Die Termination (ODT)">RZQ/6</emrRTT>}
   puts $mig_prj_file {    <emrPosted name="Additive Latency (AL)">0</emrPosted>}
   puts $mig_prj_file {    <emrOCD name="Write Leveling Enable">Disabled</emrOCD>}
   puts $mig_prj_file {    <emrDQS name="TDQS enable">Enabled</emrDQS>}
   puts $mig_prj_file {    <emrRDQS name="Qoff">Output Buffer Enabled</emrRDQS>}
   puts $mig_prj_file {    <mr2PartialArraySelfRefresh name="Partial-Array Self Refresh">Full Array</mr2PartialArraySelfRefresh>}
   puts $mig_prj_file {    <mr2CasWriteLatency name="CAS write latency">8</mr2CasWriteLatency>}
   puts $mig_prj_file {    <mr2AutoSelfRefresh name="Auto Self Refresh">Enabled</mr2AutoSelfRefresh>}
   puts $mig_prj_file {    <mr2SelfRefreshTempRange name="High Temparature Self Refresh Rate">Normal</mr2SelfRefreshTempRange>}
   puts $mig_prj_file {    <mr2RTTWR name="RTT_WR - Dynamic On Die Termination (ODT)">Dynamic ODT off</mr2RTTWR>}
   puts $mig_prj_file {    <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {    <AXIParameters>}
   puts $mig_prj_file {      <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {      <C0_S_AXI_ADDR_WIDTH>30</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {      <C0_S_AXI_DATA_WIDTH>256</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {      <C0_S_AXI_ID_WIDTH>3</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {      <C0_S_AXI_SUPPORTS_NARROW_BURST>0</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {    </AXIParameters>}
   puts $mig_prj_file {  </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_microblaze_3_mig_7series_0_0()



##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set cam_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 cam_iic ]

  set cam_pwup [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 cam_pwup ]

  set cama_bta [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 cama_bta ]

  set cama_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 cama_gpio ]

  set ddr3_sdram [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr3_sdram ]

  set dphy_a_hs_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dphy_a_hs_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {336000000} \
   ] $dphy_a_hs_clock

  set dphy_b_hs_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dphy_b_hs_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {336000000} \
   ] $dphy_b_hs_clock

  set dphy_c_hs_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dphy_c_hs_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {336000000} \
   ] $dphy_c_hs_clock

  set dphy_d_hs_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dphy_d_hs_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {336000000} \
   ] $dphy_d_hs_clock

  set fmc_prsnt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 fmc_prsnt ]

  set sys_diff_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_diff_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $sys_diff_clock

  set usb_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart ]


  # Create ports
  set cam_gpio_dir [ create_bd_port -dir O -from 0 -to 0 cam_gpio_dir ]
  set cam_gpio_oen [ create_bd_port -dir O -from 0 -to 0 cam_gpio_oen ]
  set dphy_a_clk_lp_n [ create_bd_port -dir I dphy_a_clk_lp_n ]
  set dphy_a_clk_lp_p [ create_bd_port -dir I dphy_a_clk_lp_p ]
  set dphy_a_data_hs_n [ create_bd_port -dir I -from 1 -to 0 dphy_a_data_hs_n ]
  set dphy_a_data_hs_p [ create_bd_port -dir I -from 1 -to 0 dphy_a_data_hs_p ]
  set dphy_a_data_lp_n [ create_bd_port -dir I -from 1 -to 0 dphy_a_data_lp_n ]
  set dphy_a_data_lp_p [ create_bd_port -dir I -from 1 -to 0 dphy_a_data_lp_p ]
  set dphy_b_clk_lp_n [ create_bd_port -dir I dphy_b_clk_lp_n ]
  set dphy_b_clk_lp_p [ create_bd_port -dir I dphy_b_clk_lp_p ]
  set dphy_b_data_hs_n [ create_bd_port -dir I -from 1 -to 0 dphy_b_data_hs_n ]
  set dphy_b_data_hs_p [ create_bd_port -dir I -from 1 -to 0 dphy_b_data_hs_p ]
  set dphy_b_data_lp_n [ create_bd_port -dir I -from 1 -to 0 dphy_b_data_lp_n ]
  set dphy_b_data_lp_p [ create_bd_port -dir I -from 1 -to 0 dphy_b_data_lp_p ]
  set dphy_c_clk_lp_n [ create_bd_port -dir I dphy_c_clk_lp_n ]
  set dphy_c_clk_lp_p [ create_bd_port -dir I dphy_c_clk_lp_p ]
  set dphy_c_data_hs_n [ create_bd_port -dir I -from 1 -to 0 dphy_c_data_hs_n ]
  set dphy_c_data_hs_p [ create_bd_port -dir I -from 1 -to 0 dphy_c_data_hs_p ]
  set dphy_c_data_lp_n [ create_bd_port -dir I -from 1 -to 0 dphy_c_data_lp_n ]
  set dphy_c_data_lp_p [ create_bd_port -dir I -from 1 -to 0 dphy_c_data_lp_p ]
  set dphy_d_clk_lp_n [ create_bd_port -dir I dphy_d_clk_lp_n ]
  set dphy_d_clk_lp_p [ create_bd_port -dir I dphy_d_clk_lp_p ]
  set dphy_d_data_hs_n [ create_bd_port -dir I -from 1 -to 0 dphy_d_data_hs_n ]
  set dphy_d_data_hs_p [ create_bd_port -dir I -from 1 -to 0 dphy_d_data_hs_p ]
  set dphy_d_data_lp_n [ create_bd_port -dir I -from 1 -to 0 dphy_d_data_lp_n ]
  set dphy_d_data_lp_p [ create_bd_port -dir I -from 1 -to 0 dphy_d_data_lp_p ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $reset
  set vga_pBlue [ create_bd_port -dir O -from 4 -to 0 vga_pBlue ]
  set vga_pGreen [ create_bd_port -dir O -from 5 -to 0 vga_pGreen ]
  set vga_pHSync [ create_bd_port -dir O vga_pHSync ]
  set vga_pRed [ create_bd_port -dir O -from 4 -to 0 vga_pRed ]
  set vga_pVSync [ create_bd_port -dir O vga_pVSync ]

  # Create instance: AXI_BayerToRGB_A, and set properties
  set AXI_BayerToRGB_A [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_BayerToRGB:1.0 AXI_BayerToRGB_A ]

  # Create instance: AXI_BayerToRGB_B, and set properties
  set AXI_BayerToRGB_B [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_BayerToRGB:1.0 AXI_BayerToRGB_B ]

  # Create instance: AXI_BayerToRGB_C, and set properties
  set AXI_BayerToRGB_C [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_BayerToRGB:1.0 AXI_BayerToRGB_C ]

  # Create instance: AXI_BayerToRGB_D, and set properties
  set AXI_BayerToRGB_D [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_BayerToRGB:1.0 AXI_BayerToRGB_D ]

  # Create instance: AXI_GammaCorrection_A, and set properties
  set AXI_GammaCorrection_A [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_GammaCorrection:1.0 AXI_GammaCorrection_A ]

  # Create instance: AXI_GammaCorrection_B, and set properties
  set AXI_GammaCorrection_B [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_GammaCorrection:1.0 AXI_GammaCorrection_B ]

  # Create instance: AXI_GammaCorrection_C, and set properties
  set AXI_GammaCorrection_C [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_GammaCorrection:1.0 AXI_GammaCorrection_C ]

  # Create instance: AXI_GammaCorrection_D, and set properties
  set AXI_GammaCorrection_D [ create_bd_cell -type ip -vlnv digilentinc.com:user:AXI_GammaCorrection:1.0 AXI_GammaCorrection_D ]

  # Create instance: DVIClocking_0, and set properties
  set block_name DVIClocking
  set block_cell_name DVIClocking_0
  if { [catch {set DVIClocking_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $DVIClocking_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MIPI_CSI_2_RX_A, and set properties
  set MIPI_CSI_2_RX_A [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_CSI_2_RX:1.2 MIPI_CSI_2_RX_A ]
  set_property -dict [ list \
   CONFIG.kDebug {false} \
   CONFIG.kGenerateAXIL {true} \
 ] $MIPI_CSI_2_RX_A

  # Create instance: MIPI_CSI_2_RX_B, and set properties
  set MIPI_CSI_2_RX_B [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_CSI_2_RX:1.2 MIPI_CSI_2_RX_B ]
  set_property -dict [ list \
   CONFIG.kGenerateAXIL {true} \
 ] $MIPI_CSI_2_RX_B

  # Create instance: MIPI_CSI_2_RX_C, and set properties
  set MIPI_CSI_2_RX_C [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_CSI_2_RX:1.2 MIPI_CSI_2_RX_C ]
  set_property -dict [ list \
   CONFIG.kGenerateAXIL {true} \
 ] $MIPI_CSI_2_RX_C

  # Create instance: MIPI_CSI_2_RX_D, and set properties
  set MIPI_CSI_2_RX_D [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_CSI_2_RX:1.2 MIPI_CSI_2_RX_D ]
  set_property -dict [ list \
   CONFIG.kGenerateAXIL {true} \
 ] $MIPI_CSI_2_RX_D

  # Create instance: MIPI_D_PHY_RX_A, and set properties
  set MIPI_D_PHY_RX_A [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_D_PHY_RX:1.3 MIPI_D_PHY_RX_A ]
  set_property -dict [ list \
   CONFIG.kDebug {false} \
   CONFIG.kGenerateAXIL {true} \
   CONFIG.kLPFromLane0 {false} \
   CONFIG.kNoOfDataLanes {2} \
 ] $MIPI_D_PHY_RX_A

  # Create instance: MIPI_D_PHY_RX_B, and set properties
  set MIPI_D_PHY_RX_B [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_D_PHY_RX:1.3 MIPI_D_PHY_RX_B ]
  set_property -dict [ list \
   CONFIG.kDebug {false} \
   CONFIG.kGenerateAXIL {true} \
   CONFIG.kLPFromLane0 {false} \
   CONFIG.kSharedLogic {false} \
 ] $MIPI_D_PHY_RX_B

  # Create instance: MIPI_D_PHY_RX_C, and set properties
  set MIPI_D_PHY_RX_C [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_D_PHY_RX:1.3 MIPI_D_PHY_RX_C ]
  set_property -dict [ list \
   CONFIG.kDebug {false} \
   CONFIG.kGenerateAXIL {true} \
   CONFIG.kLPFromLane0 {false} \
   CONFIG.kSharedLogic {false} \
 ] $MIPI_D_PHY_RX_C

  # Create instance: MIPI_D_PHY_RX_D, and set properties
  set MIPI_D_PHY_RX_D [ create_bd_cell -type ip -vlnv digilentinc.com:ip:MIPI_D_PHY_RX:1.3 MIPI_D_PHY_RX_D ]
  set_property -dict [ list \
   CONFIG.kDebug {false} \
   CONFIG.kGenerateAXIL {true} \
   CONFIG.kLPFromLane0 {false} \
   CONFIG.kSharedLogic {false} \
 ] $MIPI_D_PHY_RX_D

  # Create instance: axi_cama_bta, and set properties
  set axi_cama_bta [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_cama_bta ]
  set_property -dict [ list \
   CONFIG.C_GPIO_WIDTH {4} \
 ] $axi_cama_bta

  # Create instance: axi_cama_gpio, and set properties
  set axi_cama_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_cama_gpio ]
  set_property -dict [ list \
   CONFIG.C_GPIO_WIDTH {4} \
 ] $axi_cama_gpio

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]
  set_property -dict [ list \
   CONFIG.C_SCL_INERTIAL_DELAY {2} \
   CONFIG.C_SDA_INERTIAL_DELAY {2} \
   CONFIG.IIC_FREQ_KHZ {400} \
 ] $axi_iic_0

  # Create instance: axi_pwup_prsnt_gpio, and set properties
  set axi_pwup_prsnt_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_pwup_prsnt_gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {0} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {0} \
   CONFIG.C_GPIO2_WIDTH {1} \
   CONFIG.C_GPIO_WIDTH {1} \
   CONFIG.C_INTERRUPT_PRESENT {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_pwup_prsnt_gpio

  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [ list \
   CONFIG.NUM_CLKS {1} \
   CONFIG.NUM_SI {7} \
 ] $axi_smc

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
   CONFIG.UARTLITE_BOARD_INTERFACE {usb_uart} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_uartlite_0

  # Create instance: axi_vdma_a, and set properties
  set axi_vdma_a [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_a ]
  set_property -dict [ list \
   CONFIG.C_FAMILY {zynq} \
   CONFIG.c_enable_mm2s_frmstr_reg {1} \
   CONFIG.c_enable_s2mm_frmstr_reg {1} \
   CONFIG.c_enable_s2mm_sts_reg {1} \
   CONFIG.c_include_mm2s_dre {0} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_m_axis_mm2s_tdata_width {24} \
   CONFIG.c_mm2s_genlock_mode {1} \
   CONFIG.c_mm2s_genlock_num_masters {4} \
   CONFIG.c_mm2s_linebuffer_depth {1024} \
   CONFIG.c_num_fstores {5} \
   CONFIG.c_s2mm_genlock_mode {0} \
   CONFIG.c_s2mm_linebuffer_depth {1024} \
 ] $axi_vdma_a

  # Create instance: axi_vdma_b, and set properties
  set axi_vdma_b [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_b ]
  set_property -dict [ list \
   CONFIG.C_FAMILY {zynq} \
   CONFIG.c_enable_s2mm_frmstr_reg {1} \
   CONFIG.c_enable_s2mm_sts_reg {1} \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_mm2s_dre {0} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_genlock_mode {0} \
   CONFIG.c_mm2s_linebuffer_depth {512} \
   CONFIG.c_num_fstores {5} \
   CONFIG.c_s2mm_genlock_mode {0} \
   CONFIG.c_s2mm_linebuffer_depth {1024} \
 ] $axi_vdma_b

  # Create instance: axi_vdma_c, and set properties
  set axi_vdma_c [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_c ]
  set_property -dict [ list \
   CONFIG.C_FAMILY {zynq} \
   CONFIG.c_enable_s2mm_frmstr_reg {1} \
   CONFIG.c_enable_s2mm_sts_reg {1} \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_mm2s_dre {0} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_genlock_mode {0} \
   CONFIG.c_mm2s_linebuffer_depth {512} \
   CONFIG.c_num_fstores {5} \
   CONFIG.c_s2mm_genlock_mode {0} \
   CONFIG.c_s2mm_linebuffer_depth {1024} \
 ] $axi_vdma_c

  # Create instance: axi_vdma_d, and set properties
  set axi_vdma_d [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_d ]
  set_property -dict [ list \
   CONFIG.C_FAMILY {zynq} \
   CONFIG.c_enable_s2mm_frmstr_reg {1} \
   CONFIG.c_enable_s2mm_sts_reg {1} \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_mm2s_dre {0} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_genlock_mode {0} \
   CONFIG.c_mm2s_linebuffer_depth {512} \
   CONFIG.c_num_fstores {5} \
   CONFIG.c_s2mm_genlock_mode {0} \
   CONFIG.c_s2mm_linebuffer_depth {1024} \
 ] $axi_vdma_d

  # Create instance: cama_gpio_dir, and set properties
  set cama_gpio_dir [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 cama_gpio_dir ]

  # Create instance: cama_gpio_oen, and set properties
  set cama_gpio_oen [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 cama_gpio_oen ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $cama_gpio_oen

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_CACHE_BYTE_SIZE {65536} \
   CONFIG.C_DCACHE_BYTE_SIZE {65536} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_ILL_OPCODE_EXCEPTION {1} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_M_AXI_D_BUS_EXCEPTION {1} \
   CONFIG.C_M_AXI_I_BUS_EXCEPTION {1} \
   CONFIG.C_OPCODE_0x0_ILLEGAL {1} \
   CONFIG.C_UNALIGNED_EXCEPTIONS {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_ICACHE {1} \
   CONFIG.C_USE_STACK_PROTECTION {1} \
   CONFIG.G_USE_EXCEPTIONS {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {28} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {9} \
 ] $microblaze_0_xlconcat

  # Create instance: mig_7series_0, and set properties
  set mig_7series_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.2 mig_7series_0 ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $mig_7series_0 ] ] ]
  set str_mig_file_name mig_b.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_microblaze_3_mig_7series_0_0 $str_mig_file_path

  set_property -dict [ list \
   CONFIG.BOARD_MIG_PARAM {ddr3_sdram} \
   CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
   CONFIG.RESET_BOARD_INTERFACE {reset} \
   CONFIG.XML_INPUT_FILE {mig_b.prj} \
 ] $mig_7series_0

  # Create instance: rgb2vga_0, and set properties
  set rgb2vga_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2vga:1.0 rgb2vga_0 ]
  set_property -dict [ list \
   CONFIG.kBlueDepth {5} \
   CONFIG.kGreenDepth {6} \
   CONFIG.kRedDepth {5} \
 ] $rgb2vga_0

  # Create instance: rst_clk_wiz_0_50M, and set properties
  set rst_clk_wiz_0_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_50M ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_clk_wiz_0_50M

  # Create instance: rst_clk_wiz_0_ui_addn0, and set properties
  set rst_clk_wiz_0_ui_addn0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_ui_addn0 ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_clk_wiz_0_ui_addn0

  # Create instance: rst_clk_wiz_0_ui_addn1, and set properties
  set rst_clk_wiz_0_ui_addn1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_ui_addn1 ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
 ] $rst_clk_wiz_0_ui_addn1

  # Create instance: rst_mig_7series_0_ui_clk, and set properties
  set rst_mig_7series_0_ui_clk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_mig_7series_0_ui_clk ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_mig_7series_0_ui_clk

  # Create instance: rst_vid_clk_dyn, and set properties
  set rst_vid_clk_dyn [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_vid_clk_dyn ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_vid_clk_dyn

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
   CONFIG.C_HAS_ASYNC_CLK {1} \
   CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: video_dynclk, and set properties
  set video_dynclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 video_dynclk ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {50.0} \
   CONFIG.CLKOUT1_DRIVES {No_buffer} \
   CONFIG.CLKOUT1_JITTER {230.050} \
   CONFIG.CLKOUT1_PHASE_ERROR {322.999} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {742.5} \
   CONFIG.CLKOUT2_DRIVES {BUFG} \
   CONFIG.CLKOUT3_DRIVES {BUFG} \
   CONFIG.CLKOUT4_DRIVES {BUFG} \
   CONFIG.CLKOUT5_DRIVES {BUFG} \
   CONFIG.CLKOUT6_DRIVES {BUFG} \
   CONFIG.CLKOUT7_DRIVES {BUFG} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {Custom} \
   CONFIG.CLK_OUT1_PORT {pxl_clk_5x} \
   CONFIG.FEEDBACK_SOURCE {FDBK_ONCHIP} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {37.125} \
   CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {1.000} \
   CONFIG.MMCM_DIVCLK_DIVIDE {10} \
   CONFIG.PRIM_SOURCE {Global_buffer} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_FREQ_SYNTH {true} \
   CONFIG.USE_PHASE_ALIGNMENT {false} \
 ] $video_dynclk

  # Create instance: video_scaler_a, and set properties
  set video_scaler_a [ create_bd_cell -type ip -vlnv digilentinc.com:video:video_scaler:1.0 video_scaler_a ]

  # Create instance: video_scaler_b, and set properties
  set video_scaler_b [ create_bd_cell -type ip -vlnv digilentinc.com:video:video_scaler:1.0 video_scaler_b ]

  # Create instance: video_scaler_c, and set properties
  set video_scaler_c [ create_bd_cell -type ip -vlnv digilentinc.com:video:video_scaler:1.0 video_scaler_c ]

  # Create instance: video_scaler_d, and set properties
  set video_scaler_d [ create_bd_cell -type ip -vlnv digilentinc.com:video:video_scaler:1.0 video_scaler_d ]

  # Create instance: vtg, and set properties
  set vtg [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.2 vtg ]
  set_property -dict [ list \
   CONFIG.GEN_F0_VBLANK_HEND {640} \
   CONFIG.GEN_F0_VBLANK_HSTART {640} \
   CONFIG.GEN_F0_VFRAME_SIZE {750} \
   CONFIG.GEN_F0_VSYNC_HEND {695} \
   CONFIG.GEN_F0_VSYNC_HSTART {640} \
   CONFIG.GEN_F0_VSYNC_VEND {729} \
   CONFIG.GEN_F0_VSYNC_VSTART {724} \
   CONFIG.GEN_F1_VBLANK_HEND {640} \
   CONFIG.GEN_F1_VBLANK_HSTART {640} \
   CONFIG.GEN_F1_VFRAME_SIZE {750} \
   CONFIG.GEN_F1_VSYNC_HEND {695} \
   CONFIG.GEN_F1_VSYNC_HSTART {695} \
   CONFIG.GEN_F1_VSYNC_VEND {729} \
   CONFIG.GEN_F1_VSYNC_VSTART {724} \
   CONFIG.GEN_HACTIVE_SIZE {1280} \
   CONFIG.GEN_HFRAME_SIZE {1650} \
   CONFIG.GEN_HSYNC_END {1430} \
   CONFIG.GEN_HSYNC_START {1390} \
   CONFIG.GEN_VACTIVE_SIZE {720} \
   CONFIG.VIDEO_MODE {720p} \
   CONFIG.enable_detection {false} \
 ] $vtg

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_1

  # Create interface connections
  connect_bd_intf_net -intf_net AXI_BayerToRGB_0_AXI_Stream_Master [get_bd_intf_pins AXI_BayerToRGB_B/AXI_Stream_Master] [get_bd_intf_pins AXI_GammaCorrection_B/AXI_Slave_Interface]
  connect_bd_intf_net -intf_net AXI_BayerToRGB_1_AXI_Stream_Master [get_bd_intf_pins AXI_BayerToRGB_A/AXI_Stream_Master] [get_bd_intf_pins AXI_GammaCorrection_A/AXI_Slave_Interface]
  connect_bd_intf_net -intf_net AXI_BayerToRGB_2_AXI_Stream_Master [get_bd_intf_pins AXI_BayerToRGB_C/AXI_Stream_Master] [get_bd_intf_pins AXI_GammaCorrection_C/AXI_Slave_Interface]
  connect_bd_intf_net -intf_net AXI_BayerToRGB_3_AXI_Stream_Master [get_bd_intf_pins AXI_BayerToRGB_D/AXI_Stream_Master] [get_bd_intf_pins AXI_GammaCorrection_D/AXI_Slave_Interface]
  connect_bd_intf_net -intf_net AXI_GammaCorrection_A_AXI_Stream_Master [get_bd_intf_pins AXI_GammaCorrection_A/AXI_Stream_Master] [get_bd_intf_pins video_scaler_a/stream_in]
  connect_bd_intf_net -intf_net AXI_GammaCorrection_B_AXI_Stream_Master [get_bd_intf_pins AXI_GammaCorrection_B/AXI_Stream_Master] [get_bd_intf_pins video_scaler_b/stream_in]
  connect_bd_intf_net -intf_net AXI_GammaCorrection_C_AXI_Stream_Master [get_bd_intf_pins AXI_GammaCorrection_C/AXI_Stream_Master] [get_bd_intf_pins video_scaler_c/stream_in]
  connect_bd_intf_net -intf_net AXI_GammaCorrection_D_AXI_Stream_Master [get_bd_intf_pins AXI_GammaCorrection_D/AXI_Stream_Master] [get_bd_intf_pins video_scaler_d/stream_in]
  connect_bd_intf_net -intf_net MIPI_CSI_2_RX_0_m_axis_video [get_bd_intf_pins AXI_BayerToRGB_A/AXI_Slave_Interface] [get_bd_intf_pins MIPI_CSI_2_RX_A/m_axis_video]
  connect_bd_intf_net -intf_net MIPI_CSI_2_RX_1_m_axis_video [get_bd_intf_pins AXI_BayerToRGB_B/AXI_Slave_Interface] [get_bd_intf_pins MIPI_CSI_2_RX_B/m_axis_video]
  connect_bd_intf_net -intf_net MIPI_CSI_2_RX_2_m_axis_video [get_bd_intf_pins AXI_BayerToRGB_C/AXI_Slave_Interface] [get_bd_intf_pins MIPI_CSI_2_RX_C/m_axis_video]
  connect_bd_intf_net -intf_net MIPI_CSI_2_RX_3_m_axis_video [get_bd_intf_pins AXI_BayerToRGB_D/AXI_Slave_Interface] [get_bd_intf_pins MIPI_CSI_2_RX_D/m_axis_video]
  connect_bd_intf_net -intf_net MIPI_D_PHY_RX_0_D_PHY_PPI [get_bd_intf_pins MIPI_CSI_2_RX_A/rx_mipi_ppi] [get_bd_intf_pins MIPI_D_PHY_RX_A/D_PHY_PPI]
  connect_bd_intf_net -intf_net MIPI_D_PHY_RX_1_D_PHY_PPI [get_bd_intf_pins MIPI_CSI_2_RX_B/rx_mipi_ppi] [get_bd_intf_pins MIPI_D_PHY_RX_B/D_PHY_PPI]
  connect_bd_intf_net -intf_net MIPI_D_PHY_RX_2_D_PHY_PPI [get_bd_intf_pins MIPI_CSI_2_RX_C/rx_mipi_ppi] [get_bd_intf_pins MIPI_D_PHY_RX_C/D_PHY_PPI]
  connect_bd_intf_net -intf_net MIPI_D_PHY_RX_3_D_PHY_PPI [get_bd_intf_pins MIPI_CSI_2_RX_D/rx_mipi_ppi] [get_bd_intf_pins MIPI_D_PHY_RX_D/D_PHY_PPI]
  connect_bd_intf_net -intf_net axi_cama_bta_GPIO [get_bd_intf_ports cama_bta] [get_bd_intf_pins axi_cama_bta/GPIO]
  connect_bd_intf_net -intf_net axi_cama_gpio_GPIO [get_bd_intf_ports cama_gpio] [get_bd_intf_pins axi_cama_gpio/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports cam_pwup] [get_bd_intf_pins axi_pwup_prsnt_gpio/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports fmc_prsnt] [get_bd_intf_pins axi_pwup_prsnt_gpio/GPIO2]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports cam_iic] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins mig_7series_0/S_AXI]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports usb_uart] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_a/M_AXIS_MM2S] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net axi_vdma_a_M_AXI_MM2S [get_bd_intf_pins axi_smc/S02_AXI] [get_bd_intf_pins axi_vdma_a/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_a_M_AXI_S2MM [get_bd_intf_pins axi_smc/S03_AXI] [get_bd_intf_pins axi_vdma_a/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_b_M_AXI_S2MM [get_bd_intf_pins axi_smc/S04_AXI] [get_bd_intf_pins axi_vdma_b/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_c_M_AXI_S2MM [get_bd_intf_pins axi_smc/S05_AXI] [get_bd_intf_pins axi_vdma_c/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_vdma_d_M_AXI_S2MM [get_bd_intf_pins axi_smc/S06_AXI] [get_bd_intf_pins axi_vdma_d/M_AXI_S2MM]
  connect_bd_intf_net -intf_net dphy_hs_clock_0_1 [get_bd_intf_ports dphy_b_hs_clock] [get_bd_intf_pins MIPI_D_PHY_RX_B/dphy_hs_clock]
  connect_bd_intf_net -intf_net dphy_hs_clock_1 [get_bd_intf_ports dphy_a_hs_clock] [get_bd_intf_pins MIPI_D_PHY_RX_A/dphy_hs_clock]
  connect_bd_intf_net -intf_net dphy_hs_clock_1_1 [get_bd_intf_ports dphy_c_hs_clock] [get_bd_intf_pins MIPI_D_PHY_RX_C/dphy_hs_clock]
  connect_bd_intf_net -intf_net dphy_hs_clock_2_1 [get_bd_intf_ports dphy_d_hs_clock] [get_bd_intf_pins MIPI_D_PHY_RX_D/dphy_hs_clock]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DC [get_bd_intf_pins axi_smc/S00_AXI] [get_bd_intf_pins microblaze_0/M_AXI_DC]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_IC [get_bd_intf_pins axi_smc/S01_AXI] [get_bd_intf_pins microblaze_0/M_AXI_IC]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins axi_cama_bta/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_cama_gpio/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins AXI_GammaCorrection_A/AXI_Lite_Reg_Intf] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins AXI_GammaCorrection_B/AXI_Lite_Reg_Intf] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins AXI_GammaCorrection_C/AXI_Lite_Reg_Intf] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins AXI_GammaCorrection_D/AXI_Lite_Reg_Intf] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins axi_pwup_prsnt_gpio/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M08_AXI [get_bd_intf_pins axi_vdma_a/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M09_AXI [get_bd_intf_pins axi_vdma_b/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M10_AXI [get_bd_intf_pins axi_vdma_c/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M11_AXI [get_bd_intf_pins axi_vdma_d/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M11_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M12_AXI [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M12_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M13_AXI [get_bd_intf_pins MIPI_CSI_2_RX_A/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M13_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M14_AXI [get_bd_intf_pins MIPI_CSI_2_RX_B/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M14_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M15_AXI [get_bd_intf_pins MIPI_CSI_2_RX_C/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M15_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M16_AXI [get_bd_intf_pins MIPI_CSI_2_RX_D/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M16_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M17_AXI [get_bd_intf_pins MIPI_D_PHY_RX_A/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M17_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M18_AXI [get_bd_intf_pins MIPI_D_PHY_RX_B/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M18_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M19_AXI [get_bd_intf_pins MIPI_D_PHY_RX_C/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M19_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M20_AXI [get_bd_intf_pins MIPI_D_PHY_RX_D/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M20_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M21_AXI [get_bd_intf_pins microblaze_0_axi_periph/M21_AXI] [get_bd_intf_pins video_dynclk/s_axi_lite]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M22_AXI [get_bd_intf_pins microblaze_0_axi_periph/M22_AXI] [get_bd_intf_pins video_scaler_a/s_axi_ctrl]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M23_AXI [get_bd_intf_pins microblaze_0_axi_periph/M23_AXI] [get_bd_intf_pins video_scaler_b/s_axi_ctrl]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M24_AXI [get_bd_intf_pins microblaze_0_axi_periph/M24_AXI] [get_bd_intf_pins video_scaler_c/s_axi_ctrl]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M25_AXI [get_bd_intf_pins microblaze_0_axi_periph/M25_AXI] [get_bd_intf_pins video_scaler_d/s_axi_ctrl]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M26_AXI [get_bd_intf_pins microblaze_0_axi_periph/M26_AXI] [get_bd_intf_pins vtg/ctrl]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M27_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M27_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net mig_7series_0_DDR3 [get_bd_intf_ports ddr3_sdram] [get_bd_intf_pins mig_7series_0/DDR3]
  connect_bd_intf_net -intf_net sys_diff_clock_1 [get_bd_intf_ports sys_diff_clock] [get_bd_intf_pins mig_7series_0/SYS_CLK]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins rgb2vga_0/vid_in] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins vtg/vtiming_out]
  connect_bd_intf_net -intf_net video_scaler_0_stream_out [get_bd_intf_pins axi_vdma_a/S_AXIS_S2MM] [get_bd_intf_pins video_scaler_a/stream_out]
  connect_bd_intf_net -intf_net video_scaler_b_stream_out [get_bd_intf_pins axi_vdma_b/S_AXIS_S2MM] [get_bd_intf_pins video_scaler_b/stream_out]
  connect_bd_intf_net -intf_net video_scaler_c_stream_out [get_bd_intf_pins axi_vdma_c/S_AXIS_S2MM] [get_bd_intf_pins video_scaler_c/stream_out]
  connect_bd_intf_net -intf_net video_scaler_d_stream_out [get_bd_intf_pins axi_vdma_d/S_AXIS_S2MM] [get_bd_intf_pins video_scaler_d/stream_out]

  # Create port connections
  connect_bd_net -net DVIClocking_0_aLockedOut [get_bd_pins DVIClocking_0/aLockedOut] [get_bd_pins rst_vid_clk_dyn/dcm_locked]
  connect_bd_net -net MIPI_D_PHY_RX_0_RxByteClkHS [get_bd_pins MIPI_CSI_2_RX_A/RxByteClkHS] [get_bd_pins MIPI_D_PHY_RX_A/RxByteClkHS]
  connect_bd_net -net MIPI_D_PHY_RX_0_rDlyCtrlLockedOut [get_bd_pins MIPI_D_PHY_RX_A/rDlyCtrlLockedOut] [get_bd_pins MIPI_D_PHY_RX_B/rDlyCtrlLockedIn] [get_bd_pins MIPI_D_PHY_RX_C/rDlyCtrlLockedIn] [get_bd_pins MIPI_D_PHY_RX_D/rDlyCtrlLockedIn]
  connect_bd_net -net MIPI_D_PHY_RX_1_RxByteClkHS [get_bd_pins MIPI_CSI_2_RX_B/RxByteClkHS] [get_bd_pins MIPI_D_PHY_RX_B/RxByteClkHS]
  connect_bd_net -net MIPI_D_PHY_RX_2_RxByteClkHS [get_bd_pins MIPI_CSI_2_RX_C/RxByteClkHS] [get_bd_pins MIPI_D_PHY_RX_C/RxByteClkHS]
  connect_bd_net -net MIPI_D_PHY_RX_3_RxByteClkHS [get_bd_pins MIPI_CSI_2_RX_D/RxByteClkHS] [get_bd_pins MIPI_D_PHY_RX_D/RxByteClkHS]
  connect_bd_net -net PixelClk_Generator_clk_out1 [get_bd_pins DVIClocking_0/PixelClk] [get_bd_pins rgb2vga_0/PixelClk] [get_bd_pins rst_vid_clk_dyn/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins vtg/clk]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In6]
  connect_bd_net -net axi_pwup_prsnt_gpio_ip2intc_irpt [get_bd_pins axi_pwup_prsnt_gpio/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In7]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In8]
  connect_bd_net -net axi_vdma_a_mm2s_introut [get_bd_pins axi_vdma_a/mm2s_introut] [get_bd_pins microblaze_0_xlconcat/In1]
  connect_bd_net -net axi_vdma_a_s2mm_frame_ptr_out [get_bd_pins axi_vdma_a/s2mm_frame_ptr_out] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net axi_vdma_a_s2mm_introut [get_bd_pins axi_vdma_a/s2mm_introut] [get_bd_pins microblaze_0_xlconcat/In2]
  connect_bd_net -net axi_vdma_b_s2mm_frame_ptr_out [get_bd_pins axi_vdma_b/s2mm_frame_ptr_out] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net axi_vdma_b_s2mm_introut [get_bd_pins axi_vdma_b/s2mm_introut] [get_bd_pins microblaze_0_xlconcat/In3]
  connect_bd_net -net axi_vdma_c_s2mm_frame_ptr_out [get_bd_pins axi_vdma_c/s2mm_frame_ptr_out] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net axi_vdma_c_s2mm_introut [get_bd_pins axi_vdma_c/s2mm_introut] [get_bd_pins microblaze_0_xlconcat/In4]
  connect_bd_net -net axi_vdma_d_s2mm_frame_ptr_out [get_bd_pins axi_vdma_d/s2mm_frame_ptr_out] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net axi_vdma_d_s2mm_introut [get_bd_pins axi_vdma_d/s2mm_introut] [get_bd_pins microblaze_0_xlconcat/In5]
  connect_bd_net -net cama_gpio_dir_dout [get_bd_ports cam_gpio_dir] [get_bd_pins cama_gpio_dir/dout]
  connect_bd_net -net cama_gpio_oen_dout [get_bd_ports cam_gpio_oen] [get_bd_pins cama_gpio_oen/dout]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins DVIClocking_0/aLockedIn] [get_bd_pins video_dynclk/locked]
  connect_bd_net -net clk_wiz_1_pxl_clk_5x [get_bd_pins DVIClocking_0/PixelClk5X] [get_bd_pins video_dynclk/pxl_clk_5x]
  connect_bd_net -net dphy_clk_lp_n_0_1 [get_bd_ports dphy_b_clk_lp_n] [get_bd_pins MIPI_D_PHY_RX_B/dphy_clk_lp_n]
  connect_bd_net -net dphy_clk_lp_n_1 [get_bd_ports dphy_a_clk_lp_n] [get_bd_pins MIPI_D_PHY_RX_A/dphy_clk_lp_n]
  connect_bd_net -net dphy_clk_lp_n_1_1 [get_bd_ports dphy_c_clk_lp_n] [get_bd_pins MIPI_D_PHY_RX_C/dphy_clk_lp_n]
  connect_bd_net -net dphy_clk_lp_n_2_1 [get_bd_ports dphy_d_clk_lp_n] [get_bd_pins MIPI_D_PHY_RX_D/dphy_clk_lp_n]
  connect_bd_net -net dphy_clk_lp_p_0_1 [get_bd_ports dphy_b_clk_lp_p] [get_bd_pins MIPI_D_PHY_RX_B/dphy_clk_lp_p]
  connect_bd_net -net dphy_clk_lp_p_1 [get_bd_ports dphy_a_clk_lp_p] [get_bd_pins MIPI_D_PHY_RX_A/dphy_clk_lp_p]
  connect_bd_net -net dphy_clk_lp_p_1_1 [get_bd_ports dphy_c_clk_lp_p] [get_bd_pins MIPI_D_PHY_RX_C/dphy_clk_lp_p]
  connect_bd_net -net dphy_clk_lp_p_2_1 [get_bd_ports dphy_d_clk_lp_p] [get_bd_pins MIPI_D_PHY_RX_D/dphy_clk_lp_p]
  connect_bd_net -net dphy_data_hs_n_0_1 [get_bd_ports dphy_b_data_hs_n] [get_bd_pins MIPI_D_PHY_RX_B/dphy_data_hs_n]
  connect_bd_net -net dphy_data_hs_n_1 [get_bd_ports dphy_a_data_hs_n] [get_bd_pins MIPI_D_PHY_RX_A/dphy_data_hs_n]
  connect_bd_net -net dphy_data_hs_n_1_1 [get_bd_ports dphy_c_data_hs_n] [get_bd_pins MIPI_D_PHY_RX_C/dphy_data_hs_n]
  connect_bd_net -net dphy_data_hs_n_2_1 [get_bd_ports dphy_d_data_hs_n] [get_bd_pins MIPI_D_PHY_RX_D/dphy_data_hs_n]
  connect_bd_net -net dphy_data_hs_p_0_1 [get_bd_ports dphy_b_data_hs_p] [get_bd_pins MIPI_D_PHY_RX_B/dphy_data_hs_p]
  connect_bd_net -net dphy_data_hs_p_1 [get_bd_ports dphy_a_data_hs_p] [get_bd_pins MIPI_D_PHY_RX_A/dphy_data_hs_p]
  connect_bd_net -net dphy_data_hs_p_1_1 [get_bd_ports dphy_c_data_hs_p] [get_bd_pins MIPI_D_PHY_RX_C/dphy_data_hs_p]
  connect_bd_net -net dphy_data_hs_p_2_1 [get_bd_ports dphy_d_data_hs_p] [get_bd_pins MIPI_D_PHY_RX_D/dphy_data_hs_p]
  connect_bd_net -net dphy_data_lp_n_0_1 [get_bd_ports dphy_b_data_lp_n] [get_bd_pins MIPI_D_PHY_RX_B/dphy_data_lp_n]
  connect_bd_net -net dphy_data_lp_n_1 [get_bd_ports dphy_a_data_lp_n] [get_bd_pins MIPI_D_PHY_RX_A/dphy_data_lp_n]
  connect_bd_net -net dphy_data_lp_n_1_1 [get_bd_ports dphy_c_data_lp_n] [get_bd_pins MIPI_D_PHY_RX_C/dphy_data_lp_n]
  connect_bd_net -net dphy_data_lp_n_2_1 [get_bd_ports dphy_d_data_lp_n] [get_bd_pins MIPI_D_PHY_RX_D/dphy_data_lp_n]
  connect_bd_net -net dphy_data_lp_p_0_1 [get_bd_ports dphy_b_data_lp_p] [get_bd_pins MIPI_D_PHY_RX_B/dphy_data_lp_p]
  connect_bd_net -net dphy_data_lp_p_1 [get_bd_ports dphy_a_data_lp_p] [get_bd_pins MIPI_D_PHY_RX_A/dphy_data_lp_p]
  connect_bd_net -net dphy_data_lp_p_1_1 [get_bd_ports dphy_c_data_lp_p] [get_bd_pins MIPI_D_PHY_RX_C/dphy_data_lp_p]
  connect_bd_net -net dphy_data_lp_p_2_1 [get_bd_ports dphy_d_data_lp_p] [get_bd_pins MIPI_D_PHY_RX_D/dphy_data_lp_p]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_0_50M/mb_debug_sys_rst] [get_bd_pins rst_clk_wiz_0_ui_addn0/mb_debug_sys_rst] [get_bd_pins rst_clk_wiz_0_ui_addn1/mb_debug_sys_rst] [get_bd_pins rst_mig_7series_0_ui_clk/mb_debug_sys_rst] [get_bd_pins rst_vid_clk_dyn/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_smc/aclk] [get_bd_pins axi_vdma_a/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_a/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_b/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_c/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_d/m_axi_s2mm_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M12_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins mig_7series_0/ui_clk] [get_bd_pins rst_mig_7series_0_ui_clk/slowest_sync_clk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net mig_7series_0_mmcm_locked [get_bd_pins mig_7series_0/mmcm_locked] [get_bd_pins rst_clk_wiz_0_50M/dcm_locked] [get_bd_pins rst_clk_wiz_0_ui_addn0/dcm_locked] [get_bd_pins rst_clk_wiz_0_ui_addn1/dcm_locked] [get_bd_pins rst_mig_7series_0_ui_clk/dcm_locked]
  connect_bd_net -net mm_clk_150 [get_bd_pins AXI_BayerToRGB_A/StreamClk] [get_bd_pins AXI_BayerToRGB_B/StreamClk] [get_bd_pins AXI_BayerToRGB_C/StreamClk] [get_bd_pins AXI_BayerToRGB_D/StreamClk] [get_bd_pins AXI_GammaCorrection_A/StreamClk] [get_bd_pins AXI_GammaCorrection_B/StreamClk] [get_bd_pins AXI_GammaCorrection_C/StreamClk] [get_bd_pins AXI_GammaCorrection_D/StreamClk] [get_bd_pins MIPI_CSI_2_RX_A/video_aclk] [get_bd_pins MIPI_CSI_2_RX_B/video_aclk] [get_bd_pins MIPI_CSI_2_RX_C/video_aclk] [get_bd_pins MIPI_CSI_2_RX_D/video_aclk] [get_bd_pins axi_vdma_a/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_a/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_b/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_c/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_d/s_axis_s2mm_aclk] [get_bd_pins microblaze_0_axi_periph/M22_ACLK] [get_bd_pins microblaze_0_axi_periph/M23_ACLK] [get_bd_pins microblaze_0_axi_periph/M24_ACLK] [get_bd_pins microblaze_0_axi_periph/M25_ACLK] [get_bd_pins mig_7series_0/ui_addn_clk_0] [get_bd_pins rst_clk_wiz_0_ui_addn0/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins video_scaler_a/ap_clk] [get_bd_pins video_scaler_b/ap_clk] [get_bd_pins video_scaler_c/ap_clk] [get_bd_pins video_scaler_d/ap_clk]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins MIPI_D_PHY_RX_A/aRst] [get_bd_pins MIPI_D_PHY_RX_B/aRst] [get_bd_pins MIPI_D_PHY_RX_C/aRst] [get_bd_pins MIPI_D_PHY_RX_D/aRst] [get_bd_pins rst_clk_wiz_0_ui_addn1/peripheral_reset]
  connect_bd_net -net ref_clk_200 [get_bd_pins MIPI_D_PHY_RX_A/RefClk] [get_bd_pins MIPI_D_PHY_RX_B/RefClk] [get_bd_pins MIPI_D_PHY_RX_C/RefClk] [get_bd_pins MIPI_D_PHY_RX_D/RefClk] [get_bd_pins mig_7series_0/clk_ref_i] [get_bd_pins mig_7series_0/ui_addn_clk_1] [get_bd_pins rst_clk_wiz_0_ui_addn1/slowest_sync_clk] [get_bd_pins video_dynclk/clk_in1]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins mig_7series_0/sys_rst] [get_bd_pins rst_clk_wiz_0_50M/ext_reset_in] [get_bd_pins rst_clk_wiz_0_ui_addn0/ext_reset_in] [get_bd_pins rst_clk_wiz_0_ui_addn1/ext_reset_in] [get_bd_pins rst_mig_7series_0_ui_clk/ext_reset_in] [get_bd_pins rst_vid_clk_dyn/ext_reset_in]
  connect_bd_net -net rgb2vga_0_vga_pBlue [get_bd_ports vga_pBlue] [get_bd_pins rgb2vga_0/vga_pBlue]
  connect_bd_net -net rgb2vga_0_vga_pGreen [get_bd_ports vga_pGreen] [get_bd_pins rgb2vga_0/vga_pGreen]
  connect_bd_net -net rgb2vga_0_vga_pHSync [get_bd_ports vga_pHSync] [get_bd_pins rgb2vga_0/vga_pHSync]
  connect_bd_net -net rgb2vga_0_vga_pRed [get_bd_ports vga_pRed] [get_bd_pins rgb2vga_0/vga_pRed]
  connect_bd_net -net rgb2vga_0_vga_pVSync [get_bd_ports vga_pVSync] [get_bd_pins rgb2vga_0/vga_pVSync]
  connect_bd_net -net rst_clk_wiz_0_150M_peripheral_aresetn [get_bd_pins AXI_BayerToRGB_A/sStreamReset_n] [get_bd_pins AXI_BayerToRGB_B/sStreamReset_n] [get_bd_pins AXI_BayerToRGB_C/sStreamReset_n] [get_bd_pins AXI_BayerToRGB_D/sStreamReset_n] [get_bd_pins AXI_GammaCorrection_A/sStreamReset_n] [get_bd_pins AXI_GammaCorrection_B/sStreamReset_n] [get_bd_pins AXI_GammaCorrection_C/sStreamReset_n] [get_bd_pins AXI_GammaCorrection_D/sStreamReset_n] [get_bd_pins microblaze_0_axi_periph/M22_ARESETN] [get_bd_pins microblaze_0_axi_periph/M23_ARESETN] [get_bd_pins microblaze_0_axi_periph/M24_ARESETN] [get_bd_pins microblaze_0_axi_periph/M25_ARESETN] [get_bd_pins rst_clk_wiz_0_ui_addn0/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins video_scaler_a/ap_rst_n] [get_bd_pins video_scaler_b/ap_rst_n] [get_bd_pins video_scaler_c/ap_rst_n] [get_bd_pins video_scaler_d/ap_rst_n]
  connect_bd_net -net rst_clk_wiz_0_50M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins rst_clk_wiz_0_50M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_0_50M_peripheral_aresetn [get_bd_pins AXI_GammaCorrection_A/aAxiLiteReset_n] [get_bd_pins AXI_GammaCorrection_B/aAxiLiteReset_n] [get_bd_pins AXI_GammaCorrection_C/aAxiLiteReset_n] [get_bd_pins AXI_GammaCorrection_D/aAxiLiteReset_n] [get_bd_pins MIPI_CSI_2_RX_A/s_axi_lite_aresetn] [get_bd_pins MIPI_CSI_2_RX_B/s_axi_lite_aresetn] [get_bd_pins MIPI_CSI_2_RX_C/s_axi_lite_aresetn] [get_bd_pins MIPI_CSI_2_RX_D/s_axi_lite_aresetn] [get_bd_pins MIPI_D_PHY_RX_A/s_axi_lite_aresetn] [get_bd_pins MIPI_D_PHY_RX_B/s_axi_lite_aresetn] [get_bd_pins MIPI_D_PHY_RX_C/s_axi_lite_aresetn] [get_bd_pins MIPI_D_PHY_RX_D/s_axi_lite_aresetn] [get_bd_pins axi_cama_bta/s_axi_aresetn] [get_bd_pins axi_cama_gpio/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_pwup_prsnt_gpio/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axi_vdma_a/axi_resetn] [get_bd_pins axi_vdma_b/axi_resetn] [get_bd_pins axi_vdma_c/axi_resetn] [get_bd_pins axi_vdma_d/axi_resetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/M11_ARESETN] [get_bd_pins microblaze_0_axi_periph/M13_ARESETN] [get_bd_pins microblaze_0_axi_periph/M14_ARESETN] [get_bd_pins microblaze_0_axi_periph/M15_ARESETN] [get_bd_pins microblaze_0_axi_periph/M16_ARESETN] [get_bd_pins microblaze_0_axi_periph/M17_ARESETN] [get_bd_pins microblaze_0_axi_periph/M18_ARESETN] [get_bd_pins microblaze_0_axi_periph/M19_ARESETN] [get_bd_pins microblaze_0_axi_periph/M20_ARESETN] [get_bd_pins microblaze_0_axi_periph/M21_ARESETN] [get_bd_pins microblaze_0_axi_periph/M26_ARESETN] [get_bd_pins microblaze_0_axi_periph/M27_ARESETN] [get_bd_pins rst_clk_wiz_0_50M/peripheral_aresetn] [get_bd_pins video_dynclk/s_axi_aresetn] [get_bd_pins vtg/s_axi_aresetn]
  connect_bd_net -net rst_mig_7series_0_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_mig_7series_0_ui_clk/bus_struct_reset]
  connect_bd_net -net rst_mig_7series_0_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_mig_7series_0_ui_clk/mb_reset]
  connect_bd_net -net rst_mig_7series_0_100M_peripheral_aresetn [get_bd_pins axi_smc/aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M12_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins mig_7series_0/aresetn] [get_bd_pins rst_mig_7series_0_ui_clk/peripheral_aresetn]
  connect_bd_net -net rst_vid_clk_dyn_peripheral_aresetn [get_bd_pins rst_vid_clk_dyn/peripheral_aresetn] [get_bd_pins vtg/resetn]
  connect_bd_net -net rst_vid_clk_dyn_peripheral_reset [get_bd_pins rst_vid_clk_dyn/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]
  connect_bd_net -net s_axil_clk_50 [get_bd_pins AXI_GammaCorrection_A/AxiLiteClk] [get_bd_pins AXI_GammaCorrection_B/AxiLiteClk] [get_bd_pins AXI_GammaCorrection_C/AxiLiteClk] [get_bd_pins AXI_GammaCorrection_D/AxiLiteClk] [get_bd_pins MIPI_CSI_2_RX_A/s_axi_lite_aclk] [get_bd_pins MIPI_CSI_2_RX_B/s_axi_lite_aclk] [get_bd_pins MIPI_CSI_2_RX_C/s_axi_lite_aclk] [get_bd_pins MIPI_CSI_2_RX_D/s_axi_lite_aclk] [get_bd_pins MIPI_D_PHY_RX_A/s_axi_lite_aclk] [get_bd_pins MIPI_D_PHY_RX_B/s_axi_lite_aclk] [get_bd_pins MIPI_D_PHY_RX_C/s_axi_lite_aclk] [get_bd_pins MIPI_D_PHY_RX_D/s_axi_lite_aclk] [get_bd_pins axi_cama_bta/s_axi_aclk] [get_bd_pins axi_cama_gpio/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_pwup_prsnt_gpio/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axi_vdma_a/s_axi_lite_aclk] [get_bd_pins axi_vdma_b/s_axi_lite_aclk] [get_bd_pins axi_vdma_c/s_axi_lite_aclk] [get_bd_pins axi_vdma_d/s_axi_lite_aclk] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/M11_ACLK] [get_bd_pins microblaze_0_axi_periph/M13_ACLK] [get_bd_pins microblaze_0_axi_periph/M14_ACLK] [get_bd_pins microblaze_0_axi_periph/M15_ACLK] [get_bd_pins microblaze_0_axi_periph/M16_ACLK] [get_bd_pins microblaze_0_axi_periph/M17_ACLK] [get_bd_pins microblaze_0_axi_periph/M18_ACLK] [get_bd_pins microblaze_0_axi_periph/M19_ACLK] [get_bd_pins microblaze_0_axi_periph/M20_ACLK] [get_bd_pins microblaze_0_axi_periph/M21_ACLK] [get_bd_pins microblaze_0_axi_periph/M26_ACLK] [get_bd_pins microblaze_0_axi_periph/M27_ACLK] [get_bd_pins mig_7series_0/ui_addn_clk_2] [get_bd_pins rst_clk_wiz_0_50M/slowest_sync_clk] [get_bd_pins video_dynclk/s_axi_aclk] [get_bd_pins vtg/s_axi_aclk]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins vtg/gen_clken]
  connect_bd_net -net vtg_irq [get_bd_pins microblaze_0_xlconcat/In0] [get_bd_pins vtg/irq]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins axi_vdma_a/mm2s_frame_ptr_in] [get_bd_pins xlconcat_1/dout]

  # Create address segments
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_vdma_a/Data_MM2S] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_vdma_a/Data_S2MM] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_vdma_b/Data_S2MM] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_vdma_c/Data_S2MM] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_vdma_d/Data_S2MM] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs AXI_GammaCorrection_A/AXI_Lite_Reg_Intf/Reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs AXI_GammaCorrection_B/AXI_Lite_Reg_Intf/Reg] -force
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs AXI_GammaCorrection_C/AXI_Lite_Reg_Intf/Reg] -force
  assign_bd_address -offset 0x44A30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs AXI_GammaCorrection_D/AXI_Lite_Reg_Intf/Reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_CSI_2_RX_A/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44A50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_CSI_2_RX_B/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44A60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_CSI_2_RX_C/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44A70000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_CSI_2_RX_D/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44A80000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_D_PHY_RX_A/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44A90000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_D_PHY_RX_B/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44AA0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_D_PHY_RX_C/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x44AB0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs MIPI_D_PHY_RX_D/S_AXI_LITE/S_AXI_LITE_reg] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_cama_bta/S_AXI/Reg] -force
  assign_bd_address -offset 0x40010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_cama_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x40800000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_pwup_prsnt_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44AC0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_vdma_a/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44AD0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_vdma_b/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44AE0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_vdma_c/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44AF0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_vdma_d/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x44B00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs video_dynclk/s_axi_lite/Reg] -force
  assign_bd_address -offset 0x44B10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs video_scaler_a/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0x44B20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs video_scaler_b/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0x44B30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs video_scaler_c/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0x44B40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs video_scaler_d/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0x44B50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs vtg/ctrl/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


