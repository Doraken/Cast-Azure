#/bin/bash 
###############################################################################
# Subject    : Full securing script for redhat 7.6                            #
# Author     : Arnaud Crampet                                                 #
# Created on : 31/01/2018                                                     #
# Mail       : arnaud.crampet@sogeti.com / arnaud@crampet.net                 #
###############################################################################
# Extract from CAST framwork property of Arnaud Crampet 
###############################################################################
Function_PATH="/$0"
Conf_Generics="../conf/config.cnf"
Conf_Specifics=""
Return_Path="$(pwd)" 
Debug_state="9"



function Internet_Http_Get
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  :               
#|#                 Base_Param_URL          : Use this var to set the base URL tu use for WGET
#|#                 Base_Param_File_To_Get  : Use this var to set the file to download with WGET
#|#                    PWD_Recept_PKG          : Use this var to set the directory for reception of file downloaded
#|#                 Base_Url_Parameter      : Use this var to add any needed parameter to download file.
#|#
#|# Base usage  : Internet_Http_Get "My_URL" "My_file" "My_pkg_repository" "My_url_param"
#|#
#|# Send Back   : downloaded file     
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

Base_Param_URL="${1}"
Base_Param_File_To_Get="${2}"
PWD_Recept_PKG="${3}"
Base_Url_Parameter="${4}"

Control_Check_wget_status

MSG_DISPLAY "Debug5" "Recept Directory is set to  : [ ${PWD_Recept_PKG} ] "

Directory_CRT "${PWD_Recept_PKG}"

if [ -e "${PWD_Recept_PKG}/${Base_Param_File_To_Get}" ]
   then
      MSG_DISPLAY "Info" "File Allready Downloaded : [ ${Base_Param_File_To_Get} : OK ]  ] "
   else
        DLW_Final_URL="${Base_Param_URL}/${Base_Param_File_To_Get}${Base_Url_Parameter}"
        MSG_DISPLAY "Debug2" "DLW_Final_URL is set to   : [ ${DLW_Final_URL} ] "
        wget  ${WGET_OPTIONS} --directory-prefix=${PWD_Recept_PKG} ${DLW_Final_URL}
        if [ ! -e "${PWD_Recept_PKG}/${Base_Param_File_To_Get}" ]
           then
               MSG_DISPLAY "ErrorN" " File Downloaded : [ ${Base_Param_File_To_Get} : Failled ]  " "1"
           else
               MSG_DISPLAY "Info" "File Downloaded : [ ${Base_Param_File_To_Get} : OK ]  ] "
         fi
  fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function ServMan () 
{
#|# Description : This function is used to manage services using systemctl 
#|#
#|# Var to set    :
#|#                 _serviceName   : Use this var to set wich service to manage
#|#                 _ServiceAction : Use this var to set to set kind of action (stop/start/retart)
#|#                 _ServiceStatC  : Use this var to set of desired state is critical 
#|#                 ${1}            : Use this var to set [ _serviceName ]
#|#                 ${2}            : Use this var to set [ _ServiceAction ]
#|#                 ${3}            : Use this var to set [ _ServiceStatC ]
#|#
#|# Base usage  : ServMan "_serviceName" "_ServiceAction" "_ServiceStatC"
#|#
#|# Send Back   : Message or exit level and service managment
################################################################################
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

_serviceName="${1}"
_ServiceAction="${2}"
_ServiceStatC="${3}"

Empty_Var_Control "${_serviceName}" "_serviceName" "ErrorN" "8" 
Empty_Var_Control "${_ServiceAction}" "_ServiceAction" "ErrorN" "8" 
Empty_Var_Control "${_ServiceStatC}" "_ServiceStatC" "ErrorN" "8" 

service ${_serviceName} ${_ServiceAction} 2>>${logfile} >>${logfile}
CTRL_Result_func "${?}" "applying action [ ${_ServiceAction} ] on service ${_serviceName} " "Failled" "_ServiceStatC" "" ""
sleep 2
_ActServiceStat="$(service ${_serviceName} status | grep  Active: | awk '{ print $2 }')"

case ${_ServiceAction} in 
       "start") if [[ "${_ActServiceStat}" != "active" ]] 
                    then 
                        MSG_DISPLAY "ErrorN" " Service ${_serviceName} fail to reach state  : [ "active" ]" "2"
                    else 
                        MSG_DISPLAY "Info" " Service ${_serviceName} reach state  : [ "${_ActServiceStat}" ]" "2"
                fi
                ;;
        "stop") if [[ "${_ActServiceStat}" != "inactive" ]] 
                    then 
                        MSG_DISPLAY "ErrorN" " Service ${_serviceName} fail to reach state  : [ "inactive" ]" "2"
                    else 
                        MSG_DISPLAY "Info" " Service ${_serviceName} reach state  : [ "${_ActServiceStat}" ]" "2"
                fi
                ;;
              *)  MSG_DISPLAY "ErrorN" " Service ${_serviceName} fail to reach stable state  : [ "${_ActServiceStat}" ]" "2"
            ;;
