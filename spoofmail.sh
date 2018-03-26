#!/bin/bash

while true
do
    sm=0
	clear
	if [[ ! -d /bin/spoofmail/smtp ]]
	then
		mkdir /bin/spoofmail
        mkdir /bin/spoofmail/smtp
	fi
	echo "███████╗██████╗  ██████╗  ██████╗ ███████╗    ███╗   ███╗ █████╗ ██╗██╗     ";
    echo "██╔════╝██╔══██╗██╔═══██╗██╔═══██╗██╔════╝    ████╗ ████║██╔══██╗██║██║     ";
    echo "███████╗██████╔╝██║   ██║██║   ██║█████╗      ██╔████╔██║███████║██║██║     ";
    echo "╚════██║██╔═══╝ ██║   ██║██║   ██║██╔══╝      ██║╚██╔╝██║██╔══██║██║██║     ";
    echo "███████║██║     ╚██████╔╝╚██████╔╝██║         ██║ ╚═╝ ██║██║  ██║██║███████╗";
    echo "╚══════╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝";
    echo "                                M3-Sec.        V: 0.02    ";
    echo "                                                                            ";
    echo "";
    echo -e "YOU SHOULD FIRST SIGN UP ON https://www.smtp2go.com AND VERIFY YOUR EMAIL."
	echo -e "THEN GO TO https://app.smtp2go.com/settings/users AND MAKE A USERNAME AND PASS."
	if [[ ! -f /bin/spoofmail/smtp/smtpemail.txt ]]
	then
		echo -e " 1) Set your SMTP username and pass     NOT SET"
	else
		read smtpemail < /bin/spoofmail/smtp/smtpemail.txt
		echo -e " 1) Set your SMTP username and pass     Current: ""$smtpemail"
	fi
	echo -e " 2) Send a spoofed email"
	echo -e " 3) Clear your SMTP username and pass from spoofmail"
	echo -e " 4) Fix email failed"
	echo -e " 5) Update this tool"
	echo -e " 0) EXIT"
	read SMTP
	if [[ "$SMTP" = "1" ]]
	then
		clear
		echo -e "Enter your smtp username(find it here: https://app.smtp2go.com/settings/users ): "
		read SMTPEMAIL
		echo -e "Enter your smtp password : "
		read SMTPPASS
		clear
		echo "$SMTPEMAIL" > /bin/spoofmail/smtp/smtpemail.txt
		echo "$SMTPPASS" > /bin/spoofmail/smtp/smtppass.txt 
		echo -e "Credentials saved on /bin/spoofmail/smtp"
		sleep 3
	elif [[ "$SMTP" = "4" ]]
	then
		clear	
		echo -e "If you email fails, the reason is because option 1 wasn't set correctly. Find username and password at https://app.smtp2go.com/settings/users."
		sleep 2
		echo -e "$PAKTGB"
		read -e -n 1 -r
	elif [[ "$SMTP" = "3" ]]
	then
		if [[ -f /bin/spoofmail/smtp/smtpemail.txt ]]
		then
			rm /bin/spoofmail/smtp/smtpemail.txt
			echo -e "Username removed"
		else
			echo -e "Not username found"
		fi
		if [[ -f /bin/spoofmail/smtp/smtppass.txt ]]
		then
			rm /bin/spoofmail/smtp/smtppass.txt
			echo -e "Password removed"
		else
			echo -e "Not password found"
		fi
		sleep 2
		continue
	elif [[ "$SMTP" = "5" ]]
	then
		exit
		cd
		rm -rf spoofmail
		git clone https://github.com/M3-SEC/spoofmail.git
		cd spoofmail
		chmod +x spoofmail.sh
		./spoofmail.sh
	elif [[ "$SMTP" = "0" ]]
	then
		clear
		exit
	elif [[ "$SMTP" = "2" ]]
	then
		while true
		do
		clear
		if [[ ! -f /bin/spoofmail/smtp/smtpemail.txt ]]
		then
			echo -e "No smtp username found."
			sm=1
		fi
		if [[ ! -f /bin/spoofmail/smtp/smtppass.txt ]]
		then
			echo -e "No smtp pass found."
			sm=1
		fi
		if [[ "$sm" = 1 ]]
		then
			break
		fi
		read smtppass < /bin/spoofmail/smtp/smtppass.txt
		read smtpemail < /bin/spoofmail/smtp/smtpemail.txt
		clear
		echo -e "Your username is $smtpemail"
		echo -e ""
		echo -e "Enter the target's email: "
		read TARGETSEMAIL
		echo -e "Enter the email that you want the target to see: "
		read SPOOFEDEMAIL
		echo -e "Enter the subject of the message: "
		read SUBJECTEMAIL
		echo -e "Enter the message: "
		read MESSAGEEMAIL
		echo -e "Enter the smtp server   (Enter=mail.smtp2go.com): "
		read SMTPSERVER
		if [[ "$SMTPSERVER" = "" ]]
		then
			SMTPSERVER="mail.smtp2go.com"
		fi
		echo -e "Enter the smtp port  (Enter=2525): "
		read SMTPPORT
		if [[ "$SMTPPORT" = "" ]]
		then
			SMTPPORT="2525"
		fi
		echo -e "Press enter to send the message to "$TARGETSEMAIL""
		read 
		clear
		sendemail -f $SPOOFEDEMAIL -t $TARGETSEMAIL -u $SUBJECTEMAIL -m $MESSAGEEMAIL -s "$SMTPSERVER":"$SMTPPORT" -xu "$smtpemail" -xp "$smtppass"
		echo -e "$PAKTGB"
		read -e -n 1 -r
		break
		done
	fi
done
}