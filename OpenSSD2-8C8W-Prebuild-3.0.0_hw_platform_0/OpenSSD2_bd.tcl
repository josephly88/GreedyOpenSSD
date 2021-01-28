
################################################################
# This is a generated script based on design: OpenSSD2
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source OpenSSD2_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z045ffg900-3


# CHANGE DESIGN NAME HERE
set design_name OpenSSD2

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set IO_NAND_CH0_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH0_DQ ]
  set IO_NAND_CH0_DQS_N [ create_bd_port -dir IO IO_NAND_CH0_DQS_N ]
  set IO_NAND_CH0_DQS_P [ create_bd_port -dir IO IO_NAND_CH0_DQS_P ]
  set IO_NAND_CH1_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH1_DQ ]
  set IO_NAND_CH1_DQS_N [ create_bd_port -dir IO IO_NAND_CH1_DQS_N ]
  set IO_NAND_CH1_DQS_P [ create_bd_port -dir IO IO_NAND_CH1_DQS_P ]
  set IO_NAND_CH2_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH2_DQ ]
  set IO_NAND_CH2_DQS_N [ create_bd_port -dir IO IO_NAND_CH2_DQS_N ]
  set IO_NAND_CH2_DQS_P [ create_bd_port -dir IO IO_NAND_CH2_DQS_P ]
  set IO_NAND_CH3_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH3_DQ ]
  set IO_NAND_CH3_DQS_N [ create_bd_port -dir IO IO_NAND_CH3_DQS_N ]
  set IO_NAND_CH3_DQS_P [ create_bd_port -dir IO IO_NAND_CH3_DQS_P ]
  set IO_NAND_CH4_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH4_DQ ]
  set IO_NAND_CH4_DQS_N [ create_bd_port -dir IO IO_NAND_CH4_DQS_N ]
  set IO_NAND_CH4_DQS_P [ create_bd_port -dir IO IO_NAND_CH4_DQS_P ]
  set IO_NAND_CH5_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH5_DQ ]
  set IO_NAND_CH5_DQS_N [ create_bd_port -dir IO IO_NAND_CH5_DQS_N ]
  set IO_NAND_CH5_DQS_P [ create_bd_port -dir IO IO_NAND_CH5_DQS_P ]
  set IO_NAND_CH6_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH6_DQ ]
  set IO_NAND_CH6_DQS_N [ create_bd_port -dir IO IO_NAND_CH6_DQS_N ]
  set IO_NAND_CH6_DQS_P [ create_bd_port -dir IO IO_NAND_CH6_DQS_P ]
  set IO_NAND_CH7_DQ [ create_bd_port -dir IO -from 7 -to 0 IO_NAND_CH7_DQ ]
  set IO_NAND_CH7_DQS_N [ create_bd_port -dir IO IO_NAND_CH7_DQS_N ]
  set IO_NAND_CH7_DQS_P [ create_bd_port -dir IO IO_NAND_CH7_DQS_P ]
  set I_NAND_CH0_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH0_RB ]
  set I_NAND_CH1_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH1_RB ]
  set I_NAND_CH2_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH2_RB ]
  set I_NAND_CH3_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH3_RB ]
  set I_NAND_CH4_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH4_RB ]
  set I_NAND_CH5_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH5_RB ]
  set I_NAND_CH6_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH6_RB ]
  set I_NAND_CH7_RB [ create_bd_port -dir I -from 7 -to 0 I_NAND_CH7_RB ]
  set O_DEBUG [ create_bd_port -dir O -from 31 -to 0 O_DEBUG ]
  set O_NAND_CH0_ALE [ create_bd_port -dir O O_NAND_CH0_ALE ]
  set O_NAND_CH0_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH0_CE ]
  set O_NAND_CH0_CLE [ create_bd_port -dir O O_NAND_CH0_CLE ]
  set O_NAND_CH0_RE_N [ create_bd_port -dir O O_NAND_CH0_RE_N ]
  set O_NAND_CH0_RE_P [ create_bd_port -dir O O_NAND_CH0_RE_P ]
  set O_NAND_CH0_WE [ create_bd_port -dir O O_NAND_CH0_WE ]
  set O_NAND_CH0_WP [ create_bd_port -dir O O_NAND_CH0_WP ]
  set O_NAND_CH1_ALE [ create_bd_port -dir O O_NAND_CH1_ALE ]
  set O_NAND_CH1_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH1_CE ]
  set O_NAND_CH1_CLE [ create_bd_port -dir O O_NAND_CH1_CLE ]
  set O_NAND_CH1_RE_N [ create_bd_port -dir O O_NAND_CH1_RE_N ]
  set O_NAND_CH1_RE_P [ create_bd_port -dir O O_NAND_CH1_RE_P ]
  set O_NAND_CH1_WE [ create_bd_port -dir O O_NAND_CH1_WE ]
  set O_NAND_CH1_WP [ create_bd_port -dir O O_NAND_CH1_WP ]
  set O_NAND_CH2_ALE [ create_bd_port -dir O O_NAND_CH2_ALE ]
  set O_NAND_CH2_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH2_CE ]
  set O_NAND_CH2_CLE [ create_bd_port -dir O O_NAND_CH2_CLE ]
  set O_NAND_CH2_RE_N [ create_bd_port -dir O O_NAND_CH2_RE_N ]
  set O_NAND_CH2_RE_P [ create_bd_port -dir O O_NAND_CH2_RE_P ]
  set O_NAND_CH2_WE [ create_bd_port -dir O O_NAND_CH2_WE ]
  set O_NAND_CH2_WP [ create_bd_port -dir O O_NAND_CH2_WP ]
  set O_NAND_CH3_ALE [ create_bd_port -dir O O_NAND_CH3_ALE ]
  set O_NAND_CH3_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH3_CE ]
  set O_NAND_CH3_CLE [ create_bd_port -dir O O_NAND_CH3_CLE ]
  set O_NAND_CH3_RE_N [ create_bd_port -dir O O_NAND_CH3_RE_N ]
  set O_NAND_CH3_RE_P [ create_bd_port -dir O O_NAND_CH3_RE_P ]
  set O_NAND_CH3_WE [ create_bd_port -dir O O_NAND_CH3_WE ]
  set O_NAND_CH3_WP [ create_bd_port -dir O O_NAND_CH3_WP ]
  set O_NAND_CH4_ALE [ create_bd_port -dir O O_NAND_CH4_ALE ]
  set O_NAND_CH4_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH4_CE ]
  set O_NAND_CH4_CLE [ create_bd_port -dir O O_NAND_CH4_CLE ]
  set O_NAND_CH4_RE_N [ create_bd_port -dir O O_NAND_CH4_RE_N ]
  set O_NAND_CH4_RE_P [ create_bd_port -dir O O_NAND_CH4_RE_P ]
  set O_NAND_CH4_WE [ create_bd_port -dir O O_NAND_CH4_WE ]
  set O_NAND_CH4_WP [ create_bd_port -dir O O_NAND_CH4_WP ]
  set O_NAND_CH5_ALE [ create_bd_port -dir O O_NAND_CH5_ALE ]
  set O_NAND_CH5_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH5_CE ]
  set O_NAND_CH5_CLE [ create_bd_port -dir O O_NAND_CH5_CLE ]
  set O_NAND_CH5_RE_N [ create_bd_port -dir O O_NAND_CH5_RE_N ]
  set O_NAND_CH5_RE_P [ create_bd_port -dir O O_NAND_CH5_RE_P ]
  set O_NAND_CH5_WE [ create_bd_port -dir O O_NAND_CH5_WE ]
  set O_NAND_CH5_WP [ create_bd_port -dir O O_NAND_CH5_WP ]
  set O_NAND_CH6_ALE [ create_bd_port -dir O O_NAND_CH6_ALE ]
  set O_NAND_CH6_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH6_CE ]
  set O_NAND_CH6_CLE [ create_bd_port -dir O O_NAND_CH6_CLE ]
  set O_NAND_CH6_RE_N [ create_bd_port -dir O O_NAND_CH6_RE_N ]
  set O_NAND_CH6_RE_P [ create_bd_port -dir O O_NAND_CH6_RE_P ]
  set O_NAND_CH6_WE [ create_bd_port -dir O O_NAND_CH6_WE ]
  set O_NAND_CH6_WP [ create_bd_port -dir O O_NAND_CH6_WP ]
  set O_NAND_CH7_ALE [ create_bd_port -dir O O_NAND_CH7_ALE ]
  set O_NAND_CH7_CE [ create_bd_port -dir O -from 7 -to 0 O_NAND_CH7_CE ]
  set O_NAND_CH7_CLE [ create_bd_port -dir O O_NAND_CH7_CLE ]
  set O_NAND_CH7_RE_N [ create_bd_port -dir O O_NAND_CH7_RE_N ]
  set O_NAND_CH7_RE_P [ create_bd_port -dir O O_NAND_CH7_RE_P ]
  set O_NAND_CH7_WE [ create_bd_port -dir O O_NAND_CH7_WE ]
  set O_NAND_CH7_WP [ create_bd_port -dir O O_NAND_CH7_WP ]
  set pcie_perst_n [ create_bd_port -dir I pcie_perst_n ]
  set pcie_ref_clk_n [ create_bd_port -dir I pcie_ref_clk_n ]
  set pcie_ref_clk_p [ create_bd_port -dir I pcie_ref_clk_p ]
  set pcie_rx_n [ create_bd_port -dir I -from 7 -to 0 pcie_rx_n ]
  set pcie_rx_p [ create_bd_port -dir I -from 7 -to 0 pcie_rx_p ]
  set pcie_tx_n [ create_bd_port -dir O -from 7 -to 0 pcie_tx_n ]
  set pcie_tx_p [ create_bd_port -dir O -from 7 -to 0 pcie_tx_p ]

  # Create instance: CH0MMCMC1H200, and set properties
  set CH0MMCMC1H200 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 CH0MMCMC1H200 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {81.410} CONFIG.CLKOUT1_PHASE_ERROR {74.126} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.PRIM_SOURCE {Global_buffer} CONFIG.USE_LOCKED {false}  ] $CH0MMCMC1H200

  # Create instance: CH2MMCMC1H200, and set properties
  set CH2MMCMC1H200 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 CH2MMCMC1H200 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {81.410} CONFIG.CLKOUT1_PHASE_ERROR {74.126} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.PRIM_SOURCE {Global_buffer} CONFIG.USE_LOCKED {false}  ] $CH2MMCMC1H200

  # Create instance: CH3MMCMC1H200, and set properties
  set CH3MMCMC1H200 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 CH3MMCMC1H200 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {81.410} CONFIG.CLKOUT1_PHASE_ERROR {74.126} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.PRIM_SOURCE {Global_buffer} CONFIG.USE_LOCKED {false}  ] $CH3MMCMC1H200

  # Create instance: CH4MMCMC1H200, and set properties
  set CH4MMCMC1H200 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 CH4MMCMC1H200 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {81.410} CONFIG.CLKOUT1_PHASE_ERROR {74.126} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.PRIM_SOURCE {Global_buffer} CONFIG.USE_LOCKED {false}  ] $CH4MMCMC1H200

  # Create instance: CH6MMCMC1H200, and set properties
  set CH6MMCMC1H200 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 CH6MMCMC1H200 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {81.410} CONFIG.CLKOUT1_PHASE_ERROR {74.126} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.PRIM_SOURCE {Global_buffer} CONFIG.USE_LOCKED {false}  ] $CH6MMCMC1H200

  # Create instance: CH7MMCMC1H200, and set properties
  set CH7MMCMC1H200 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 CH7MMCMC1H200 ]
  set_property -dict [ list CONFIG.CLKOUT1_JITTER {81.410} CONFIG.CLKOUT1_PHASE_ERROR {74.126} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} CONFIG.JITTER_SEL {Min_O_Jitter} CONFIG.PRIM_SOURCE {Global_buffer} CONFIG.USE_LOCKED {false}  ] $CH7MMCMC1H200

  # Create instance: Dispatcher_uCode_0, and set properties
  set Dispatcher_uCode_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_0 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_0

  # Create instance: Dispatcher_uCode_1, and set properties
  set Dispatcher_uCode_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_1 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_1

  # Create instance: Dispatcher_uCode_2, and set properties
  set Dispatcher_uCode_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_2 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_2

  # Create instance: Dispatcher_uCode_3, and set properties
  set Dispatcher_uCode_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_3 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_3

  # Create instance: Dispatcher_uCode_4, and set properties
  set Dispatcher_uCode_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_4 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_4

  # Create instance: Dispatcher_uCode_5, and set properties
  set Dispatcher_uCode_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_5 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_5

  # Create instance: Dispatcher_uCode_6, and set properties
  set Dispatcher_uCode_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_6 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_6

  # Create instance: Dispatcher_uCode_7, and set properties
  set Dispatcher_uCode_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 Dispatcher_uCode_7 ]
  set_property -dict [ list CONFIG.Coe_File {../../../../uProgROM_v2.0.coe} CONFIG.Enable_32bit_Address {false} CONFIG.Load_Init_File {true} CONFIG.Read_Width_A {64} CONFIG.Register_PortA_Output_of_Memory_Primitives {true} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Use_RSTA_Pin {true} CONFIG.Write_Depth_A {256} CONFIG.Write_Width_A {64} CONFIG.use_bram_block {Stand_Alone}  ] $Dispatcher_uCode_7

  # Create instance: GPIC0, and set properties
  set GPIC0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 GPIC0 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.NUM_MI {8} CONFIG.S00_HAS_DATA_FIFO {0}  ] $GPIC0

  # Create instance: GPIC1, and set properties
  set GPIC1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 GPIC1 ]
  set_property -dict [ list CONFIG.NUM_MI {3}  ] $GPIC1

  # Create instance: HPIC3, and set properties
  set HPIC3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 HPIC3 ]
  set_property -dict [ list CONFIG.NUM_MI {1}  ] $HPIC3

  # Create instance: NVMeHostController_0, and set properties
  set NVMeHostController_0 [ create_bd_cell -type ip -vlnv ENCLab:ip:NVMeHostController:2.0.0 NVMeHostController_0 ]

  # Create instance: PS, and set properties
  set PS [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 PS ]
  set_property -dict [ list CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {1000} \
CONFIG.PCW_DDR_PORT2_HPR_ENABLE {0} CONFIG.PCW_DDR_PORT3_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PRIORITY_READPORT_0 {High} CONFIG.PCW_DDR_PRIORITY_READPORT_2 {Low} \
CONFIG.PCW_DDR_PRIORITY_READPORT_3 {Low} CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0 {High} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2 {Low} CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3 {Low} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {100 Mbps} \
CONFIG.PCW_ENET0_RESET_ENABLE {1} CONFIG.PCW_ENET0_RESET_IO {MIO 47} \
CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_CLK3_PORT {1} CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_EN_RST2_PORT {1} CONFIG.PCW_EN_RST3_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {250} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C0_RESET_ENABLE {1} \
CONFIG.PCW_I2C0_RESET_IO {MIO 46} CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_10_PULLUP {disabled} CONFIG.PCW_MIO_11_PULLUP {disabled} \
CONFIG.PCW_MIO_12_PULLUP {disabled} CONFIG.PCW_MIO_13_PULLUP {disabled} \
CONFIG.PCW_MIO_16_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_17_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_18_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_19_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_20_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_21_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_22_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_23_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_24_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_25_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_26_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_27_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_28_PULLUP {disabled} CONFIG.PCW_MIO_29_PULLUP {disabled} \
CONFIG.PCW_MIO_30_PULLUP {disabled} CONFIG.PCW_MIO_31_PULLUP {disabled} \
CONFIG.PCW_MIO_32_PULLUP {disabled} CONFIG.PCW_MIO_33_PULLUP {disabled} \
CONFIG.PCW_MIO_34_PULLUP {disabled} CONFIG.PCW_MIO_35_PULLUP {disabled} \
CONFIG.PCW_MIO_36_PULLUP {disabled} CONFIG.PCW_MIO_37_PULLUP {disabled} \
CONFIG.PCW_MIO_38_PULLUP {disabled} CONFIG.PCW_MIO_39_PULLUP {disabled} \
CONFIG.PCW_MIO_40_PULLUP {disabled} CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_42_PULLUP {disabled} CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_44_PULLUP {disabled} CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_9_PULLUP {disabled} CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE {1} CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 14} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} CONFIG.PCW_SD0_GRP_WP_IO {MIO 15} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {1} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.521} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.636} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.540} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.621} CONFIG.PCW_UIPARAM_DDR_CWL {6} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.226} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.278} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.184} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.309} CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {Custom} CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_UIPARAM_DDR_T_FAW {50} CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {37.5} \
CONFIG.PCW_UIPARAM_DDR_T_RC {50.62} CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USB0_RESET_ENABLE {1} \
CONFIG.PCW_USB0_RESET_IO {MIO 7} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_M_AXI_GP1 {1} CONFIG.PCW_USE_S_AXI_GP0 {0} \
CONFIG.PCW_USE_S_AXI_GP1 {0} CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {1} CONFIG.PCW_USE_S_AXI_HP2 {0} \
CONFIG.PCW_USE_S_AXI_HP3 {1}  ] $PS

  # Create instance: Tiger4NSC_0, and set properties
  set Tiger4NSC_0 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_0 ]

  # Create instance: Tiger4NSC_1, and set properties
  set Tiger4NSC_1 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_1 ]

  # Create instance: Tiger4NSC_2, and set properties
  set Tiger4NSC_2 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_2 ]

  # Create instance: Tiger4NSC_3, and set properties
  set Tiger4NSC_3 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_3 ]

  # Create instance: Tiger4NSC_4, and set properties
  set Tiger4NSC_4 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_4 ]

  # Create instance: Tiger4NSC_5, and set properties
  set Tiger4NSC_5 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_5 ]

  # Create instance: Tiger4NSC_6, and set properties
  set Tiger4NSC_6 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_6 ]

  # Create instance: Tiger4NSC_7, and set properties
  set Tiger4NSC_7 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4NSC:1.1.0 Tiger4NSC_7 ]

  # Create instance: Tiger4SharedKES_0, and set properties
  set Tiger4SharedKES_0 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4SharedKES:1.0.0 Tiger4SharedKES_0 ]

  # Create instance: Tiger4SharedKES_1, and set properties
  set Tiger4SharedKES_1 [ create_bd_cell -type ip -vlnv ENCLab:ip:Tiger4SharedKES:1.0.0 Tiger4SharedKES_1 ]

  # Create instance: V2DCIClockConverter32_0, and set properties
  set V2DCIClockConverter32_0 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_0 ]

  # Create instance: V2DCIClockConverter32_1, and set properties
  set V2DCIClockConverter32_1 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_1 ]

  # Create instance: V2DCIClockConverter32_2, and set properties
  set V2DCIClockConverter32_2 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_2 ]

  # Create instance: V2DCIClockConverter32_3, and set properties
  set V2DCIClockConverter32_3 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_3 ]

  # Create instance: V2DCIClockConverter32_4, and set properties
  set V2DCIClockConverter32_4 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_4 ]

  # Create instance: V2DCIClockConverter32_5, and set properties
  set V2DCIClockConverter32_5 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_5 ]

  # Create instance: V2DCIClockConverter32_6, and set properties
  set V2DCIClockConverter32_6 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_6 ]

  # Create instance: V2DCIClockConverter32_7, and set properties
  set V2DCIClockConverter32_7 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2DCIClockConverter32:1.0.6 V2DCIClockConverter32_7 ]

  # Create instance: V2NFC100DDR_0, and set properties
  set V2NFC100DDR_0 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_0 ]

  # Create instance: V2NFC100DDR_1, and set properties
  set V2NFC100DDR_1 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_1 ]

  # Create instance: V2NFC100DDR_2, and set properties
  set V2NFC100DDR_2 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_2 ]

  # Create instance: V2NFC100DDR_3, and set properties
  set V2NFC100DDR_3 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_3 ]

  # Create instance: V2NFC100DDR_4, and set properties
  set V2NFC100DDR_4 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_4 ]

  # Create instance: V2NFC100DDR_5, and set properties
  set V2NFC100DDR_5 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_5 ]

  # Create instance: V2NFC100DDR_6, and set properties
  set V2NFC100DDR_6 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_6 ]

  # Create instance: V2NFC100DDR_7, and set properties
  set V2NFC100DDR_7 [ create_bd_cell -type ip -vlnv ENCLab:ip:V2NFC100DDR:1.0.0 V2NFC100DDR_7 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_1, and set properties
  set axi_bram_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_1 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_1

  # Create instance: axi_bram_ctrl_2, and set properties
  set axi_bram_ctrl_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_2 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_2

  # Create instance: axi_bram_ctrl_3, and set properties
  set axi_bram_ctrl_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_3 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_3

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.M00_HAS_DATA_FIFO {2} CONFIG.M00_HAS_REGSLICE {1} CONFIG.M01_HAS_REGSLICE {1} CONFIG.NUM_SI {4} CONFIG.S00_HAS_REGSLICE {1} CONFIG.S01_HAS_REGSLICE {1} CONFIG.S02_HAS_REGSLICE {1} CONFIG.S03_HAS_REGSLICE {1} CONFIG.STRATEGY {2}  ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.M00_HAS_DATA_FIFO {2} CONFIG.M00_HAS_REGSLICE {1} CONFIG.M01_HAS_REGSLICE {1} CONFIG.NUM_SI {4} CONFIG.S00_HAS_REGSLICE {1} CONFIG.S01_HAS_REGSLICE {1} CONFIG.S02_HAS_REGSLICE {1} CONFIG.S03_HAS_REGSLICE {1} CONFIG.STRATEGY {2}  ] $axi_interconnect_1

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_0 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_1 ]
  set_property -dict [ list CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Use_RSTB_Pin {true}  ] $blk_mem_gen_1

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: proc_sys_reset_2, and set properties
  set proc_sys_reset_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_2 ]

  # Create instance: proc_sys_reset_3, and set properties
  set proc_sys_reset_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_3 ]

  # Create interface connections
  connect_bd_intf_net -intf_net GPIC0_M00_AXI [get_bd_intf_pins GPIC0/M00_AXI] [get_bd_intf_pins Tiger4NSC_0/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M01_AXI [get_bd_intf_pins GPIC0/M01_AXI] [get_bd_intf_pins Tiger4NSC_1/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M02_AXI [get_bd_intf_pins GPIC0/M02_AXI] [get_bd_intf_pins Tiger4NSC_2/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M03_AXI [get_bd_intf_pins GPIC0/M03_AXI] [get_bd_intf_pins Tiger4NSC_3/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M04_AXI [get_bd_intf_pins GPIC0/M04_AXI] [get_bd_intf_pins Tiger4NSC_4/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M05_AXI [get_bd_intf_pins GPIC0/M05_AXI] [get_bd_intf_pins Tiger4NSC_5/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M06_AXI [get_bd_intf_pins GPIC0/M06_AXI] [get_bd_intf_pins Tiger4NSC_6/C_AXI]
  connect_bd_intf_net -intf_net GPIC0_M07_AXI [get_bd_intf_pins GPIC0/M07_AXI] [get_bd_intf_pins Tiger4NSC_7/C_AXI]
  connect_bd_intf_net -intf_net GPIC1_M00_AXI [get_bd_intf_pins GPIC1/M00_AXI] [get_bd_intf_pins NVMeHostController_0/s0_axi]
  connect_bd_intf_net -intf_net GPIC1_M01_AXI [get_bd_intf_pins GPIC1/M01_AXI] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]
  connect_bd_intf_net -intf_net GPIC1_M02_AXI [get_bd_intf_pins GPIC1/M02_AXI] [get_bd_intf_pins axi_bram_ctrl_3/S_AXI]
  connect_bd_intf_net -intf_net HPIC3_M00_AXI [get_bd_intf_pins HPIC3/M00_AXI] [get_bd_intf_pins PS/S_AXI_HP3]
  connect_bd_intf_net -intf_net NVMeHostController_0_m0_axi [get_bd_intf_pins HPIC3/S00_AXI] [get_bd_intf_pins NVMeHostController_0/m0_axi]
  connect_bd_intf_net -intf_net PS_M_AXI_GP0 [get_bd_intf_pins GPIC0/S00_AXI] [get_bd_intf_pins PS/M_AXI_GP0]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins GPIC1/S00_AXI] [get_bd_intf_pins PS/M_AXI_GP1]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins Tiger4NSC_1/D_AXI] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net S01_AXI_2 [get_bd_intf_pins Tiger4NSC_5/D_AXI] [get_bd_intf_pins axi_interconnect_1/S01_AXI]
  connect_bd_intf_net -intf_net S03_AXI_1 [get_bd_intf_pins Tiger4NSC_3/D_AXI] [get_bd_intf_pins axi_interconnect_0/S03_AXI]
  connect_bd_intf_net -intf_net S03_AXI_2 [get_bd_intf_pins Tiger4NSC_7/D_AXI] [get_bd_intf_pins axi_interconnect_1/S03_AXI]
  connect_bd_intf_net -intf_net Tiger4NSC_0_D_AXI [get_bd_intf_pins Tiger4NSC_0/D_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net Tiger4NSC_0_NFCInterface [get_bd_intf_pins Tiger4NSC_0/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_0/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_0_SharedKESInterface [get_bd_intf_pins Tiger4NSC_0/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_0/SharedKESInterface_CH0]
  connect_bd_intf_net -intf_net Tiger4NSC_0_uROMInterface [get_bd_intf_pins Dispatcher_uCode_0/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_0/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_1_NFCInterface [get_bd_intf_pins Tiger4NSC_1/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_1/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_1_SharedKESInterface [get_bd_intf_pins Tiger4NSC_1/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_0/SharedKESInterface_CH1]
  connect_bd_intf_net -intf_net Tiger4NSC_1_uROMInterface [get_bd_intf_pins Dispatcher_uCode_1/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_1/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_2_D_AXI [get_bd_intf_pins Tiger4NSC_2/D_AXI] [get_bd_intf_pins axi_interconnect_0/S02_AXI]
  connect_bd_intf_net -intf_net Tiger4NSC_2_NFCInterface [get_bd_intf_pins Tiger4NSC_2/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_2/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_2_SharedKESInterface [get_bd_intf_pins Tiger4NSC_2/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_0/SharedKESInterface_CH2]
  connect_bd_intf_net -intf_net Tiger4NSC_2_uROMInterface [get_bd_intf_pins Dispatcher_uCode_2/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_2/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_3_NFCInterface [get_bd_intf_pins Tiger4NSC_3/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_3/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_3_SharedKESInterface [get_bd_intf_pins Tiger4NSC_3/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_0/SharedKESInterface_CH3]
  connect_bd_intf_net -intf_net Tiger4NSC_3_uROMInterface [get_bd_intf_pins Dispatcher_uCode_3/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_3/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_4_D_AXI [get_bd_intf_pins Tiger4NSC_4/D_AXI] [get_bd_intf_pins axi_interconnect_1/S00_AXI]
  connect_bd_intf_net -intf_net Tiger4NSC_4_NFCInterface [get_bd_intf_pins Tiger4NSC_4/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_4/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_4_SharedKESInterface [get_bd_intf_pins Tiger4NSC_4/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_1/SharedKESInterface_CH0]
  connect_bd_intf_net -intf_net Tiger4NSC_4_uROMInterface [get_bd_intf_pins Dispatcher_uCode_4/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_4/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_5_NFCInterface [get_bd_intf_pins Tiger4NSC_5/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_5/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_5_SharedKESInterface [get_bd_intf_pins Tiger4NSC_5/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_1/SharedKESInterface_CH1]
  connect_bd_intf_net -intf_net Tiger4NSC_5_uROMInterface [get_bd_intf_pins Dispatcher_uCode_5/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_5/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_6_D_AXI [get_bd_intf_pins Tiger4NSC_6/D_AXI] [get_bd_intf_pins axi_interconnect_1/S02_AXI]
  connect_bd_intf_net -intf_net Tiger4NSC_6_NFCInterface [get_bd_intf_pins Tiger4NSC_6/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_6/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_6_SharedKESInterface [get_bd_intf_pins Tiger4NSC_6/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_1/SharedKESInterface_CH2]
  connect_bd_intf_net -intf_net Tiger4NSC_6_uROMInterface [get_bd_intf_pins Dispatcher_uCode_6/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_6/uROMInterface]
  connect_bd_intf_net -intf_net Tiger4NSC_7_NFCInterface [get_bd_intf_pins Tiger4NSC_7/NFCInterface] [get_bd_intf_pins V2DCIClockConverter32_7/M_DCL]
  connect_bd_intf_net -intf_net Tiger4NSC_7_SharedKESInterface [get_bd_intf_pins Tiger4NSC_7/SharedKESInterface] [get_bd_intf_pins Tiger4SharedKES_1/SharedKESInterface_CH3]
  connect_bd_intf_net -intf_net Tiger4NSC_7_uROMInterface [get_bd_intf_pins Dispatcher_uCode_7/BRAM_PORTA] [get_bd_intf_pins Tiger4NSC_7/uROMInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_0_S_DCL [get_bd_intf_pins V2DCIClockConverter32_0/S_DCL] [get_bd_intf_pins V2NFC100DDR_0/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_1_S_DCL [get_bd_intf_pins V2DCIClockConverter32_1/S_DCL] [get_bd_intf_pins V2NFC100DDR_1/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_2_S_DCL [get_bd_intf_pins V2DCIClockConverter32_2/S_DCL] [get_bd_intf_pins V2NFC100DDR_2/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_3_S_DCL [get_bd_intf_pins V2DCIClockConverter32_3/S_DCL] [get_bd_intf_pins V2NFC100DDR_3/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_4_S_DCL [get_bd_intf_pins V2DCIClockConverter32_4/S_DCL] [get_bd_intf_pins V2NFC100DDR_4/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_5_S_DCL [get_bd_intf_pins V2DCIClockConverter32_5/S_DCL] [get_bd_intf_pins V2NFC100DDR_5/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_6_S_DCL [get_bd_intf_pins V2DCIClockConverter32_6/S_DCL] [get_bd_intf_pins V2NFC100DDR_6/NFCInterface]
  connect_bd_intf_net -intf_net V2DCIClockConverter32_7_S_DCL [get_bd_intf_pins V2DCIClockConverter32_7/S_DCL] [get_bd_intf_pins V2NFC100DDR_7/NFCInterface]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_1_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_2_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_2/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_3_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_3/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins PS/S_AXI_HP0] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins PS/S_AXI_HP1] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins axi_bram_ctrl_2/S_AXI] [get_bd_intf_pins axi_interconnect_1/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins PS/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins PS/FIXED_IO]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins GPIC0/ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net ARESETN_2 [get_bd_pins HPIC3/ARESETN] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins proc_sys_reset_3/interconnect_aresetn]
  connect_bd_net -net ARESETN_3 [get_bd_pins GPIC1/ARESETN] [get_bd_pins proc_sys_reset_2/interconnect_aresetn]
  connect_bd_net -net CH0MMCMC1H200_clk_out1 [get_bd_pins CH0MMCMC1H200/clk_out1] [get_bd_pins V2NFC100DDR_0/iDelayRefClock] [get_bd_pins V2NFC100DDR_0/iOutputDrivingClock] [get_bd_pins V2NFC100DDR_1/iDelayRefClock] [get_bd_pins V2NFC100DDR_1/iOutputDrivingClock]
  connect_bd_net -net CH2MMCMC1H200_clk_out1 [get_bd_pins CH2MMCMC1H200/clk_out1] [get_bd_pins V2NFC100DDR_2/iDelayRefClock] [get_bd_pins V2NFC100DDR_2/iOutputDrivingClock]
  connect_bd_net -net CH3MMCMC1H200_clk_out1 [get_bd_pins CH3MMCMC1H200/clk_out1] [get_bd_pins V2NFC100DDR_3/iDelayRefClock] [get_bd_pins V2NFC100DDR_3/iOutputDrivingClock]
  connect_bd_net -net CH4MMCMC1H200_clk_out1 [get_bd_pins CH4MMCMC1H200/clk_out1] [get_bd_pins V2NFC100DDR_4/iDelayRefClock] [get_bd_pins V2NFC100DDR_4/iOutputDrivingClock] [get_bd_pins V2NFC100DDR_5/iDelayRefClock] [get_bd_pins V2NFC100DDR_5/iOutputDrivingClock]
  connect_bd_net -net CH6MMCMC1H200_clk_out1 [get_bd_pins CH6MMCMC1H200/clk_out1] [get_bd_pins V2NFC100DDR_6/iDelayRefClock] [get_bd_pins V2NFC100DDR_6/iOutputDrivingClock]
  connect_bd_net -net CH7MMCMC1H200_clk_out1 [get_bd_pins CH7MMCMC1H200/clk_out1] [get_bd_pins V2NFC100DDR_7/iDelayRefClock] [get_bd_pins V2NFC100DDR_7/iOutputDrivingClock]
  connect_bd_net -net I_NAND_RB_1 [get_bd_ports I_NAND_CH0_RB] [get_bd_pins V2NFC100DDR_0/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_2 [get_bd_ports I_NAND_CH1_RB] [get_bd_pins V2NFC100DDR_1/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_3 [get_bd_ports I_NAND_CH2_RB] [get_bd_pins V2NFC100DDR_2/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_4 [get_bd_ports I_NAND_CH3_RB] [get_bd_pins V2NFC100DDR_3/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_5 [get_bd_ports I_NAND_CH4_RB] [get_bd_pins V2NFC100DDR_4/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_6 [get_bd_ports I_NAND_CH5_RB] [get_bd_pins V2NFC100DDR_5/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_7 [get_bd_ports I_NAND_CH6_RB] [get_bd_pins V2NFC100DDR_6/I_NAND_RB]
  connect_bd_net -net I_NAND_RB_8 [get_bd_ports I_NAND_CH7_RB] [get_bd_pins V2NFC100DDR_7/I_NAND_RB]
  connect_bd_net -net M00_ARESETN_1 [get_bd_pins GPIC0/M00_ARESETN] [get_bd_pins GPIC0/M01_ARESETN] [get_bd_pins GPIC0/M02_ARESETN] [get_bd_pins GPIC0/M03_ARESETN] [get_bd_pins GPIC0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net M00_ARESETN_2 [get_bd_pins HPIC3/M00_ARESETN] [get_bd_pins HPIC3/S00_ARESETN] [get_bd_pins NVMeHostController_0/m0_axi_aresetn] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins proc_sys_reset_3/peripheral_aresetn]
  connect_bd_net -net M04_ARESETN_1 [get_bd_pins GPIC0/M04_ARESETN] [get_bd_pins GPIC0/M05_ARESETN] [get_bd_pins GPIC0/M06_ARESETN] [get_bd_pins GPIC0/M07_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins axi_interconnect_1/S02_ARESETN] [get_bd_pins axi_interconnect_1/S03_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
  connect_bd_net -net NVMeHostController_0_dev_irq_assert [get_bd_pins NVMeHostController_0/dev_irq_assert] [get_bd_pins PS/IRQ_F2P]
  connect_bd_net -net NVMeHostController_0_pcie_tx_n [get_bd_ports pcie_tx_n] [get_bd_pins NVMeHostController_0/pcie_tx_n]
  connect_bd_net -net NVMeHostController_0_pcie_tx_p [get_bd_ports pcie_tx_p] [get_bd_pins NVMeHostController_0/pcie_tx_p]
  connect_bd_net -net Net [get_bd_ports IO_NAND_CH0_DQS_N] [get_bd_pins V2NFC100DDR_0/IO_NAND_DQS_N]
  connect_bd_net -net Net1 [get_bd_ports IO_NAND_CH0_DQ] [get_bd_pins V2NFC100DDR_0/IO_NAND_DQ]
  connect_bd_net -net Net2 [get_bd_ports IO_NAND_CH0_DQS_P] [get_bd_pins V2NFC100DDR_0/IO_NAND_DQS_P]
  connect_bd_net -net Net3 [get_bd_ports IO_NAND_CH1_DQS_N] [get_bd_pins V2NFC100DDR_1/IO_NAND_DQS_N]
  connect_bd_net -net Net4 [get_bd_ports IO_NAND_CH1_DQS_P] [get_bd_pins V2NFC100DDR_1/IO_NAND_DQS_P]
  connect_bd_net -net Net5 [get_bd_ports IO_NAND_CH1_DQ] [get_bd_pins V2NFC100DDR_1/IO_NAND_DQ]
  connect_bd_net -net Net6 [get_bd_ports IO_NAND_CH2_DQS_P] [get_bd_pins V2NFC100DDR_2/IO_NAND_DQS_P]
  connect_bd_net -net Net7 [get_bd_ports IO_NAND_CH2_DQ] [get_bd_pins V2NFC100DDR_2/IO_NAND_DQ]
  connect_bd_net -net Net8 [get_bd_ports IO_NAND_CH2_DQS_N] [get_bd_pins V2NFC100DDR_2/IO_NAND_DQS_N]
  connect_bd_net -net Net9 [get_bd_ports IO_NAND_CH3_DQ] [get_bd_pins V2NFC100DDR_3/IO_NAND_DQ]
  connect_bd_net -net Net10 [get_bd_ports IO_NAND_CH3_DQS_N] [get_bd_pins V2NFC100DDR_3/IO_NAND_DQS_N]
  connect_bd_net -net Net11 [get_bd_ports IO_NAND_CH3_DQS_P] [get_bd_pins V2NFC100DDR_3/IO_NAND_DQS_P]
  connect_bd_net -net Net12 [get_bd_ports IO_NAND_CH4_DQ] [get_bd_pins V2NFC100DDR_4/IO_NAND_DQ]
  connect_bd_net -net Net13 [get_bd_ports IO_NAND_CH4_DQS_N] [get_bd_pins V2NFC100DDR_4/IO_NAND_DQS_N]
  connect_bd_net -net Net14 [get_bd_ports IO_NAND_CH4_DQS_P] [get_bd_pins V2NFC100DDR_4/IO_NAND_DQS_P]
  connect_bd_net -net Net15 [get_bd_ports IO_NAND_CH5_DQS_P] [get_bd_pins V2NFC100DDR_5/IO_NAND_DQS_P]
  connect_bd_net -net Net16 [get_bd_ports IO_NAND_CH5_DQ] [get_bd_pins V2NFC100DDR_5/IO_NAND_DQ]
  connect_bd_net -net Net17 [get_bd_ports IO_NAND_CH5_DQS_N] [get_bd_pins V2NFC100DDR_5/IO_NAND_DQS_N]
  connect_bd_net -net Net18 [get_bd_ports IO_NAND_CH6_DQ] [get_bd_pins V2NFC100DDR_6/IO_NAND_DQ]
  connect_bd_net -net Net19 [get_bd_ports IO_NAND_CH6_DQS_N] [get_bd_pins V2NFC100DDR_6/IO_NAND_DQS_N]
  connect_bd_net -net Net20 [get_bd_ports IO_NAND_CH6_DQS_P] [get_bd_pins V2NFC100DDR_6/IO_NAND_DQS_P]
  connect_bd_net -net Net21 [get_bd_ports IO_NAND_CH7_DQ] [get_bd_pins V2NFC100DDR_7/IO_NAND_DQ]
  connect_bd_net -net Net22 [get_bd_ports IO_NAND_CH7_DQS_N] [get_bd_pins V2NFC100DDR_7/IO_NAND_DQS_N]
  connect_bd_net -net Net23 [get_bd_ports IO_NAND_CH7_DQS_P] [get_bd_pins V2NFC100DDR_7/IO_NAND_DQS_P]
  connect_bd_net -net PS_FCLK_CLK0 [get_bd_pins CH0MMCMC1H200/clk_in1] [get_bd_pins CH2MMCMC1H200/clk_in1] [get_bd_pins CH3MMCMC1H200/clk_in1] [get_bd_pins GPIC0/ACLK] [get_bd_pins GPIC0/M00_ACLK] [get_bd_pins GPIC0/M01_ACLK] [get_bd_pins GPIC0/M02_ACLK] [get_bd_pins GPIC0/M03_ACLK] [get_bd_pins GPIC0/S00_ACLK] [get_bd_pins PS/FCLK_CLK0] [get_bd_pins PS/M_AXI_GP0_ACLK] [get_bd_pins Tiger4NSC_0/iClock] [get_bd_pins Tiger4NSC_1/iClock] [get_bd_pins Tiger4NSC_2/iClock] [get_bd_pins Tiger4NSC_3/iClock] [get_bd_pins Tiger4SharedKES_0/iClock] [get_bd_pins V2DCIClockConverter32_0/iMClock] [get_bd_pins V2DCIClockConverter32_0/iSClock] [get_bd_pins V2DCIClockConverter32_1/iMClock] [get_bd_pins V2DCIClockConverter32_1/iSClock] [get_bd_pins V2DCIClockConverter32_2/iMClock] [get_bd_pins V2DCIClockConverter32_2/iSClock] [get_bd_pins V2DCIClockConverter32_3/iMClock] [get_bd_pins V2DCIClockConverter32_3/iSClock] [get_bd_pins V2NFC100DDR_0/iSystemClock] [get_bd_pins V2NFC100DDR_1/iSystemClock] [get_bd_pins V2NFC100DDR_2/iSystemClock] [get_bd_pins V2NFC100DDR_3/iSystemClock] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net PS_FCLK_CLK1 [get_bd_pins CH4MMCMC1H200/clk_in1] [get_bd_pins CH6MMCMC1H200/clk_in1] [get_bd_pins CH7MMCMC1H200/clk_in1] [get_bd_pins GPIC0/M04_ACLK] [get_bd_pins GPIC0/M05_ACLK] [get_bd_pins GPIC0/M06_ACLK] [get_bd_pins GPIC0/M07_ACLK] [get_bd_pins PS/FCLK_CLK1] [get_bd_pins Tiger4NSC_4/iClock] [get_bd_pins Tiger4NSC_5/iClock] [get_bd_pins Tiger4NSC_6/iClock] [get_bd_pins Tiger4NSC_7/iClock] [get_bd_pins Tiger4SharedKES_1/iClock] [get_bd_pins V2DCIClockConverter32_4/iMClock] [get_bd_pins V2DCIClockConverter32_4/iSClock] [get_bd_pins V2DCIClockConverter32_5/iMClock] [get_bd_pins V2DCIClockConverter32_5/iSClock] [get_bd_pins V2DCIClockConverter32_6/iMClock] [get_bd_pins V2DCIClockConverter32_6/iSClock] [get_bd_pins V2DCIClockConverter32_7/iMClock] [get_bd_pins V2DCIClockConverter32_7/iSClock] [get_bd_pins V2NFC100DDR_4/iSystemClock] [get_bd_pins V2NFC100DDR_5/iSystemClock] [get_bd_pins V2NFC100DDR_6/iSystemClock] [get_bd_pins V2NFC100DDR_7/iSystemClock] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_interconnect_1/S02_ACLK] [get_bd_pins axi_interconnect_1/S03_ACLK] [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
  connect_bd_net -net PS_FCLK_CLK2 [get_bd_pins GPIC1/ACLK] [get_bd_pins GPIC1/M00_ACLK] [get_bd_pins GPIC1/M01_ACLK] [get_bd_pins GPIC1/M02_ACLK] [get_bd_pins GPIC1/S00_ACLK] [get_bd_pins NVMeHostController_0/s0_axi_aclk] [get_bd_pins PS/FCLK_CLK2] [get_bd_pins PS/M_AXI_GP1_ACLK] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_bram_ctrl_1/s_axi_aclk] [get_bd_pins axi_bram_ctrl_2/s_axi_aclk] [get_bd_pins axi_bram_ctrl_3/s_axi_aclk] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_1/M01_ACLK] [get_bd_pins proc_sys_reset_2/slowest_sync_clk]
  connect_bd_net -net PS_FCLK_CLK3 [get_bd_pins HPIC3/ACLK] [get_bd_pins HPIC3/M00_ACLK] [get_bd_pins HPIC3/S00_ACLK] [get_bd_pins NVMeHostController_0/m0_axi_aclk] [get_bd_pins PS/FCLK_CLK3] [get_bd_pins PS/S_AXI_HP0_ACLK] [get_bd_pins PS/S_AXI_HP1_ACLK] [get_bd_pins PS/S_AXI_HP3_ACLK] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins proc_sys_reset_3/slowest_sync_clk]
  connect_bd_net -net PS_FCLK_RESET0_N [get_bd_pins PS/FCLK_RESET0_N] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net PS_FCLK_RESET1_N [get_bd_pins PS/FCLK_RESET1_N] [get_bd_pins proc_sys_reset_1/ext_reset_in]
  connect_bd_net -net PS_FCLK_RESET2_N [get_bd_pins PS/FCLK_RESET2_N] [get_bd_pins proc_sys_reset_2/ext_reset_in]
  connect_bd_net -net PS_FCLK_RESET3_N [get_bd_pins PS/FCLK_RESET3_N] [get_bd_pins proc_sys_reset_3/ext_reset_in]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_ALE [get_bd_ports O_NAND_CH0_ALE] [get_bd_pins V2NFC100DDR_0/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_CE [get_bd_ports O_NAND_CH0_CE] [get_bd_pins V2NFC100DDR_0/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_CLE [get_bd_ports O_NAND_CH0_CLE] [get_bd_pins V2NFC100DDR_0/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_RE_N [get_bd_ports O_NAND_CH0_RE_N] [get_bd_pins V2NFC100DDR_0/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_RE_P [get_bd_ports O_NAND_CH0_RE_P] [get_bd_pins V2NFC100DDR_0/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_WE [get_bd_ports O_NAND_CH0_WE] [get_bd_pins V2NFC100DDR_0/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_0_O_NAND_WP [get_bd_ports O_NAND_CH0_WP] [get_bd_pins V2NFC100DDR_0/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_ALE [get_bd_ports O_NAND_CH1_ALE] [get_bd_pins V2NFC100DDR_1/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_CE [get_bd_ports O_NAND_CH1_CE] [get_bd_pins V2NFC100DDR_1/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_CLE [get_bd_ports O_NAND_CH1_CLE] [get_bd_pins V2NFC100DDR_1/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_RE_N [get_bd_ports O_NAND_CH1_RE_N] [get_bd_pins V2NFC100DDR_1/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_RE_P [get_bd_ports O_NAND_CH1_RE_P] [get_bd_pins V2NFC100DDR_1/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_WE [get_bd_ports O_NAND_CH1_WE] [get_bd_pins V2NFC100DDR_1/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_1_O_NAND_WP [get_bd_ports O_NAND_CH1_WP] [get_bd_pins V2NFC100DDR_1/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_ALE [get_bd_ports O_NAND_CH2_ALE] [get_bd_pins V2NFC100DDR_2/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_CE [get_bd_ports O_NAND_CH2_CE] [get_bd_pins V2NFC100DDR_2/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_CLE [get_bd_ports O_NAND_CH2_CLE] [get_bd_pins V2NFC100DDR_2/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_RE_N [get_bd_ports O_NAND_CH2_RE_N] [get_bd_pins V2NFC100DDR_2/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_RE_P [get_bd_ports O_NAND_CH2_RE_P] [get_bd_pins V2NFC100DDR_2/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_WE [get_bd_ports O_NAND_CH2_WE] [get_bd_pins V2NFC100DDR_2/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_2_O_NAND_WP [get_bd_ports O_NAND_CH2_WP] [get_bd_pins V2NFC100DDR_2/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_ALE [get_bd_ports O_NAND_CH3_ALE] [get_bd_pins V2NFC100DDR_3/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_CE [get_bd_ports O_NAND_CH3_CE] [get_bd_pins V2NFC100DDR_3/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_CLE [get_bd_ports O_NAND_CH3_CLE] [get_bd_pins V2NFC100DDR_3/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_RE_N [get_bd_ports O_NAND_CH3_RE_N] [get_bd_pins V2NFC100DDR_3/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_RE_P [get_bd_ports O_NAND_CH3_RE_P] [get_bd_pins V2NFC100DDR_3/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_WE [get_bd_ports O_NAND_CH3_WE] [get_bd_pins V2NFC100DDR_3/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_3_O_NAND_WP [get_bd_ports O_NAND_CH3_WP] [get_bd_pins V2NFC100DDR_3/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_ALE [get_bd_ports O_NAND_CH4_ALE] [get_bd_pins V2NFC100DDR_4/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_CE [get_bd_ports O_NAND_CH4_CE] [get_bd_pins V2NFC100DDR_4/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_CLE [get_bd_ports O_NAND_CH4_CLE] [get_bd_pins V2NFC100DDR_4/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_RE_N [get_bd_ports O_NAND_CH4_RE_N] [get_bd_pins V2NFC100DDR_4/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_RE_P [get_bd_ports O_NAND_CH4_RE_P] [get_bd_pins V2NFC100DDR_4/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_WE [get_bd_ports O_NAND_CH4_WE] [get_bd_pins V2NFC100DDR_4/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_4_O_NAND_WP [get_bd_ports O_NAND_CH4_WP] [get_bd_pins V2NFC100DDR_4/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_ALE [get_bd_ports O_NAND_CH5_ALE] [get_bd_pins V2NFC100DDR_5/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_CE [get_bd_ports O_NAND_CH5_CE] [get_bd_pins V2NFC100DDR_5/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_CLE [get_bd_ports O_NAND_CH5_CLE] [get_bd_pins V2NFC100DDR_5/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_RE_N [get_bd_ports O_NAND_CH5_RE_N] [get_bd_pins V2NFC100DDR_5/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_RE_P [get_bd_ports O_NAND_CH5_RE_P] [get_bd_pins V2NFC100DDR_5/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_WE [get_bd_ports O_NAND_CH5_WE] [get_bd_pins V2NFC100DDR_5/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_5_O_NAND_WP [get_bd_ports O_NAND_CH5_WP] [get_bd_pins V2NFC100DDR_5/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_ALE [get_bd_ports O_NAND_CH6_ALE] [get_bd_pins V2NFC100DDR_6/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_CE [get_bd_ports O_NAND_CH6_CE] [get_bd_pins V2NFC100DDR_6/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_CLE [get_bd_ports O_NAND_CH6_CLE] [get_bd_pins V2NFC100DDR_6/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_RE_N [get_bd_ports O_NAND_CH6_RE_N] [get_bd_pins V2NFC100DDR_6/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_RE_P [get_bd_ports O_NAND_CH6_RE_P] [get_bd_pins V2NFC100DDR_6/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_WE [get_bd_ports O_NAND_CH6_WE] [get_bd_pins V2NFC100DDR_6/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_6_O_NAND_WP [get_bd_ports O_NAND_CH6_WP] [get_bd_pins V2NFC100DDR_6/O_NAND_WP]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_ALE [get_bd_ports O_NAND_CH7_ALE] [get_bd_pins V2NFC100DDR_7/O_NAND_ALE]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_CE [get_bd_ports O_NAND_CH7_CE] [get_bd_pins V2NFC100DDR_7/O_NAND_CE]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_CLE [get_bd_ports O_NAND_CH7_CLE] [get_bd_pins V2NFC100DDR_7/O_NAND_CLE]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_RE_N [get_bd_ports O_NAND_CH7_RE_N] [get_bd_pins V2NFC100DDR_7/O_NAND_RE_N]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_RE_P [get_bd_ports O_NAND_CH7_RE_P] [get_bd_pins V2NFC100DDR_7/O_NAND_RE_P]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_WE [get_bd_ports O_NAND_CH7_WE] [get_bd_pins V2NFC100DDR_7/O_NAND_WE]
  connect_bd_net -net V2NFC100DDR_7_O_NAND_WP [get_bd_ports O_NAND_CH7_WP] [get_bd_pins V2NFC100DDR_7/O_NAND_WP]
  connect_bd_net -net pcie_perst_n_1 [get_bd_ports pcie_perst_n] [get_bd_pins NVMeHostController_0/pcie_perst_n]
  connect_bd_net -net pcie_ref_clk_n_1 [get_bd_ports pcie_ref_clk_n] [get_bd_pins NVMeHostController_0/pcie_ref_clk_n]
  connect_bd_net -net pcie_ref_clk_p_1 [get_bd_ports pcie_ref_clk_p] [get_bd_pins NVMeHostController_0/pcie_ref_clk_p]
  connect_bd_net -net pcie_rx_n_1 [get_bd_ports pcie_rx_n] [get_bd_pins NVMeHostController_0/pcie_rx_n]
  connect_bd_net -net pcie_rx_p_1 [get_bd_ports pcie_rx_p] [get_bd_pins NVMeHostController_0/pcie_rx_p]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins CH0MMCMC1H200/reset] [get_bd_pins CH2MMCMC1H200/reset] [get_bd_pins CH3MMCMC1H200/reset] [get_bd_pins Tiger4NSC_0/iReset] [get_bd_pins Tiger4NSC_1/iReset] [get_bd_pins Tiger4NSC_2/iReset] [get_bd_pins Tiger4NSC_3/iReset] [get_bd_pins Tiger4SharedKES_0/iReset] [get_bd_pins V2DCIClockConverter32_0/iMReset] [get_bd_pins V2DCIClockConverter32_0/iSReset] [get_bd_pins V2DCIClockConverter32_1/iMReset] [get_bd_pins V2DCIClockConverter32_1/iSReset] [get_bd_pins V2DCIClockConverter32_2/iMReset] [get_bd_pins V2DCIClockConverter32_2/iSReset] [get_bd_pins V2DCIClockConverter32_3/iMReset] [get_bd_pins V2DCIClockConverter32_3/iSReset] [get_bd_pins V2NFC100DDR_0/iReset] [get_bd_pins V2NFC100DDR_1/iReset] [get_bd_pins V2NFC100DDR_2/iReset] [get_bd_pins V2NFC100DDR_3/iReset] [get_bd_pins proc_sys_reset_0/peripheral_reset]
  connect_bd_net -net proc_sys_reset_1_peripheral_reset [get_bd_pins CH4MMCMC1H200/reset] [get_bd_pins CH6MMCMC1H200/reset] [get_bd_pins CH7MMCMC1H200/reset] [get_bd_pins Tiger4NSC_4/iReset] [get_bd_pins Tiger4NSC_5/iReset] [get_bd_pins Tiger4NSC_6/iReset] [get_bd_pins Tiger4NSC_7/iReset] [get_bd_pins Tiger4SharedKES_1/iReset] [get_bd_pins V2DCIClockConverter32_4/iMReset] [get_bd_pins V2DCIClockConverter32_4/iSReset] [get_bd_pins V2DCIClockConverter32_5/iMReset] [get_bd_pins V2DCIClockConverter32_5/iSReset] [get_bd_pins V2DCIClockConverter32_6/iMReset] [get_bd_pins V2DCIClockConverter32_6/iSReset] [get_bd_pins V2DCIClockConverter32_7/iMReset] [get_bd_pins V2DCIClockConverter32_7/iSReset] [get_bd_pins V2NFC100DDR_4/iReset] [get_bd_pins V2NFC100DDR_5/iReset] [get_bd_pins V2NFC100DDR_6/iReset] [get_bd_pins V2NFC100DDR_7/iReset] [get_bd_pins proc_sys_reset_1/peripheral_reset]
  connect_bd_net -net proc_sys_reset_2_peripheral_aresetn [get_bd_pins GPIC1/M00_ARESETN] [get_bd_pins GPIC1/M01_ARESETN] [get_bd_pins GPIC1/M02_ARESETN] [get_bd_pins GPIC1/S00_ARESETN] [get_bd_pins NVMeHostController_0/s0_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_2/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_3/s_axi_aresetn] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_1/M01_ARESETN] [get_bd_pins proc_sys_reset_2/peripheral_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces NVMeHostController_0/m0_axi] [get_bd_addr_segs PS/S_AXI_HP3/HP3_DDR_LOWOCM] SEG_PS_HP3_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x83C00000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs NVMeHostController_0/s0_axi/reg0] SEG_NVMeHostController_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_0/C_AXI/reg0] SEG_Tiger4NSC_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_1/C_AXI/reg0] SEG_Tiger4NSC_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_2/C_AXI/reg0] SEG_Tiger4NSC_2_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_3/C_AXI/reg0] SEG_Tiger4NSC_3_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C40000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_4/C_AXI/reg0] SEG_Tiger4NSC_4_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C50000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_5/C_AXI/reg0] SEG_Tiger4NSC_5_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C60000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_6/C_AXI/reg0] SEG_Tiger4NSC_6_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43C70000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs Tiger4NSC_7/C_AXI/reg0] SEG_Tiger4NSC_7_reg0
  create_bd_addr_seg -range 0x2000 -offset 0x80000000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs axi_bram_ctrl_1/S_AXI/Mem0] SEG_axi_bram_ctrl_1_Mem0
  create_bd_addr_seg -range 0x2000 -offset 0x80010000 [get_bd_addr_spaces PS/Data] [get_bd_addr_segs axi_bram_ctrl_3/S_AXI/Mem0] SEG_axi_bram_ctrl_3_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_0/D_AXI] [get_bd_addr_segs PS/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_PS_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80000000 [get_bd_addr_spaces Tiger4NSC_0/D_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_1/D_AXI] [get_bd_addr_segs PS/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_PS_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80000000 [get_bd_addr_spaces Tiger4NSC_1/D_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_2/D_AXI] [get_bd_addr_segs PS/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_PS_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80000000 [get_bd_addr_spaces Tiger4NSC_2/D_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_3/D_AXI] [get_bd_addr_segs PS/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_PS_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80000000 [get_bd_addr_spaces Tiger4NSC_3/D_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_4/D_AXI] [get_bd_addr_segs PS/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_PS_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80010000 [get_bd_addr_spaces Tiger4NSC_4/D_AXI] [get_bd_addr_segs axi_bram_ctrl_2/S_AXI/Mem0] SEG_axi_bram_ctrl_2_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_5/D_AXI] [get_bd_addr_segs PS/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_PS_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80010000 [get_bd_addr_spaces Tiger4NSC_5/D_AXI] [get_bd_addr_segs axi_bram_ctrl_2/S_AXI/Mem0] SEG_axi_bram_ctrl_2_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_6/D_AXI] [get_bd_addr_segs PS/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_PS_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80010000 [get_bd_addr_spaces Tiger4NSC_6/D_AXI] [get_bd_addr_segs axi_bram_ctrl_2/S_AXI/Mem0] SEG_axi_bram_ctrl_2_Mem0
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Tiger4NSC_7/D_AXI] [get_bd_addr_segs PS/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_PS_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x2000 -offset 0x80010000 [get_bd_addr_spaces Tiger4NSC_7/D_AXI] [get_bd_addr_segs axi_bram_ctrl_2/S_AXI/Mem0] SEG_axi_bram_ctrl_2_Mem0
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


