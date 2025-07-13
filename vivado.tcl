
set project_name [lindex $argv 0]
set bd_tcl_filename [lindex $argv 1]

# start_gui

xhub::get_xstores
xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
set xilinx_board_store_dir [get_property LOCAL_ROOT_DIR [xhub::get_xstores xilinx_board_store]]
set_param board.repoPaths $xilinx_board_store_dir

xhub::install [xhub::get_xitems digilentinc.com:xilinx_board_store:nexys4_ddr:1.1]
xhub::update [xhub::get_xitems digilentinc.com:xilinx_board_store:nexys4_ddr:1.1]

set board_part [get_board_parts digilentinc.com:nexys4_ddr:part0* -latest_file_version]

create_project project_1 ./$project_name -part [get_property PART_NAME [get_board_parts $board_part]]
set_property board_part $board_part [current_project]

set board_xml_path [exec find $xilinx_board_store_dir -type f -name board.xml -print -quit]
set board_files_dir [file dirname $board_xml_path]

# add_files -norecurse {}
# set_property file_type {Memory File} [get_files -all]

# add_files -norecurse {}

# add_files -fileset constrs_1 -norecurse {}
# set_property PROCESSING_ORDER EARLY [get_files -of_objects [get_filesets constrs_1]]

create_bd_design "design_1"
source ../$bd_tcl_filename
save_bd_design
make_wrapper -files [get_files $project_name/nexys.srcs/sources_1/bd/design_1/design_1.bd] -top -import
set_property top design_1_wrapper [current_fileset]

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE PerformanceOptimized [get_runs synth_1]
launch_runs synth_1 -jobs [exec nproc]
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs [exec nproc]
wait_on_run impl_1

exit
