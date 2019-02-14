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
echo ""
MSG_DISPLAY "Info" "Appliying level 1" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_1.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
echo ""
MSG_DISPLAY "Info" "Appliying level 2" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_2.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 

MSG_DISPLAY "Info" "Appliying level 3" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_3.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
echo ""
MSG_DISPLAY "Info" "Appliying level 4" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_4.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
echo ""
MSG_DISPLAY "Info" "Appliying level 5" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_5.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
echo ""
MSG_DISPLAY "Info" "Appliying level 6" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_6.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
echo ""
MSG_DISPLAY "Info" "Appliying level 7" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_7.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
echo ""
MSG_DISPLAY "Info" "Appliying level 8" "0"
echo "" 
for Secure in $( cat ${Base_Dir_Scripts_Lib}/security/security_8.lib | grep ^function | egrep -v \# | grep "\\." | awk '{ print $2 }' ) 
	do 
		
		${Secure} "apply"
done 
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