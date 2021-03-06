# a board support file MUST implement the function:
#	- board_flash
#	- board_power_off

board_flash() {
	# 1 flash the device, we assume that it is a ap51 flashable device
	board_reset

	make -C ap51flash
	sudo ifconfig $LAN_IFACE up
	$SUDO timeout 500 ./ap51flash/ap51-flash $LAN_IFACE $2
	if [[ $? -eq 124 ]]; then
		exit 2
	fi
	board_reset
}


board_power_off() {
	# rly2 off
	echo 'p' > $SERIAL_PORT
}

board_reset() {
	$SUDO chmod 777 $SERIAL_PORT
	stty -F $SERIAL_PORT raw ispeed 15200 ospeed 15200 cs8 -ignpar -cstopb -echo

	# Board reset
	echo 'p' > $SERIAL_PORT
	sleep 2
	# rly2 on
	echo 'f' > $SERIAL_PORT
}

shutdown_test() {
	# Board shutdown

}