esac 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

############################## End of CAST framwork extract ###################


function Set_IPV6off ()
{
#|# Description         : This function is used to build to kill IPV6.
#|# 
#|# Var to set           : None.
#|#
#|# Send Back            : IPV6 disabling
#|#
#|# Send Back           : Message and file or exit level
################################################################################
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
    sysctl -w net.ipv6.conf.all.disable_ipv6=1
    CTRL_Result_func "${?}" "applying action IPV6  Live configuration " "Failled" "8" "" ""
    sysctl -w net.ipv6.conf.default.disable_ipv6=1
    CTRL_Result_func "${?}" "applying action IPV6 Live configuration " "Failled" "8" "" ""
    File_Backup "/etc/sysctl.conf"
    echo "options ipv6 disable=1                               
    # IPv6 support in the kernel, set to 0 by default    
    net.ipv6.conf.all.disable_ipv6 = 1                   
    net.ipv6.conf.default.disable_ipv6 = 1               " >  /etc/sysctl.conf
    CTRL_Result_func "${?}" "applying action IPV6 configuration in file : /etc/sysctl.conf " "Failled" "8" "" ""
    sysctl -p
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}
function Set_sshdconfig ()
{
#|# Description : This function is used to update SSH configuration 
#|#
#|# Var to set  : None.
#|#
#|# Base usage  : Set_sshdconfig
#|#
#|# Send Back   : updated sshd config and service restart
################################################################################
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}" 
######################################################
File_Backup "/etc/ssh/sshd_config"
sed -i s/\#Port\ 22/Port\ 22/g                                         /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh port configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#ListenAddress/ListenAddress/g /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh ListenAddress configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#SyslogFacility\ AUTH/SyslogFacility\ AUTH/g                 /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh SyslogFacility configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#LogLevel\ INFO/LogLevel\ INFO/g                             /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh LogLevel configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#LoginGraceTime\ 2m/LoginGraceTime\ 2m/g                  /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh LoginGraceTime configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#PermitRootLogin\ yes/PermitRootLogin\ no/g                  /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh PermitRootLogin configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
#sed -i s/\#StrictModes\ yes/StrictModes\ yes/g                      /etc/ssh/sshd_config 
#CTRL_Result_func "${?}" "applying ssh StrictModes configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#MaxAuthTries\ 6/MaxAuthTries\ 6/g                          /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh MaxAuthTries configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#MaxSessions\ 10/MaxSessions\ 10/g                         /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh MaxSessions configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#PubkeyAuthentication\ yes/PubkeyAuthentication\ yes/g     /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh PubkeyAuthentication configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""
sed -i s/\#Banner\ none/Banner\ \\/etc\\/Banner/g                     /etc/ssh/sshd_config 
CTRL_Result_func "${?}" "applying ssh port configuration : /etc/ssh/sshd_config " "Failled" "8" "" ""

echo "
   ____   ____  _____  __  __   ___    ____   ___      
  / __/  / __/ / ___/ / / / /  / _ \  / __/  / _ \     
 _\ \   / _/  / /__  / /_/ /  / , _/ / _/   / // /     
