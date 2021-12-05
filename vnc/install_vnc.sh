#! /bin/bash

### Install VNC

function install_vnc
{
	echo 
	echo "Starting to install desktop, browser, and VNC server..."
	echo 
	echo "Press Enter to continue."
	read catch_all
	echo 
	if [ "$OS" = "DEBIAN10" ] ; then
		sudo apt-get install xfce4 xfce4-goodies firefox-esr tigervnc-standalone-server tigervnc-common -y
	else 
		sudo apt-get install xfce4 xfce4-goodies firefox tigervnc-standalone-server tigervnc-common -y
	fi
	say "Desktop, browser, and VNC server successfully installed." green
	echo "Starting to configure VNC server..."
	sleep 2
	echo 
	sudo mkdir $HomeDir/.vnc
   sudo touch $HomeDir/.vnc/xstartup
   sudo tee -a $HomeDir/.vnc/xstartup <<END
#!/bin/bash
xrdb $HomeDir/.Xresources
startxfce4 &
END

   sudo tee -a /etc/systemd/system/vncserver@.service <<END
[Unit]
Description=a wrapper to launch an X server for VNC
After=syslog.target network.target
[Service]
Type=forking
User=$USER
Group=$USER
WorkingDirectory=$HomeDir
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 -localhost :%i
ExecStop=/usr/bin/vncserver -kill :%i
[Install]
WantedBy=multi-user.target
END

	vncpassbinpath=/usr/bin/vncpasswd
	sudo tee -a /usr/bin/expect <<END
spawn "$vncpassbinpath"
expect "Password:"
send "$vnc_password\r"
expect "Verify:"
send "$vnc_password\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"
expect eof
exit
END
	vncserver
	sleep 2
	vncserver -kill :1
	systemctl start vncserver@1.service
	systemctl enable vncserver@1.service
	/usr/bin/vncconfig -display :1 &

   sudo tee -a $HomeDir/Desktop/EnableCopyPaste.sh <<END
#!/bin/bash
/usr/bin/vncconfig -display :1 &
END

	chmod +x $HomeDir/Desktop/EnableCopyPaste.sh
	echo 
	ss -lnpt | grep vnc > /dev/null
	if [ $? = 0 ] ; then
		say @B"VNC and desktop successfully configured!" green
		echo 
	else
		say "VNC installation failed!" red
		say @B"Please check the above log for reasons." yellow
		echo "Please also consider to report your log here https://github.com/Har-Kuun/OneClickDesktop/issues so that I can fix this issue."
		echo "Thank you!"
		exit 1
	fi
}
install_vnc