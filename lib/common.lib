###############################################################################
# common.lib                                            Version : 1.0         #
#                                                                             #
# Creation Date : 05/02/2019                                                  #
# Team          : Arnaud Crampet                                              #
# Support mail  : arnaud@crampet.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base elements needed by C.A.S.T. scripts     #
#           this lib is based on C.A.S.T. framwork created by ARNAUD CRAMPET  #
###############################################################################
####
# INFO 
#      this lib is for all linux based systems ( may run on solaris and AIX but not supported in this version )





function do_empty_var_control()
{
#|# Description : This function is used to check if a var is empty
#|#
#|# Var to set  :
#|#                 EVC_Var_To_Test       : Use this var to set the path to test                                 ( Mandatory )
#|#                 EVC_Var_Name_To_Test  : Use this var to set the name of the var to test for display messages ( Mandatory )
#|#                 EVC_Type_Of_ERR       : Use this var to set the severity of an empty vars                    ( Mandatory )
#|#                 EVC_Level_Of_ERR      : Use this var to set the severity level of an empty vars              ( Mandatory )
#|#                 EVC_MSG_add           : Use this var to set complementary message                            ( OPTIONAL )
#|#                 EVC__on_fail_action     : Use this var to set anb action to do after CTRL fail                 ( OPTIONAL )
#|#                 EVC_Action_ONOK       : Use this var to set anb action to do after CTRL is OK                ( OPTIONAL )
#|#                 ${1}                  : Used to set [ Base_Var_to_test ]
#|#                 ${2}                  : Used to set [ Base_Var_Name_To_Test ]
#|#                 ${3}                  : Used to set [ Type_Of_ERR ]
#|#                 ${4}                  : Used to set [ Level_Of_ERR ]
#|#                 ${5}                  : Used to set [ EVC_MSG_add ]
#|#                 ${6}                  : Used to set [ _on_fail_action ]
#|#                 ${7}                  : Used to set [ Action_ONOK ]
#|#
#|# Base usage  : do_empty_var_control "My_VAR" "My_Var_Name" "ERR_type" "Level_Of_ERR" [ "MSG_add" "_on_fail_action" "Action_ONOK" ]
#|#
#|# Send Back   : Send back result of check
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

EVC_Var_To_Test="${1}"
EVC_Var_Name_To_Test="${2}"
EVC_Type_Of_ERR="${3}"
EVC_Level_Of_ERR="${4}"
EVC_MSG_add="${5}"
EVC__on_fail_action="${6}"
EVC_Action_ONOK="${7}"

if [ -z "${EVC_Var_To_Test}" ]
   then
           set_message "${EVC_Type_Of_ERR}" " Error ON VAR ${EVC_Var_Name_To_Test}  : [ Not Set ] ${MSG_Complement}" "${EVC_Level_Of_ERR}"
           if ! [ -z "${EVC__on_fail_action}" ]
              then
                   ${EVC__on_fail_action}
           fi

   else
       set_message "Debug6" " Value of ${EVC_Var_Name_To_Test}  : [ Value is ${EVC_Var_To_Test} ]"
       if ! [ -z "${EVC_Action_ONOK}" ]
          then
              ${EVC_Action_ONOK}
       fi
fi

_on_fail_action=""
Action_ONOK=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################

}

function User_Hit_a_key
{
#|# Description : This function is used for display a massage that says hit a key and pause the scripts.
#|#
#|# Var to set    : None.
#|#
#|# Base usage  : User_Hit_a_key
#|#
#|# Send Back   : Message and wait user action.
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

 
set_message "Message" "Please  : press enter to continue "
read dummy

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function set_message
{
#|# Description : This function is used for every messaging and error service
#|#
#|# Var to set    :
#|#                 MD_Type_Msg       : Use this var to set
#|#                 MD_Msg_To_Display : Use this var to set
#|#                 MD_Level_Code     : Use this var to set
#|#                 ${1}        : Use this var to set [ MD_Type_Msg ]
#|#                 ${2}        : Use this var to set [ MD_Msg_To_Display ]
#|#                 ${3}        : Use this var to set [ Level_Code ]
#|#
#|# Base usage  : set_message "MD_Type_Msg" "MD_Msg_To_Display" "Level_Code"
#|#
#|# Send Back   : Message or exit level
################################################################################
MD_Type_Msg="${1}"
MD_Msg_To_Display="${2}"
declare -i MD_Level_Code="${3}"
Set_spliter_line_MSG
Dtim=$(date +%Y\/%m\/%d\ %H\:%M)

case ${MD_Type_Msg} in 
						StMessage)	_SMessage_VAR="${Dtim} Action : ${MD_Msg_To_Display}"
									Set_spliter_line_MSG
									PR_Base_sreen_Size_limit="${Base_sreen_Size_limit}"
									;;
						EdSMessage) _EMessage_VAR="[  SUCCESS ${MD_Msg_To_Display}]"
									Base_sreen_Size_limit="${PR_Base_sreen_Size_limit}"
									printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[92m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
									;;
						EdEMessage)	_EMessage_VAR="[  ! ERROR ! ${MD_Msg_To_Display}]"
									Base_sreen_Size_limit="${PR_Base_sreen_Size_limit}"
									printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[91m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
									;;
							Debug)	Sub_MSGDebug "${MD_Type_Msg}"
									;;
							Debug*) Sub_MSGDebug "${MD_Type_Msg}"
									;;
								 *)case ${MD_Type_Msg} in
															 Info)	_SMessage_VAR="${Dtim} Information : "
																	;;
														   Message)	_SMessage_VAR="${Dtim} Message : "
																	;;
															ErrorN)  Sub_MSG_ERRORN
																	;;
																*)	printf "\\e[91m" " FATAL ERROR ON MGS FUNCTION USE "
																	printf "\\e[91m" " FUNCTION     = [ ${Function_PATH} ] "
																	printf "\\e[91m" " SUB FUNCTION = [ ${SUB_Function_Name} ]"
																	printf "\\e[91m" " Debug type   = [ ${MD_Type_Msg}  ]"
																	printf "\\e[91m" " have a nice day .... :-p "
																	printf "\\e[0m"
																	exit 2
																   ;;
									esac
									_EMessage_VAR="[ ${MD_Msg_To_Display} ]"
									Set_spliter_line_MSG
									printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[0m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
									;;
esac



Emptying_MSGS_vars
}


