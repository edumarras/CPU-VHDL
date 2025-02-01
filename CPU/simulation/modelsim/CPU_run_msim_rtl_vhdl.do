transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/edu11/OneDrive/Desktop/CPU/ULA.vhd}
vcom -93 -work work {C:/Users/edu11/OneDrive/Desktop/CPU/TRISTATE.vhd}
vcom -93 -work work {C:/Users/edu11/OneDrive/Desktop/CPU/REG.vhd}
vcom -93 -work work {C:/Users/edu11/OneDrive/Desktop/CPU/DATA.vhd}
vcom -93 -work work {C:/Users/edu11/OneDrive/Desktop/CPU/CONTROL.vhd}
vcom -93 -work work {C:/Users/edu11/OneDrive/Desktop/CPU/CPU.vhd}