/___/  /___/  \___/  \____/  /_/|_| /___/  /____/      
                                                       
        ____   ____   ___   _   __   ____   ___        
       / __/  / __/  / _ \ | | / /  / __/  / _ \       
      _\ \   / _/   / , _/ | |/ /  / _/   / , _/       
     /___/  /___/  /_/|_|  |___/  /___/  /_/|_|        
                                                       
            _   __       ___     ___                   
           | | / /      <  /    / _ \                  
           | |/ /       / /  _ / // /                  
           |___/       /_/  (_)\___/                   
                                                       
                                                            
ALERT! You are entering into a secured area! Your IP, Login Time,
Username has been noted and has been sent to the server administrator!
This service is restricted to authorized users only. All activities on
this system are logged.
Unauthorized access will be fully investigated and reported to the 
appropriate law enforcement agencies.
    
" >     /etc/Banner 
CTRL_Result_func "${?}" "applying action sshdbanner configuration " "Failled" "8" "" ""
chmod +r /etc/Banner
CTRL_Result_func "${?}" "Making sshd banner readable for all" "Failled" "8" "" ""
ServMan "sshd" "stop" "8"
ServMan "sshd" "start" "8"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function FS-check () 
{
#|# Description         : This function is used to build to kill IPV6
#|#
#|# Var to set          : None.
#|#
#|# Base usage          : install_pythonpip
#|#
#|# Send Back           : Message and file or exit level
################################################################################
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}" 
######################################################
_NeededFs="/tmp /var /var/log /home"

for fsc in ${_NeededFs}
  do 
     mount | grep "on ${fsc} "
    CTRL_Result_func "${?}" "FS checking on ${fsc}" "Failled" "0" "" ""
            
done  
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}
    
function fs_secure_tmp () 
{
_TMP_FS_OPT="noexec,nodev,nosuid"


grep -e "^/tmp" /etc/fstab | grep /var/tmp 
/tmp /var/tmp none rw,noexec,nosuid,nodev,bin 0 0 
# mount | grep $(awk ‘{if ($2 == “/tmp”) print $1}’ /etc/fstab ) 



}

function fs_secure_home () 
{
_HOME_FS_OPT="nodev,nosuid"



}

function Network_config ()
{

echo "net.ipv4.conf.all.send_redirects = 0" 
echo "net.ipv4.conf.default.send_redirects = 0"


}




function set_default_start_target () 
{
MSG_DISPLAY "Info" "Rule : 3.1.1     Remove X Windows"

MSG_DISPLAY "Info" "Rule : 3.2       Disable Avahi Server"
systemctl stop avahi-daemon
systemctl disable avahi-daemon 


}


function Set_Boot_Loader_Password
{
MSG_DISPLAY "Info" "Rule : 1.6.2     Set Boot Loader Password"
File_Backup "/boot/grub2/user.cfg"
MSG_DISPLAY "Info" "registering default root password for grub :   [ writing ] "
echo "GRUB2_PASSWORD=grub.pbkdf2.sha512.10000.70C11461A4C0C8E6CA23266059DE6E580629A9DB5167B832B97F59FDF9AA224E06FFE9165D2E51C331B6C6705D0DA3D30E841F49C4069662D9DE3F26D74B124F.D77E49B529661BA08BDA99EFEED58C3F888B71720EFE9CF824F60E0C6CF8310A1A67AB83350962B9F875448BC844E0D6D1E918FD1B4207724BEDBA717FB5AE93" > /boot/grub2/user.cfg 
MSG_DISPLAY "Info" "updating grup config grub :   [ runnning ] "
grub2-mkconfig >>  ${logfile} 
CTRL_Result_func "${?}" "grub configuration update" "Failled" "0" "" ""

}

