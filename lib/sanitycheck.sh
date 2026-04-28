###############################################################################
# sanity_check.lib                                             Version : 1.0  #
#                                                                             #
# Creation Date : 07/02/2007                                                  #
# Team          : Only me after all                                                                     #
# Support mail  : arnaud@crampet.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base auto sanity check to control sript env  #
#                                                                             #
###############################################################################
####
# Info

function SANITY_CHECK_Base_env_directory_check
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_env_directory_check
#|#
#|# Description : This function check and create all mandatory directories needed for CAST execution
#|#
#|# Send Back   : Directory
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

set_message "Info" "Directory Sanity check [ STARTING ] "
if [ "${SANITY_CHECK_Base_env_directory_check_exec}" = "1" ]
   then
   	   set_message "Debug7" "Sanity check for generic tmp already done"
   else
       for Dirs in $( cat ${Conf_Generics} | grep "DIR_To_CHECK" | awk -F\= '{ print $2 }' | awk '{ print $1 }' )
          do
          	Dirs=$( eval echo ${Dirs} )
			set_new_directory   "${Dirs}"
        done
fi

SANITY_CHECK_Base_env_directory_check_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Base_env_directory_check_specs
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_env_directory_check
#|#
#|# Description : This function check and create all mandatory directories needed for CAST execution
#|#
#|# Send Back   : Directory
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

if [ -z "${Conf_Specifics}" ]
    then
		set_message "Info" "Specifics configuration file : [ NONE ] "
		else
			echo "${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} ---"
			cat ${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} | grep "DIR_To_CHECK" | awk '{ echo $1 }' | awk -F\= '{echo "\$\{"$1"\}" }' 
              for Dirs in $( cat ${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} | grep "DIR_To_CHECK" | awk '{ echo $1 }' | awk -F\= '{echo "\$\{"$1"\}" }' 2> /dev/null )
                  do     Dirs=$( eval echo ${Dirs} )
                         set_message "Info" "checking base directory  : [ ${Dirs} ] "
                         Dirs=$( eval echo ${Dirs}) 
                         set_new_directory   "${Dirs}"
                         pause
                   done
        fi
set_message "Info" "Directory Sanity check [ END ] "

SANITY_CHECK_Base_env_directory_check_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Base_root_exec_check
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Base_root_exec_check
#|#
#|# Description : This function check if you are using root to execute CAST
#|#               If active it will prompt for user confirmation and send back execution in root mode in system log
#|#
#|# Send Back   : User Check
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${function_Name}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "
Spacer_MSG

set_message "Info" "User Sanity check [ STARTING ] "
My_Current_User=$( id | awk -F "[\(\)]" '{ echo $2 }' 2> /dev/null )
if [ "${My_Current_User}" = "root" ]
   then
       set_message "Info" "Your are currently running C&D toolBox with \"root\" account "
   	   PS3="Do you want to exit ? [ it's better to exit ] "
       select Result in "Continue" "EXIT"
              do
                case ${Result} in
	                 "Continue") set_message "Warning1" "User select to user root account"
	                      My_Ident="$(who i am | awk '{ echo $1 }')"
	                      set_message "LoggerN"  " $( date ) CND scripting user whith root account by [ ${My_Ident} ] " "1"
	                      ;;
	                  "EXIT") set_message "ErrorN" "User select to exit" "1"
	                      ;;
	                  *) set_message "ErrorN" "Bad input exit [ ${Result} ] " "1"
	                      ;;
                 esac
        done
      else
       set_message "Info" "you are currently running C&D toolBox with [ ${My_Current_User} ] "
       set_message "LoggerN"  "C&D toolBox launched with [ ${My_Current_User} ] at $( date ) "  "1"
fi
set_message "Info" "User Sanity check [ END ] "

Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Check_TMP_Directory
{
#|# Var to set  : None
#|#
#|# Base usage  : SANITY_CHECK_Check_TMP_Directory
#|#
#|# Description : This function check and create all mandatory writable directories needed for CAST execution
#|#
#|# Send Back   : writables Directory
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "
Spacer_MSG
if [ "${SANITY_CHECK_Check_TMP_Directory_exec}" = "1" ]
   then
   	   set_message "Debug7" "Sanity check for generic tmp already done"
   else
       for Dirs in $( cat ${Conf_Generics} | grep "DIR_To_CHECK_TMP" | awk '{ echo $1 }' | awk -F\= '{echo "\$\{"$1"\}" }' 2> /dev/null )
           do Dirs=$( eval echo ${Dirs} )
           echo  ${Dirs} | grep tmp  > /dev/null
           if  [ "${?}" = "0" ]
              then
                  IS_Writable "${Dirs}" "1"
               else
                   set_message "Debug6" "Directory ${Dirs} is : [ Not a temporary Directory ] "
            fi
        done
fi
if [ -z "${Conf_Specifics}" ]
   then
       set_message "Info" "Specifics configuration file : [ NONE ] "
          else
				for Dirs in $( cat ${Base_Dir_Scripts_CNF_spec}/${Conf_Specifics} | grep "DIR_To_CHECK_TMP" | awk '{ echo $1 }' | awk -F\= '{echo "\$\{"$1"\}" }' 2> /dev/null )
					do Dirs=$( eval echo ${Dirs} )
					echo   "${Dirs}" | grep tmp  > /dev/null
                    if  [ "${?}" = "0" ]
						then
							IS_Writable "${Dirs}" "1"
						else
							set_message "Debug6" "Directory ${Dirs} is : [ Not a temporary Directory ] "
					fi
                done
fi
SANITY_CHECK_Check_TMP_Directory_exec="1"
Spacer_MSG
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function SANITY_CHECK_Check_Language
{
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "
Spacer_MSG

if [ "${LANG}" = "${Base_Script_Language}" ]
   then
   	   set_message "Debug6" "System language  : [ ${LANG} ] "
   else
       set_message "Debug6" "System language  : [ ${LANG} ] "
       set_message "Debug5" " ACTION : [ Overriding system default language  ] "
       LANG="${Base_Script_Language}"
       export LANG
       if [ "${LANG}" = "${Base_Script_Language}" ]
          then
   	          set_message "Debug5" "Overrided System language  : [ ${LANG} ] "
          else
              set_message "Debug5" "Overrid System language  : [ ERROR ] "
              set_message "Debug5" "Somme problem on messaging display may appear  "
       fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

Sourced_OK="1"

