# whereami
who what where (you)
`echo $(whoami)@$(hostname); cat /etc/*-release | grep PRETTY_NAME | sed -e "s/PRETTY_NAME=//" -e "s/\"//g"`