function Sub_MSG_ERRORN()
{
#|# Description : This function is used to print Error messages
#|#
#|# Var to set  :  None
#|#
#|# Base usage  : Sub_MSGDebug
#|#
#|# Send Back   : debug messages and exit code if needed
if [  "${MD_Level_Code}" = "0" ]
	then
		_SMessage_VAR="${Dtim} Warning ON ${Function_Name} :"
		_EMessage_VAR="[ ${MD_Msg_To_Display} ]"
		Set_spliter_line_MSG
		printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[93m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
	else
		Function_Name="$(echo ${Function_PATH} | awk -F'[/]' '{ print $NF }' )"
		_SMessage_VAR="${Dtim} ERROR ON ${Function_Name} :"
		_EMessage_VAR="[ CODE=${MD_Level_Code} [ ${MD_Msg_To_Display} ]"
		Set_spliter_line_MSG
		printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[91m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
		exit ${MD_Level_Code}
fi
}

function Sub_MSGDebug
{
#|# Description : This function is used to print debug messages
#|#
#|# Var to set  :  None
#|#
#|# Base usage  : Sub_MSGDebug
#|#
#|# Send Back   : debug messages
     _DebugLevel="$( echo ${1} | awk -FDebug '{ print $2 }')"
     _SMessage_VAR="${Dtim} Debug(${_DebugLevel}) Information :"
     _EMessage_VAR="[ ${MD_Msg_To_Display} ]"
     printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[99m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}" >> eval ${logfile}
}

function Set_spliter_line_MSG
{
#|# Description : This function is used to manage diplay size taking an update on terminal capacity.
#|#
#|# Var to set  :  None
#|#
#|# Base usage  : Set_spliter_line_MSG
#|#
#|# Send Back   : update of Base_sreen_Size_limit
    Base_sreen_Size_limit="$( tput cols )"
    Base_sreen_Size_limit="$(expr ${Base_sreen_Size_limit} - ${#_SMessage_VAR} )"
    Base_sreen_Size_limit="$(expr ${Base_sreen_Size_limit} - 16 )"
}







function Spacer_MSG
{
#|# Description : This function is used to add two empty line ( event in log file if needed)
#|#
#|# Var to set  :  None
#|#
#|# Base usage  : Spacer_MSG
#|#
#|# Send Back   : two empry line 
printf "\e[0m" ""          
printf "\e[0m" ""        
}

function Emptying_MSGS_vars
{
#|# Description : This function is used to clear all messagin variables
#|#
#|# Var to set  :  None
#|#
#|# Base usage  : Emptying_MSGS_vars
#|#
#|# Send Back   : Emptyed variables
MD_Type_Msg=""
MD_Msg_To_Display=""
Err_Question_Msg=""
Err_Msg=""
}

############################### Networking 


function Get_SrvIp() 
{
#|# Description : This function is used to get server ip ( IPV4 )
#|#
#|# Var to set  : None.
#|#
#|# Base usage  : Get_SrvIp
#|#
#|# Send Back   : Udated global variable : GLB_SRVIP
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
GLB_SRVIP=$(ifconfig -a | grep inet | egrep -v inet6 | egrep -v 127\.0\.0\.1 | head -1 | awk '{ print $2 }')
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function Report_result()
{
	#|# Description :  this function will repport application of the rulle on success 
	#|#
	#|# Var to set  : None
	#|#
	#|# Base usage  : Report_result "${_element_report_num}" "_element_report_txt" "_element_state"
	#|#
	#|# Send Back   :  report Line
	############ STACK_TRACE_BUILDER #####################
	Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
	######################################################
	_element_report_num="${1}"
	_element_report_txt="${2}"
	_element_state="${3}"
	set_message "StMessage"  "Apply of : ${_element_report_num}  ${_element_report_txt} "
	
	if [ "${_element_state}" = "TEST PASSED" ] 
		then 
			
			set_message "EdSMessage" "${_element_state}"

		else
			set_message "StMessage"  "Apply of : ${_element_report_num}  ${_element_report_txt} "
			set_message "EdEMessage" "${_element_state}"
	fi
	 echo "<tr><td>${_element_report_num}</td><td>${_element_report_txt}</td><td>${_element_state}</td></tr>"  >> /tmp/report.html

	############### Stack_TRACE_BUILDER ################
	Function_PATH="$( dirname ${Function_PATH} )"
	####################################################
}

Sourced_OK="1"