function sys_Core_change
{
MSG_DISPLAY "Info" "Rule : 1.7.1     Restrict Core Dumps"
MSG_DISPLAY "Info" "Rule : 1.7.2     Enable Randomized Virtual Memory Region Placement"

File_Backup "/etc/security/limits.conf"
File_Backup "/etc/sysctl.conf"

echo "* hard core 0"                                  >> /etc/security/limits.conf
echo "fs.suid_dumpable = 0"                           >> /etc/sysctl.conf
echo "kernel.randomize_va_space = 2"                  >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.1.1     Disable IP Forwarding "
echo "net.ipv4.ip_forward = 0"                        >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.1.2     Disable Send Packet Redirects"
echo "net.ipv4.conf.all.send_redirects = 0"           >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0"       >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.1     Disable Source Routed Packet Acceptance"
echo "net.ipv4.conf.all.accept_source_route = 0"      >> /etc/sysctl.conf 
echo "net.ipv4.conf.default.accept_source_route = 0"  >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.5     Disable ICMP Redirect Acceptance"
echo "net.ipv4.conf.all.accept_redirects = 0"         >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects = 0"     >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.6     Disable Secure ICMP Redirect Acceptance"
echo "net.ipv4.conf.all.secure_redirects = 0"         >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects = 0"     >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.7     Log Suspicious Packets"
echo "net.ipv4.conf.all.log_martians = 1"             >> /etc/sysctl.conf
echo "net.ipv4.conf.default.log_martians = 1 "        >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.8     Enable Ignore Broadcast Requests"
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1"       >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.9     Enable Bad Error Message Protection" 
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.10    Enable RFC-recommended Source Route Validation"
echo "net.ipv4.conf.all.rp_filter = 1"                >> /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 1"            >> /etc/sysctl.conf
MSG_DISPLAY "Info" "Rule : 4.2.11    Enable TCP SYN Cookies"
echo "net.ipv4.tcp_syncookies = 1"                    >> /etc/sysctl.conf

MSG_DISPLAY "Info" "Rule : 4.5       Uncommon Network Protocols"
echo "install dccp /bin/true" >> /etc/modprobe.d/UNP.conf
echo "install sctp /bin/true" >> /etc/modprobe.d/UNP.conf
echo "install rds /bin/true"  >> /etc/modprobe.d/UNP.conf
echo "install tipc /bin/true" >> /etc/modprobe.d/UNP.conf





}



 


function fs_secure_unused () 
{

## Refer to 1.1.7    Disable mounting certain type of filesystems
_inibit_file="/etc/modprobe.d/uncommonfs.conf"

MSG_DISPLAY "Info" "disabing FS [ cramfs,freevxfs,jffs2,hfs,hfsplus,squashfs,udf ] :   [ starting ] "
echo "install cramfs /bin/true"   > ${_inibit_file}
echo "install freevxfs /bin/true" >> ${_inibit_file} 
echo "install jffs2 /bin/true"    >> ${_inibit_file} 
echo "install hfs /bin/true"      >> ${_inibit_file} 
echo "install hfsplus /bin/true"  >> ${_inibit_file} 
echo "install squashfs /bin/true" >> ${_inibit_file} 
echo "install udf /bin/true"      >> ${_inibit_file}
MSG_DISPLAY "Info" "disabing FS [ cramfs,freevxfs,jffs2,hfs,hfsplus,squashfs,udf ] :   [ end ] "

}


function Redhat_secure_yum_key_check_sub 
{
# refer to 1.3.2    Verify that gpgcheck is Globally Activated 
CRF_Generic_Base_MSG="GPG checking for yum"
CRF_Generic_Base_MSG_ERR="configuration failled"
if [ ${_GPGCHECKSTATUS} = "gpgcheck=1" ] 
    then 
        MSG_DISPLAY "Info" "${CRF_Generic_Base_MSG}  [ OK  ] "
    else
        MSG_DISPLAY "ErrorN" "${CRF_Generic_Base_MSG} ${CRF_Generic_Base_MSG_ERR} [ ERROR  ] " "0"
        if [ ${_GPGupdtry} = "1" ] 
            then 
                MSG_DISPLAY "ErrorN" "${CRF_Generic_Base_MSG} can t update configuration  [ ERROR  ] " "8"
            else 
                _GPGupdtry="1"
                Redhat_secure_yum_key_check
        fi
fi
}














function main () 
{
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
### Sourcing Specifics Configurations Files
echo "" ; echo "" ; echo "" ; echo ""

echo [ Info   :  script  INIT ]

CNF_SRC="0"
. ${Conf_Generics}
if [ "${CNF_SRC}" = "1" ]
   then
       echo " Sourcing base configuration File : [ OK ] "
   else
       echo " Sourcing  base configuration File  : [ ERROR ]"
       exit 1
fi
SRC_AUTO
touch /etc/modprobe.conf
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

ntpserver="51.15.177.17"


main