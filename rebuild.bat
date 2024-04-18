@ECHO OFF

REM Delete the rebuild.tcl file if it exists
ECHO Deleting rebuild.tcl...
if exist rebuild.tcl del rebuild.tcl
if exist rebuild.tcl (
    ECHO Error: Unable to delete rebuild.tcl
    EXIT /B 1
)
ECHO Done.

REM Delete the np_project directory if it exists
ECHO Deleting np_project directory...
rd /s /q .\np_project\
if exist .\np_project\ (
    ECHO Error: Unable to delete np_project directory
    EXIT /B 1
)
ECHO Done.

REM Set the origin directory
set "origin_dir=%~dp0"


REM Create the rebuild.tcl file

ECHO # rebuild.tcl: Tcl script for re-creating project 'np_project' > rebuild.tcl
ECHO # Set the project name >> rebuild.tcl
ECHO set _xil_proj_name_ "np_project" >> rebuild.tcl

ECHO # Set the origin directory path >> rebuild.tcl
ECHO set origin_dir "." >> rebuild.tcl

ECHO # Set the script file name >> rebuild.tcl
ECHO variable script_file >> rebuild.tcl
ECHO set script_file "rebuild.tcl" >> rebuild.tcl

ECHO # Set the directory path for the original project from where this script was exported >> rebuild.tcl
ECHO set orig_proj_dir "[file normalize "$origin_dir/np_project"]" >> rebuild.tcl

ECHO # Create project >> rebuild.tcl
ECHO create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7a35tcpg236-1 >> rebuild.tcl

ECHO # Set the directory path for the new project >> rebuild.tcl
ECHO set proj_dir [get_property directory [current_project]] >> rebuild.tcl

ECHO # Reconstruct message rules >> rebuild.tcl
ECHO # None >> rebuild.tcl

ECHO # Set project properties >> rebuild.tcl
ECHO set obj [current_project] >> rebuild.tcl
ECHO set_property -name "board_part" -value "digilentinc.com:basys3:part0:1.2" -objects $obj >> rebuild.tcl
ECHO set_property -name "default_lib" -value "xil_defaultlib" -objects $obj >> rebuild.tcl
ECHO set_property -name "ip_cache_permissions" -value "read write" -objects $obj >> rebuild.tcl
ECHO set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj >> rebuild.tcl
ECHO set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj >> rebuild.tcl
ECHO set_property -name "simulator_language" -value "VHDL" -objects $obj >> rebuild.tcl
ECHO set_property -name "target_language" -value "VHDL" -objects $obj >> rebuild.tcl

REM Add the source files to the project

ECHO # Create 'sources_1' fileset (if not found) >> rebuild.tcl
ECHO if {[string equal [get_filesets -quiet sources_1] ""]} { >> rebuild.tcl
ECHO    create_fileset -srcset sources_1 >> rebuild.tcl
ECHO } >> rebuild.tcl

ECHO # Set 'sources_1' fileset object >> rebuild.tcl
ECHO set obj [get_filesets sources_1] >> rebuild.tcl
ECHO set files [list \>> rebuild.tcl
for /r "%origin_dir%rtl\design" %%F in (*.vhd *.vhdl) do (
    ECHO    [file normalize "${origin_dir}/rtl/design/%%~nxF"] \
) >> rebuild.tcl
ECHO ] >> rebuild.tcl
ECHO add_files -norecurse -fileset $obj $files >> rebuild.tcl

ECHO # Set 'sources_1' fileset file properties for remote files >> rebuild.tcl
for /r "%origin_dir%rtl\design" %%F in (*.vhd *.vhdl) do (
    ECHO set file "$origin_dir/rtl/design/%%~nxF"
    ECHO set file [file normalize $file]
    ECHO set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
    ECHO set_property -name "file_type" -value "VHDL" -objects $file_obj
) >> rebuild.tcl

ECHO # Set 'sources_1' fileset file properties for local files >> rebuild.tcl
ECHO # None >> rebuild.tcl

REM Add the constraint files to the project

ECHO # Create 'constrs_1' fileset (if not found) >> rebuild.tcl
ECHO if {[string equal [get_filesets -quiet constrs_1] ""]} { >> rebuild.tcl
ECHO    create_fileset -constrset constrs_1 >> rebuild.tcl
ECHO } >> rebuild.tcl

ECHO # Set 'constrs_1' fileset object >> rebuild.tcl
ECHO set obj [get_filesets constrs_1] >> rebuild.tcl

for /r "%origin_dir%cons" %%F in (*.xdc) do (
    ECHO # Add/Import constrs file and set constrs file properties
    ECHO set file "[file normalize "${origin_dir}/cons/%%~nxF"]"
    ECHO set file_added [add_files -norecurse -fileset $obj [list $file]]
    ECHO set file "$origin_dir/cons/%%~nxF"
    ECHO set file [file normalize $file]
    ECHO set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
    ECHO set_property -name "file_type" -value "XDC" -objects $file_obj
) >> rebuild.tcl

ECHO # Set 'constrs_1' fileset properties >> rebuild.tcl
ECHO set obj [get_filesets constrs_1] >> rebuild.tcl

REM Add the simulation files to the project

