#!/bin/bash

# CHECK PERMISSION AND DIRECTORY
if [ ! $UID -eq 0 ]; then
	echo "Permission denied."
	exit 1
elif [ ! -d /usr/share/plymouth/themes ]; then
	echo "Please setup plymouth."
	exit 1
fi

if [ ! $1 ]; then
	echo "Please choose theme at least one."
	echo "Example: ~# install.sh serene-logo"
	exit 1
fi

_ERROR=0
SCRIPT_DIR=$(cd $(dirname $0); pwd)

for ((i=1; i <= $#; i++)); do
	case ${!i} in

		# INSTALL serene-logo
		"serene-logo" ) \
		rm -rf /usr/share/plymouth/themes/serene-logo/* || \
		mkdir /usr/share/plymouth/themes/serene-logo && \
		cp $SCRIPT_DIR/serene-logo/loading/* /usr/share/plymouth/themes/serene-logo/ && \
		cp $SCRIPT_DIR/serene-logo/shutdown/* /usr/share/plymouth/themes/serene-logo/ && \
		cp $SCRIPT_DIR/serene-logo/misc/* /usr/share/plymouth/themes/serene-logo/ && \
		echo "installing serene-logo done." || let _ERROR++
		# APPLY serene-logo IN UBUNTU
		_ERROR=$(($_ERROR+`diff <(echo Ubuntu) <(lsb_release -i | awk '{print $3}') >/dev/null 2>&1; echo $?`))
		if [ ! $_ERROR -gt 0 ]; then
		        echo "applying serene-logo for Ubuntu......"
			update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/serene-logo/serene-logo.plymouth 100 >/dev/null 2>&1 && \
			update-initramfs -u >/dev/null 2>&1 && \
			echo "APPLY serene-logo DONE !!" || let _ERROR++
		fi

		# INSTALL serene-mso
		"serene-mso" ) \
		rm -rf /usr/share/plymouth/themes/serene-mso/* || \
		mkdir /usr/share/plymouth/themes/serene-mso && \
		cp $SCRIPT_DIR/serene-mso/booting/* /usr/share/plymouth/themes/serene-mso/ && \
		cp $SCRIPT_DIR/serene-mso/misc/* /usr/share/plymouth/themes/serene-mso/ && \
		echo "installing serene-mso done." || let _ERROR++
		# APPLY serene-mso IN UBUNTU
		_ERROR=$(($_ERROR+`diff <(echo Ubuntu) <(lsb_release -i | awk '{print $3}') >/dev/null 2>&1; echo $?`))
		if [ ! $_ERROR -gt 0 ]; then
		        echo "applying serene-mso for Ubuntu......"
			update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/serene-mso/serene-mso.plymouth 100 >/dev/null 2>&1 && \
			update-initramfs -u >/dev/null 2>&1 && \
			echo "APPLY serene-mso DONE !!" || let _ERROR++
		fi

		# INSTALL serene-old
		"serene-old" ) \
		rm -rf /usr/share/plymouth/themes/serene-old/* || \
		mkdir /usr/share/plymouth/themes/serene-old && \
		cp $SCRIPT_DIR/serene-old/main/* /usr/share/plymouth/themes/serene-old/ && \
		cp $SCRIPT_DIR/serene-old/misc/* /usr/share/plymouth/themes/serene-old/ && \
		echo "installing serene-old done." || let _ERROR++
		# APPLY serene-old IN UBUNTU
		_ERROR=$(($_ERROR+`diff <(echo Ubuntu) <(lsb_release -i | awk '{print $3}') >/dev/null 2>&1; echo $?`))
		if [ ! $_ERROR -gt 0 ]; then
		        echo "applying serene-old for Ubuntu......"
			update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/serene-old/serene-old.plymouth 100 >/dev/null 2>&1 && \
			update-initramfs -u >/dev/null 2>&1 && \
			echo "APPLY serene-old DONE !!" || let _ERROR++
		fi

	esac
done

# ERROR!
if [ $_ERROR -gt 0 ]; then
	echo "ERROR HAS OCCURED."
	exit $_ERROR
fi
