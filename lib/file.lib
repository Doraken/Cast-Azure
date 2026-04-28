###############################################################################
# file.lib                                              Version : 1.0         #
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



function File_Ctrl_Ext()
{
#|# Description : This function is used to chek if a file had the goos extention.
#|#
#|# Var to set  :
#|# INTERNAL_File_To_TEST      : Use this var to set the fileto test                   ( Mandatory )
#|# INTERNAL_Ext_To_TEST       : Use this var to set the ext to test                   ( Mandatory )
#|# INTERNAL_CRITICITY_OF_FAIL : Use this var to set the level of the error            ( Mandatory )
#|# INTERNAL_ACTION_ON_FAIL    : Use this var to set the action to do if the test FAIL ( Optional )
#|# INTERNAL_ACTION_ON_SUCCESS : Use this var to set the action to do if the test FAIL ( Optional )
#|# ${1}                       : use this var to set [ INTERNAL_File_To_TEST ]
#|# ${2}                       : use this var to set [ INTERNAL_Ext_To_TEST ]
#|# ${3}                       : use this var to set [ INTERNAL_CRITICITY_OF_FAIL ]
#|# ${4}                       : use this var to set [ INTERNAL_ACTION_ON_FAIL ]
#|# ${5}                       : use this var to set [ INTERNAL_ACTION_ON_SUCCESS ]
#|#
#|# Base usage  : File_Ctrl_Ext "My_File" "My_ext" "INTERNAL_CRITICITY_OF_FAIL" "INTERNAL_ACTION_ON_FAIL" "INTERNAL_ACTION_ON_SUCCESS"
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

INTERNAL_File_To_TEST="${1}"
INTERNAL_Ext_To_TEST="${2}"
INTERNAL_CRITICITY_OF_FAIL="${3}"
INTERNAL_ACTION_ON_FAIL="${4}"
INTERNAL_ACTION_ON_SUCCESS="${5}"

INTERNAL_EXT_SIZE="$( echo ${INTERNAL_Ext_To_TEST} | awk -F\. '{ print NF }' )"
INTERNAL_FILE_EXT_SIZE="$( echo ${INTERNAL_File_To_TEST} | awk -F\. '{ print NF }'  )"
INTERNAL_FILE_EXT_SIZE="$( expr ${INTERNAL_FILE_EXT_SIZE} - 1 )"

RUN_IN="1"
FIELD_TO_GET="2"
FILE_FINAL_EXT=$(echo "${INTERNAL_File_To_TEST}" | awk -F\. -v VAR1=${FIELD_TO_GET} '{ print $VAR1 }' )
until [ "${RUN_IN}" = "${INTERNAL_FILE_EXT_SIZE}" ]
     do
       RUN_IN="$( expr ${RUN_IN} + 1 )"
       FIELD_TO_GET="$( expr ${FIELD_TO_GET} + 1 )"
       FILE_FINAL_EXT="${FILE_FINAL_EXT}.$(echo ${INTERNAL_File_To_TEST} | awk -F\. -v VAR1=${FIELD_TO_GET} '{ print $VAR1 }' )"
done

if ! [ "${FILE_FINAL_EXT}" = "${INTERNAL_Ext_To_TEST}" ]
   then
      set_message "ErrorN" "Bad extention on file ${INTERNAL_File_To_TEST} : [ ${FILE_FINAL_EXT} ]" "${INTERNAL_CRITICITY_OF_FAIL}"
       if ! [ -z "${INTERNAL_ACTION_ON_FAIL}" ]
              then
                   ${INTERNAL_ACTION_ON_FAIL}
           fi
   else
       set_message "Debug4" " File extention for ${INTERNAL_File_To_TEST} : [ OK ]"
       if ! [ -z "${INTERNAL_ACTION_ON_SUCCESS}" ]
              then
                   ${INTERNAL_ACTION_ON_SUCCESS}
           fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_Ctrl_Exist
{
#|# Description : This function is used to chek if a file exist or not and do specifics actions in both case
#|#
#|# Var to set  :
#|# _file_to_test               : use this var to set which file to controle
#|# lib_File_Ctrl_Existe_create           : Use this var to set if you want to create the file if he wn't exist
#|# lib_File_Ctrl_Existe_critic_level     : Use this var to set the serverity exit level
#|# lib_File_Ctrl_Existe_onfail_action    : Use this var to set the action to do on failed condition
#|# lib_File_Ctrl_Existe_onsuccess_action : Use this var to set the action to do on passed condition
#|# ${1}                                  : Use this var to set [ _file_to_test ]
#|# ${2}                                  : Use this var to set [ lib_File_Ctrl_Existe_create ]
#|# ${3}                                  : Use this var to set [ lib_File_Ctrl_Existe_critic_level ]
#|# ${4}                                  : Use this var to set [ lib_File_Ctrl_Existe_onfail_action ]
#|# ${5}                                  : Use this var to set [ lib_File_Ctrl_Existe_onsuccess_action ]
#|#
#|# Base usage  : File_Ctrl_Exist "file to control" "Dont_Create_File" "criticity_of_fail"  "Action on fail"  "Action on success"
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

_file_to_test="${1}"
lib_File_Ctrl_Existe_create="${2}"
lib_File_Ctrl_Existe_critic_level="${3}"
lib_File_Ctrl_Existe_onfail_action="${4}"
lib_File_Ctrl_Existe_onsuccess_action="${5}"

set_message "Debug6" " File  _file_to_test                : [ ${_file_to_test} ] "
set_message "Debug6" " File  lib_File_Ctrl_Existe_create            : [ ${lib_File_Ctrl_Existe_create} ] "
set_message "Debug6" " File  lib_File_Ctrl_Existe_critic_level      : [ ${lib_File_Ctrl_Existe_critic_level} ] "
set_message "Debug6" " File lib_File_Ctrl_Existe_onfail_action      : [ ${lib_File_Ctrl_Existe_onfail_action} ] "
set_message "Debug6" " File  lib_File_Ctrl_Existe_onsuccess_action  : [ ${lib_File_Ctrl_Existe_onsuccess_action} ] "
set_message "StMessage" "checking file ${_file_to_test} :"
if [ "${Iterate_Function_File_Ctrl_Exist}" = "1" ]
   then
        if [ -e "${_file_to_test}" ]
           then
                set_message "EdSMessage" "CREATED"
                #set_message "Debug6" " File ${_file_to_test} : [ CREATED ] "
                if ! [ -z "${lib_File_Ctrl_Existe_onsuccess_action}" ]
                       then
                           ${lib_File_Ctrl_Existe_onsuccess_action}
                fi
           else
                set_message "EdSMessage" "CAN T CREATE"
                set_message "ErrorN" " File ${_file_to_test} : [ CAN T CREATE ]" "${lib_File_Ctrl_Existe_critic_level}"
                if ! [  -z "${lib_File_Ctrl_Existe_onfail_action}" ]
                       then
                            ${lib_File_Ctrl_Existe_onfail_action}
                fi
        fi
   else
        if [ -e "${_file_to_test}" ]
           then
                set_message "EdSMessage" "FOUND"
                #set_message "Debug6" " File ${_file_to_test} : [ PRESENT ] "
                if ! [ -z "${lib_File_Ctrl_Existe_onsuccess_action}" ]
                        then
                             ${lib_File_Ctrl_Existe_onsuccess_action}
                fi
           else
               case ${lib_File_Ctrl_Existe_create} in
                    Create_file) touch ${_file_to_test}
                                 Iterate_Function_File_Ctrl_Exist="1"
                                 File_Ctrl_Exist
                                 ;;
                Dont_Create_File)# set_message "EdEMessage" "Not FOUND"
                        set_message "ErrorN" "File ${_file_to_test} : [ NOT FOUND ]" "${lib_File_Ctrl_Existe_critic_level}" "2"
                                 ;;
                              *) set_message "ErrorN" "Not supported case" "2"
                                 ;;
               esac
               set_message "EdEMessage" "NOT FOUND"
               set_message "ErrorN" "File ${_file_to_test} : [ Not PRESENT ]" "${lib_File_Ctrl_Existe_critic_level}" "2"
                    if ! [ -z "${lib_File_Ctrl_Existe_onfail_action}" ]
                       then
                            ${lib_File_Ctrl_Existe_onfail_action}
                    fi
         fi
