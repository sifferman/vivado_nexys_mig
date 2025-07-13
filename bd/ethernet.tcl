
# https://github.com/search?q=%2Fdigilentinc.com%3Anexys4_ddr%2F+%2Fcreate_bd_cell+-type+ip+-vlnv+xilinx.com%3Aip%3Aaxi_ethernetlite%2F+language%3ATcl+&type=code

# set axi_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet:7.2 axi_ethernet_0 ]
# set axi_ethernetlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0 ]

set mig_7series_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.2 mig_7series_0 ]
set_property CONFIG.XML_INPUT_FILE $board_files_dir/mig.prj $mig_7series_0
make_bd_intf_pins_external  [get_bd_intf_pins mig_7series_0/DDR2]