ECHO # Create 'sim_1' fileset (if not found) >> rebuild.tcl
ECHO if {[string equal [get_filesets -quiet sim_1] ""]} { >> rebuild.tcl
ECHO    create_fileset -simset sim_1 >> rebuild.tcl
ECHO } >> rebuild.tcl

ECHO # Set 'sim_1' fileset object >> rebuild.tcl
ECHO set obj [get_filesets sim_1] >> rebuild.tcl
ECHO set files [list \>> rebuild.tcl
for /r "%origin_dir%rtl\simulation" %%F in (*.vhd *.vhdl) do (
    ECHO    [file normalize "${origin_dir}/rtl/simulation/%%~nxF"] \
) >> rebuild.tcl
ECHO ] >> rebuild.tcl
ECHO add_files -norecurse -fileset $obj $files >> rebuild.tcl

ECHO # Set 'sim_1' fileset file properties for remote files >> rebuild.tcl
for /r "%origin_dir%rtl\simulation" %%F in (*.vhd *.vhdl) do (
    ECHO set file "$origin_dir/rtl/simulation/%%~nxF"
    ECHO set file [file normalize $file]
    ECHO set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
    ECHO set_property -name "file_type" -value "VHDL" -objects $file_obj
) >> rebuild.tcl

ECHO # Set 'sim_1' fileset file properties for local files >> rebuild.tcl
ECHO # None >> rebuild.tcl

REM Create the Synthesis and Implementation runs

ECHO # Create 'synth_1' run (if not found) >> rebuild.tcl
ECHO if {[string equal [get_runs -quiet synth_1] ""]} { >> rebuild.tcl
ECHO    create_run -name synth_1 -part xc7a35tcpg236-1 -flow {Vivado Synthesis 2018} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset constrs_1 >> rebuild.tcl
ECHO } else { >> rebuild.tcl
ECHO    set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1] >> rebuild.tcl
ECHO    set_property flow "Vivado Synthesis 2018" [get_runs synth_1] >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_runs synth_1] >> rebuild.tcl
ECHO set_property set_report_strategy_name 1 $obj >> rebuild.tcl
ECHO set_property report_strategy {Vivado Synthesis Default Reports} $obj >> rebuild.tcl
ECHO set_property set_report_strategy_name 0 $obj >> rebuild.tcl
ECHO # Create 'synth_1_synth_report_utilization_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1      >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_runs synth_1] >> rebuild.tcl
ECHO set_property -name "strategy" -value "Vivado Synthesis Defaults" -objects $obj >> rebuild.tcl

ECHO # set the current synth run >> rebuild.tcl
ECHO current_run -synthesis [get_runs synth_1] >> rebuild.tcl

ECHO # Create 'impl_1' run (if not found) >> rebuild.tcl
ECHO if {[string equal [get_runs -quiet impl_1] ""]} { >> rebuild.tcl
ECHO    create_run -name impl_1 -part xc7a35tcpg236-1 -flow {Vivado Implementation 2018} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1 >> rebuild.tcl
ECHO } else { >> rebuild.tcl
ECHO set_property strategy "Vivado Implementation Defaults" [get_runs impl_1] >> rebuild.tcl
ECHO set_property flow "Vivado Implementation 2018" [get_runs impl_1] >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_runs impl_1] >> rebuild.tcl
ECHO set_property set_report_strategy_name 1 $obj >> rebuild.tcl
ECHO set_property report_strategy {Vivado Implementation Default Reports} $obj >> rebuild.tcl
ECHO set_property set_report_strategy_name 0 $obj >> rebuild.tcl
ECHO # Create 'impl_1_init_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1    >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_opt_report_drc_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_opt_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1      >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_power_opt_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_place_report_io_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_place_report_utilization_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1        >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_place_report_control_sets_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1      >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_place_report_incremental_reuse_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_place_report_incremental_reuse_1' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_place_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1  >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO    set_property -name "is_enabled" -value "0" -objects $obj >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_drc_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_methodology_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1        >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_power_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_route_status_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1      >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1  >> rebuild.tcl  
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_incremental_reuse_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_clock_utilization_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_route_report_bus_skew_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_route_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps route_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO # Create 'impl_1_post_route_phys_opt_report_bus_skew_0' report (if not found) >> rebuild.tcl
ECHO if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] "" ] } { >> rebuild.tcl
ECHO    create_report_config -report_name impl_1_post_route_phys_opt_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps post_route_phys_opt_design -runs impl_1 >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] >> rebuild.tcl
ECHO if { $obj != "" } { >> rebuild.tcl
ECHO } >> rebuild.tcl
ECHO set obj [get_runs impl_1] >> rebuild.tcl
ECHO set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj >> rebuild.tcl
ECHO set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj >> rebuild.tcl
ECHO set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj >> rebuild.tcl

ECHO # set the current impl run >> rebuild.tcl
ECHO current_run -implementation [get_runs impl_1] >> rebuild.tcl

ECHO puts "INFO: Project created:${_xil_proj_name_}" >> rebuild.tcl


REM Run the Vivado tool in batch mode with the rebuild.tcl script
CALL vivado -mode batch -nolog -nojournal -notrace -source rebuild.tcl

REM Delete the rebuild.tcl file if debug flag is not set
if "%1" neq "--debug" (
    del rebuild.tcl
)