fi
Iterate_Function_File_Ctrl_Exist="0"
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_get_filename
{
#|# Description : This function provide capacity to find filename at the end of the path.
#|#
#|# Var to set    : 
#|# _filename_path                        : use this var to set Path and file to refine
#|#
#|# ${1}                                    : use this var to set _filename_path
#|#
#|# Base usage  : File_get_filename "My_PATH/my_file vars"
#|#
#|# Send Back   : Filename as string
#|# 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

_filename_path="${1}"


if [ -z "${_filename_path}" ]
   then
       set_message "ErrorN" "EMPTT var for \$\1 in File_get_filename CALL  : [ KO ] " "1"
   else
       FILE_NAME_var="$( echo ${_filename_path} | awk -F\/ '{ print $NF }')"
       if [ "${FILE_NAME_var}" = "/" ]
          then
              set_message "ErrorN" "Error no Filename i \$\1 File_get_filename Call  : [ KO ] " "1"
          else
              set_message "Debug6" "Return of File_get_filename is  : [ ${FILE_NAME_var} ] "
              Return_var_File_get_filename="${FILE_NAME_var}"
       fi
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_Backup
{
#|# Description : This function is used to genrerate a dated backup of a file directly into backup directory.
#|#
#|# Var to set    : 
#|# _file_to_bck                        : use this var to set which file to backup
#|#
#|# ${1}                                    : use this var to set _file_to_bck
#|#
#|# Base usage  : do_file_move_or_copy "file to MVCP" "destination full path " "action type" "destination is a dir 0/1"
#|#
#|# Send Back   : File_Backup "file_to_backup"
#|# 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "
USE_DATE="$(date +%Y_%m_%d-%HH_%MM)"
_file_to_bck="${1}"
File_get_filename "${_file_to_bck}"
_file_bkc_sub_dir=$( dirname ${_file_to_bck} )
set_new_directory "${Base_Dir_Scripts_BCK}${_file_bkc_sub_dir}"
_file_bkc_file="${Base_Dir_Scripts_BCK}${_file_bkc_sub_dir}/${Return_var_File_get_filename}_${USE_DATE}"

do_file_move_or_copy "${_file_to_bck}" "${_file_bkc_file}" "copy" "0"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function do_file_move_or_copy
{
#|# Description : This function is to manage file copy or move with error control.
#|#
#|# Var to set    : 
#|# _file_to_move_or_copy                       : use this var to set which file to copy or move
#|# _destination_path                                : Use this var to set the destination of the files / dirs
#|# _action_type_cpmv                                : use this var to set if you copy or move the file / dirs
#|# _is_to_dir                                       : Use this var if the destination is a directory
#|#
#|# ${1}                                    : use this var to set _file_to_move_or_copy
#|# ${2}                                    : Use this var to set Base_File_Dest
#|# ${3}                                    : use this var to set _action_type_cpmv ( copy = cp | move  = mv )
#|# ${4}                                    : Use this var to set _is_to_dir
#|#
#|# Base usage  : do_file_move_or_copy "file to MVCP" "destination full path " "action type" "destination is a dir 0/1"
#|#
#|# Send Back   : File compy action or move 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

_file_to_move_or_copy="${1}"
_destination_path="${2}"
_action_type_cpmv="${3}"
_is_to_dir="${4}"

set_message "Debug6" "Value for _file_to_move_or_copy : [ ${_file_to_move_or_copy} ]"
set_message "Debug6" "Value for _destination_path          : [ ${_destination_path} ]"
set_message "Debug6" "Value for _action_type_cpmv          : [ ${_action_type_cpmv} ]"
set_message "Debug6" "Value for _is_to_dir                 : [ ${_is_to_dir} ]"

if [ "${_is_to_dir}" = "1" ]
   then
       set_new_directory="${Base_File_Dest}"
       Internal_CPMV_dest="${_destination_path}/"
   else
       Internal_CPMV_dest="${_destination_path}"
       #File_Ctrl_Exist "${Internal_CPMV_dest}" "Dont_Create_File" "0"
fi

File_get_filename "${_file_to_move_or_copy}"

set_message "Debug6"  "Internal_CPMV_dest is set to : [ ${Internal_CPMV_dest} ]"
case ${_action_type_cpmv} in
     copy|COPY) _action_cpmv="cp"
                set_message "Debug6" " Choosen action : [ ${_action_type_cpmv} ]"
                if [ -d ${_file_to_move_or_copy} ]
                   then
                      _action_params=" -Rp"
                   else
                      _action_params=""
                fi
                ;;

     move|MOVE) _action_cpmv="mv"
                set_message "Debug6" " Choosen action : [ ${_action_type_cpmv} ]"
                _action_params=""
                ;;

            * ) set_message "ErrorN" " Not supported OPTION : [ ${_action_type_cpmv} ]" "2"
                ;;
esac


File_Ctrl_Exist "${_file_to_move_or_copy}" "Dont_Create_File" "2"
set_message "Debug9" "CMD : [ ${_action_cpmv} ${_action_params} ${_file_to_move_or_copy}  ${Internal_CPMV_dest} ]"
set_message "Debug9" "Bakuping file ${_file_to_move_or_copy} to ${Internal_CPMV_dest} ]"
${_action_cpmv} ${_action_params} ${_file_to_move_or_copy}  ${Internal_CPMV_dest}
File_Ctrl_Exist "${Internal_CPMV_dest}" "Dont_Create_File" "2"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}



Sourced_OK="1"