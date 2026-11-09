# distro_name
echo the name of your distro
`cat /etc/*-release | grep PRETTY_NAME | sed -e "s/PRETTY_NAME=//" -e "s/\"//g"`
