set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN U18 [get_ports reset]						
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN M18 [get_ports {lon}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {lon}]
##Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {loff}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {loff}]
	
set_property PACKAGE_PIN J1 [get_ports {pwm[7]}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {pwm[7]}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {pwm[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pwm[6]}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {pwm[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pwm[5]}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {pwm[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pwm[4]}]

set_property PACKAGE_PIN A14 [get_ports {pwm[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {pwm[3]}]

set_property PACKAGE_PIN B18 [get_ports i_RX_Serial]
    set_property IOSTANDARD LVCMOS33 [get_ports i_RX_Serial]

set_property PACKAGE_PIN U16 [get_ports {o_RX_Byte[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[0]}]
set_property PACKAGE_PIN E19 [get_ports {o_RX_Byte[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[1]}]
set_property PACKAGE_PIN U19 [get_ports {o_RX_Byte[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[2]}]

set_property PACKAGE_PIN V19 [get_ports {o_RX_Byte[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[3]}]

set_property PACKAGE_PIN W18 [get_ports {o_RX_Byte[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[4]}]

set_property PACKAGE_PIN U15 [get_ports {o_RX_Byte[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[5]}]

set_property PACKAGE_PIN U14 [get_ports {o_RX_Byte[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[6]}]

set_property PACKAGE_PIN V14 [get_ports {o_RX_Byte[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_RX_Byte[7]}]

set_property PACKAGE_PIN V13 [get_ports {del[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {del[0]}]
set_property PACKAGE_PIN V3 [get_ports {del[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {del[1]}]
set_property PACKAGE_PIN W3 [get_ports {del[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {del[2]}]
set_property PACKAGE_PIN U3 [get_ports {del[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {del[3]}]

	
set_property PACKAGE_PIN P1 [get_ports {c1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {c1}]
set_property PACKAGE_PIN L1 [get_ports {c2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {c2}]
set_property PACKAGE_PIN P3 [get_ports {c4}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {c4}]
set_property PACKAGE_PIN N3 [get_ports {c3}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {c3}]
	
#jb4
set_property PACKAGE_PIN B16 [get_ports {trivial}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {trivial}]

#Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {repulser}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {repulser}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets in1_IBUF]