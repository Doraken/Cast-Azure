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
. ./conf/config.cnf 


function Dir_null_or_slash ()
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : 
#|#                 Path_To_test : Use this var to set the path to test 
#|#                 ${1}         : use this var to set Path_To_test             
#|#
#|# Base usage  : Dir_null_or_slash  "My_directory_path"
#|#
#|# Send Back   : error check 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

Path_To_test=${1}

if [ -z "${Path_To_test}" ] 
   then 
          MSG_DISPLAY "ErrorN" " Error ON PATH  : [ Value is NULL ]" "1"
   else 
       if [ "${Path_To_test}" = "/" ]
          then 
                  MSG_DISPLAY "ErrorN" " Error ON PATH  : [ Value is / ]" "1"
      fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Directory_CRT ()
{
#|# Description : This function is used create a directory if is not present
#|#
#|# Var to set  : 
#|#                 Base_param_Dir_To_Create    : use this var to set which irectory to control and create
#|#                 ${1}                        : use this var to set Base_param_Dir_To_Create        
#|#
#|# Base usage  : Directory_CRT "My_Directory"
#|#
#|# Send Back   : new directory 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

Base_param_Dir_To_Create="${1}"

Dir_null_or_slash ${Base_param_Dir_To_Create}
MSG_DISPLAY "StMessage" "Checking  directory : [ ${Base_param_Dir_To_Create} ] "
if [ -d "${Base_param_Dir_To_Create}" ]
   then 
       MSG_DISPLAY "EdSMessage" "Present"
    else 
        mkdir -p ${Base_param_Dir_To_Create}
        Return_code=$?
        if [ "${Return_code}" = "0" ]
           then
               MSG_DISPLAY "EdSMessage" "CREATED"
           else
               MSG_DISPLAY "EdEMessage" "Can't be created"
               MSG_DISPLAY "ErrorN" " can't create directory : [ ${Base_param_Dir_To_Create} ]" "1"
         fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Directory_Exist ()
{
#|# Description : This function is used to validate that a directory exist or not.
#|#
#|# Var to set  : 
#|#                 Base_Param_Dir_To_TEST : Use this var to set which directory to test 
#|#                 ${1}                   : User this var to set Base_Param_Dir_To_TEST    
#|#
#|# Base usage  : Directory_Exist "My_directory_full_path"
#|#
#|# Send Back   : directory existance
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "
Base_Param_Dir_To_TEST="${1}"
MSG_DISPLAY "StMessage" "Checking  directory : [ ${Base_param_Dir_To_Create} ] "
if [ -d "${Base_Param_Dir_To_TEST}" ]
   then 
       MSG_DISPLAY "EdSMessage" "FOUND" 
   else 
       MSG_DISPLAY "EdSMessage" "Not FOUND" 
       MSG_DISPLAY "ErrorN" " Directory : [ Not PRESENT ]" "1"
fi 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function CTRL_Result_func ()
{
#|# Description : This function is used to check result of a past action and choose action
#|#
#|# Var to set  :
#|#                 CRF_Result_Action             : Use this var to set The las action returne code         ( Mandatory )
#|#                 CRF_Generic_Base_MSG          : use this var to set base message of control             ( Mandatory )
#|#                 CRF_Generic_Base_MSG_ERR      : Use this var to set additional iformation on error      ( Mandatory )
#|#                 CRF_Result_ERR_Level          : Use this var to set the level of test severity on fail  ( Mandatory )
#|#                 CRF_Action_ONFAIL             : Use this var to set and action to do after CTRL fail    (  OPTIONAL )
#|#                 CRF_Action_ONOK               : Use this var to set and action to do after CTRL is OK   (  OPTIONAL )
#|#                 ${1}                          : Use this var to set [ CRF_Result_Action ]
#|#                 ${2}                          : Use this var to set [ CRF_Generic_Base_MSG ]
#|#                 ${3}                          : Use this var to set [ CRF_Generic_Base_MSG_ERR ]
#|#                 ${4}                          : Use this var to set [ CRF_Result_ERR_Level ]
#|#                 ${5}                          : Use this var to set [ CRF_Action_ONFAIL ]
#|#                 ${6}                          : Use this var to set [ CRF_Action_ONOK ]
#|#
#|# Base usage  : CTRL_Result_func "${?}" "Generic_Base_Param_MSG" "Generic_Base_Param_MSG_ERR" "Result_ERR_Level" "On fail action" "on success action"
#|#
#|# Send Back   : Message / Exit / function
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

CRF_Result_Action=${1}
CRF_Generic_Base_MSG=${2}
CRF_Generic_Base_MSG_ERR=${3}
CRF_Result_ERR_Level=${4}
CRF_Action_ONFAIL=${5}
CRF_Action_ONOK=${6}


if [ "${CRF_Result_Action}" = "0" ]
   then
        MSG_DISPLAY "Info" "${CRF_Generic_Base_MSG}  [ OK  ] "
        if ! [ -z "${CRF_Action_ONOK}" ]
              then
                  _Ido="${CRF_Action_ONOK}"
                  CRF_Action_ONOK=""
                  ${_Ido}
        fi
   else
        MSG_DISPLAY "ErrorN" "${CRF_Generic_Base_MSG} ${CRF_Generic_Base_MSG_ERR} [ ERROR  ] " "${CRF_Result_ERR_Level}"
        if ! [ -z "${CRF_Action_ONFAIL}" ]
              then
                     _Ido="${CRF_Action_ONFAIL}"
                     CRF_Action_ONFAIL=""    
                   ${_Ido}
        fi
fi
Generic_Base_Param_MSG_ERR=""
CRF_Generic_Base_MSG=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Empty_Var_Control ()
{
#|# Description : This function is used to check if a var is empty
#|#
#|# Var to set  :
#|#                 EVC_Var_To_Test       : Use this var to set the path to test                                 ( Mandatory )
#|#                 EVC_Var_Name_To_Test  : Use this var to set the name of the var to test for display messages ( Mandatory )
#|#                 EVC_Type_Of_ERR       : Use this var to set the severity of an empty vars                    ( Mandatory )
#|#                 EVC_Level_Of_ERR      : Use this var to set the severity level of an empty vars              ( Mandatory )
#|#                 EVC_MSG_add           : Use this var to set complementary message                            ( OPTIONAL )
#|#                 EVC_Action_ONFAIL     : Use this var to set anb action to do after CTRL fail                 ( OPTIONAL )
#|#                 EVC_Action_ONOK       : Use this var to set anb action to do after CTRL is OK                ( OPTIONAL )
#|#                 ${1}                  : Used to set [ Base_Var_to_test ]
#|#                 ${2}                  : Used to set [ Base_Var_Name_To_Test ]
#|#                 ${3}                  : Used to set [ Type_Of_ERR ]
#|#                 ${4}                  : Used to set [ Level_Of_ERR ]
#|#                 ${5}                  : Used to set [ EVC_MSG_add ]
#|#                 ${6}                  : Used to set [ Action_ONFAIL ]
#|#                 ${7}                  : Used to set [ Action_ONOK ]
#|#
#|# Base usage  : Empty_Var_Control "My_VAR" "My_Var_Name" "ERR_type" "Level_Of_ERR" [ "MSG_add" "Action_ONFAIL" "Action_ONOK" ]
#|#
#|# Send Back   : Send back result of check
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

EVC_Var_To_Test="${1}"
EVC_Var_Name_To_Test="${2}"
EVC_Type_Of_ERR="${3}"
EVC_Level_Of_ERR="${4}"
EVC_MSG_add="${5}"
EVC_Action_ONFAIL="${6}"
EVC_Action_ONOK="${7}"

if [ -z "${EVC_Var_To_Test}" ]
   then
           MSG_DISPLAY "${EVC_Type_Of_ERR}" " Error ON VAR ${EVC_Var_Name_To_Test}  : [ Not Set ] ${MSG_Complement}" "${EVC_Level_Of_ERR}"
           if ! [ -z "${EVC_Action_ONFAIL}" ]
              then
                   ${EVC_Action_ONFAIL}
           fi

   else
       MSG_DISPLAY "Debug6" " Value of ${EVC_Var_Name_To_Test}  : [ Value is ${EVC_Var_To_Test} ]"
       if ! [ -z "${EVC_Action_ONOK}" ]
          then
              ${EVC_Action_ONOK}
       fi
fi

Action_ONFAIL=""
Action_ONOK=""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################

}

function File_Ctrl_Ext ()
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
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

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
      MSG_DISPLAY "ErrorN" "Bad extention on file ${INTERNAL_File_To_TEST} : [ ${FILE_FINAL_EXT} ]" "${INTERNAL_CRITICITY_OF_FAIL}"
       if ! [ -z "${INTERNAL_ACTION_ON_FAIL}" ]
              then
                   ${INTERNAL_ACTION_ON_FAIL}
           fi
   else
       MSG_DISPLAY "Debug4" " File extention for ${INTERNAL_File_To_TEST} : [ OK ]"
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
#|# Base_Param_File_To_TEST               : use this var to set which file to controle
#|# lib_File_Ctrl_Existe_create           : Use this var to set if you want to create the file if he wn't exist
#|# lib_File_Ctrl_Existe_critic_level     : Use this var to set the serverity exit level
#|# lib_File_Ctrl_Existe_onfail_action    : Use this var to set the action to do on failed condition
#|# lib_File_Ctrl_Existe_onsuccess_action : Use this var to set the action to do on passed condition
#|# ${1}                                  : Use this var to set [ Base_Param_File_To_TEST ]
#|# ${2}                                  : Use this var to set [ lib_File_Ctrl_Existe_create ]
#|# ${3}                                  : Use this var to set [ lib_File_Ctrl_Existe_critic_level ]
#|# ${4}                                  : Use this var to set [ lib_File_Ctrl_Existe_onfail_action ]
#|# ${5}                                  : Use this var to set [ lib_File_Ctrl_Existe_onsuccess_action ]
#|#
#|# Base usage  : File_Ctrl_Exist "file to control" "Dont_Create_File" "criticity_of_fail"  "Action on fail"  "Action on success"
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

Base_Param_File_To_TEST="${1}"
lib_File_Ctrl_Existe_create="${2}"
lib_File_Ctrl_Existe_critic_level="${3}"
lib_File_Ctrl_Existe_onfail_action="${4}"
lib_File_Ctrl_Existe_onsuccess_action="${5}"

MSG_DISPLAY "Debug6" " File  Base_Param_File_To_TEST                : [ ${Base_Param_File_To_TEST} ] "
MSG_DISPLAY "Debug6" " File  lib_File_Ctrl_Existe_create            : [ ${lib_File_Ctrl_Existe_create} ] "
MSG_DISPLAY "Debug6" " File  lib_File_Ctrl_Existe_critic_level      : [ ${lib_File_Ctrl_Existe_critic_level} ] "
MSG_DISPLAY "Debug6" " File lib_File_Ctrl_Existe_onfail_action      : [ ${lib_File_Ctrl_Existe_onfail_action} ] "
MSG_DISPLAY "Debug6" " File  lib_File_Ctrl_Existe_onsuccess_action  : [ ${lib_File_Ctrl_Existe_onsuccess_action} ] "
MSG_DISPLAY "StMessage" "checking file ${Base_Param_File_To_TEST} :"
if [ "${Iterate_Function_File_Ctrl_Exist}" = "1" ]
   then
        if [ -e "${Base_Param_File_To_TEST}" ]
           then
                MSG_DISPLAY "EdSMessage" "CREATED"
                #MSG_DISPLAY "Debug6" " File ${Base_Param_File_To_TEST} : [ CREATED ] "
                if ! [ -z "${lib_File_Ctrl_Existe_onsuccess_action}" ]
                       then
                           ${lib_File_Ctrl_Existe_onsuccess_action}
                fi
           else
                MSG_DISPLAY "EdSMessage" "CAN T CREATE"
                MSG_DISPLAY "ErrorN" " File ${Base_Param_File_To_TEST} : [ CAN T CREATE ]" "${lib_File_Ctrl_Existe_critic_level}"
                if ! [  -z "${lib_File_Ctrl_Existe_onfail_action}" ]
                       then
                            ${lib_File_Ctrl_Existe_onfail_action}
                fi
        fi
   else
        if [ -e "${Base_Param_File_To_TEST}" ]
           then
                MSG_DISPLAY "EdSMessage" "FOUND"
                #MSG_DISPLAY "Debug6" " File ${Base_Param_File_To_TEST} : [ PRESENT ] "
                if ! [ -z "${lib_File_Ctrl_Existe_onsuccess_action}" ]
                        then
                             ${lib_File_Ctrl_Existe_onsuccess_action}
                fi
           else
               case ${lib_File_Ctrl_Existe_create} in
                    Create_file) touch ${Base_Param_File_To_TEST}
                                 Iterate_Function_File_Ctrl_Exist="1"
                                 File_Ctrl_Exist
                                 ;;
                Dont_Create_File)# MSG_DISPLAY "EdEMessage" "Not FOUND"
                        MSG_DISPLAY "ErrorN" "File ${Base_Param_File_To_TEST} : [ NOT FOUND ]" "${lib_File_Ctrl_Existe_critic_level}" "2"
                                 ;;
                              *) MSG_DISPLAY "ErrorN" "Not supported case" "2"
                                 ;;
               esac
               MSG_DISPLAY "EdEMessage" "NOT FOUND"
               MSG_DISPLAY "ErrorN" "File ${Base_Param_File_To_TEST} : [ Not PRESENT ]" "${lib_File_Ctrl_Existe_critic_level}" "2"
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

function File_Get_FileName
{
#|# Description : This function provide capacity to find filename at the end of the path.
#|#
#|# Var to set    : 
#|# STRING_PATH_FILEMANE                        : use this var to set Path and file to refine
#|#
#|# ${1}                                    : use this var to set STRING_PATH_FILEMANE
#|#
#|# Base usage  : File_Get_FileName "My_PATH/my_file vars"
#|#
#|# Send Back   : Filename as string
#|# 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

STRING_PATH_FILEMANE="${1}"


if [ -z "${STRING_PATH_FILEMANE}" ]
   then
       MSG_DISPLAY "ErrorN" "EMPTT var for \$\1 in File_Get_FileName CALL  : [ KO ] " "1"
   else
       FILE_NAME_var="$( echo ${STRING_PATH_FILEMANE} | awk -F\/ '{ print $NF }')"
       if [ "${FILE_NAME_var}" = "/" ]
          then
              MSG_DISPLAY "ErrorN" "Error no Filename i \$\1 File_Get_FileName Call  : [ KO ] " "1"
          else
              MSG_DISPLAY "Debug6" "Return of File_Get_FileName is  : [ ${FILE_NAME_var} ] "
              Return_var_File_Get_FileName="${FILE_NAME_var}"
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
#|# Base_File_To_bck                        : use this var to set which file to backup
#|#
#|# ${1}                                    : use this var to set Base_File_To_bck
#|#
#|# Base usage  : File_move_or_copy "file to MVCP" "destination full path " "action type" "destination is a dir 0/1"
#|#
#|# Send Back   : File_Backup "file_to_backup"
#|# 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "
USE_DATE="$(date +%Y_%m_%d-%HH_%MM)"
Base_File_To_bck="${1}"
File_Get_FileName "${Base_File_To_bck}"
File_BkcSubDir=$( dirname ${Base_File_To_bck} )
Directory_CRT "${Base_Dir_Scripts_BCK}${File_BkcSubDir}"
Internal_BCK_file="${Base_Dir_Scripts_BCK}${File_BkcSubDir}/${Return_var_File_Get_FileName}_${USE_DATE}"

File_move_or_copy "${Base_File_To_bck}" "${Internal_BCK_file}" "copy" "0"


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function File_move_or_copy
{
#|# Description : This function is to manage file copy or move with error control.
#|#
#|# Var to set    : 
#|# Base_File_To_move_or_copy                       : use this var to set which file to copy or move
#|# Base_Destination                                : Use this var to set the destination of the files / dirs
#|# Action_type_cpmv                                : use this var to set if you copy or move the file / dirs
#|# Is_To_Dir                                       : Use this var if the destination is a directory
#|#
#|# ${1}                                    : use this var to set Base_File_To_move_or_copy
#|# ${2}                                    : Use this var to set Base_File_Dest
#|# ${3}                                    : use this var to set Action_type_cpmv ( copy = cp | move  = mv )
#|# ${4}                                    : Use this var to set Is_To_Dir
#|#
#|# Base usage  : File_move_or_copy "file to MVCP" "destination full path " "action type" "destination is a dir 0/1"
#|#
#|# Send Back   : File compy action or move 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

Base_File_To_move_or_copy="${1}"
Base_Destination="${2}"
Action_type_cpmv="${3}"
Is_To_Dir="${4}"

MSG_DISPLAY "Debug6" "Value for Base_File_To_move_or_copy : [ ${Base_File_To_move_or_copy} ]"
MSG_DISPLAY "Debug6" "Value for Base_Destination          : [ ${Base_Destination} ]"
MSG_DISPLAY "Debug6" "Value for Action_type_cpmv          : [ ${Action_type_cpmv} ]"
MSG_DISPLAY "Debug6" "Value for Is_To_Dir                 : [ ${Is_To_Dir} ]"

if [ "${Is_To_Dir}" = "1" ]
   then
       Directory_CRT="${Base_File_Dest}"
       Internal_CPMV_dest="${Base_Destination}/"
   else
       Internal_CPMV_dest="${Base_Destination}"
       #File_Ctrl_Exist "${Internal_CPMV_dest}" "Dont_Create_File" "0"
fi

File_Get_FileName "${Base_File_To_move_or_copy}"

MSG_DISPLAY "Debug6"  "Internal_CPMV_dest is set to : [ ${Internal_CPMV_dest} ]"
case ${Action_type_cpmv} in
     copy|COPY) ACTION_CPVM="cp"
                MSG_DISPLAY "Debug6" " Choosen action : [ ${Action_type_cpmv} ]"
                if [ -d ${Base_File_To_move_or_copy} ]
                   then
                      Base_Action_Params=" -Rp"
                   else
                      Base_Action_Params=""
                fi
                ;;

     move|MOVE) ACTION_CPVM="mv"
                MSG_DISPLAY "Debug6" " Choosen action : [ ${Action_type_cpmv} ]"
                Base_Action_Params=""
                ;;

            * ) MSG_DISPLAY "ErrorN" " Not supported OPTION : [ ${Action_type_cpmv} ]" "2"
                ;;
esac


File_Ctrl_Exist "${Base_File_To_move_or_copy}" "Dont_Create_File" "2"
MSG_DISPLAY "Debug9" "CMD : [ ${ACTION_CPVM} ${Base_Action_Params} ${Base_File_To_move_or_copy}  ${Internal_CPMV_dest} ]"
MSG_DISPLAY "Info" "Bakuping file ${Base_File_To_move_or_copy} to ${Internal_CPMV_dest} ]"
${ACTION_CPVM} ${Base_Action_Params} ${Base_File_To_move_or_copy}  ${Internal_CPMV_dest}
File_Ctrl_Exist "${Internal_CPMV_dest}" "Dont_Create_File" "2"


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
MSG_DISPLAY "Debug4" "Current Stack : [ ${Function_PATH} ] "

 
MSG_DISPLAY "Message" "Please  : press enter to continue "
read dummy

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function MSG_DISPLAY
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
#|# Base usage  : MSG_DISPLAY "MD_Type_Msg" "MD_Msg_To_Display" "Level_Code"
#|#
#|# Send Back   : Message or exit level
################################################################################
MD_Type_Msg="${1}"
MD_Msg_To_Display="${2}"
declare -i MD_Level_Code="${3}"
Set_spliter_line_MSG
Dtim=$(date +%Y\/%m\/%d\ %H\:%M)
case ${MD_Type_Msg} in
                        Info) _SMessage_VAR="${Dtim} Information : "
                             _EMessage_VAR="[ ${MD_Msg_To_Display} ]"
                             printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[96m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
                             ;;
                    Message) _SMessage_VAR="${Dtim} Message : "
                             _EMessage_VAR="[ ${MD_Msg_To_Display} ]"
                             printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[0m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
                             ;;
                  StMessage) _SMessage_VAR="${Dtim} Action : ${MD_Msg_To_Display}"
                             ;;
                             
                 EdSMessage) _EMessage_VAR="[  SUCCESS ${MD_Msg_To_Display}]"
                             printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[92m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
                             ;;
                 EdEMessage) _EMessage_VAR="[  ! ERROR ! ${MD_Msg_To_Display}]"
                             printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[91m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
                             ;;
                      Debug) Sub_MSGDebug "${MD_Type_Msg}"
                             ;;
                     Debug*) Sub_MSGDebug "${MD_Type_Msg}"
                             ;;
                    ErrorN) if [  "${MD_Level_Code}" = "0" ]
                                         then
                                                _SMessage_VAR="${Dtim} Warning ON ${Function_Name} :"
                                                _EMessage_VAR="[ ${MD_Msg_To_Display} ]"
                                                printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[93m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
                                          else
                                                Function_Name="$(echo ${Function_PATH} | awk -F'[/]' '{ print $NF }' )"
                                                _SMessage_VAR="${Dtim} ERROR ON ${Function_Name} :"
                                                _EMessage_VAR="[ CODE=${MD_Level_Code} [ ${MD_Msg_To_Display} ]"
                                                printf "\\e[0m(%d)  ${_SMessage_VAR}  %.${Base_sreen_Size_limit}s \\e[91m ${_EMessage_VAR} \\e[0m  %s\n" "$(( ++cnt ))" " ${MSG_SPLITER}"
                                                exit ${MD_Level_Code}
                                      fi

                                      ;;
                            *) printf "\\e[91m" " FATAL ERROR ON MGS FUNCTION USE "
                               printf "\\e[91m" " FUNCTION     = [ ${Function_PATH} ] "
                               printf "\\e[91m" " SUB FUNCTION = [ ${SUB_Function_Name} ]"
                               printf "\\e[91m" " Debug type   = [ ${MD_Type_Msg}  ]"
                               printf "\\e[91m" " have a nice day .... :-p "
                               printf "\\e[0m"
                               exit 2
                               ;;
esac

Emptying_MSGS_vars
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
    Base_sreen_Size_limit="$(expr ${Base_sreen_Size_limit} / 2 )"
    Base_sreen_Size_limit="$(expr ${Base_sreen_Size_limit} - 16 )"
}

function Interleave_MSG
{
#|# Description : This function is used to add visual spliter to the screen
#|#
#|# Var to set  :  None
#|#
#|# Base usage  : Interleave_MSG
#|#
#|# Send Back   : a blank line folowed vby a separator line and an  another blank line
printf "\e[0m" ""                                                                                 
printf "\e[0m" "###############################################################################"   
printf "\e[0m" ""                                                                                  
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

function yum_Install_Package
{
#|# Description : This function is used to manage installation of yum packages on system. 
#|#
#|# Var to set    :
#|#                 YumPackageToInstall  : Use this var to set wiche package to install with yum
#|#                 ${1}            : Use this var to set [ YumPackageToInstall ]
#|#
#|# Base usage  : yum_Install_Package "My_package_to_install"
#|#
#|# Send Back   : Installed package
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug6" "Current Stack : [ ${Function_PATH} ] "

YumPackageToInstall=${1}
Empty_Var_Control "${YumPackageToInstall}" "YumPackageToInstall" "ErrorN" "2" "package name is a mandatory parameter "
yum_check_Package ${YumPackageToInstall}
if [ "${YumPackageStatus}" = "NOT INSTALLED" ] 
then 
    yum install ${YumPackageToInstall} -y
    CTRL_Result_func "${?}" "status for package : [ ${YumPackageToCheck}] " "Not Installed" "4" "" ""
else
    MSG_DISPLAY "Debug" "Package ${YumPackageStatus} : [ INSTALLED ] "
fi

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function yum_UnInstall_Package
{
#|# Description         : This function is used to manage uninstallation of yum packages on system.
#|# 
#|# Var to set            : 
#|#                            YumPackageToUnInstall Use this var to set which package to uninstall
#|#                         ${1}                 : use this var to set YumPackageToUnInstall
#|#
#|# Basic use             : yum_Install_Package "My_package_to_uninstall" 
#|#
#|# Send Back       : Unsinstalled package
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug6" "Current Stack : [ ${Function_PATH} ] "

YumPackageToUnInstall=${1}
yum_check_Package ${YumPackageToUnInstall}
if [ "${YumPackageStatus}" = "INSTALLED" ] 
then 
    yum erase  ${YumPackageToUnInstall} -y
    CTRL_Result_func "${?}" "status for package : [ ${YumPackageToUnInstall}] " "Can t uninstall" "4" "" ""
else
    MSG_DISPLAY "Debug" "Package ${YumPackageStatus} : [ NOT INSTALLED ] "
fi
yum update -y 2> /dev/null 1> /dev/null 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function yum_check_Package
{
#|# Var to set  : YumPackageToCheck             
#|#
#|# Base usage  : Cyum_check_Package PackageName
#|#
#|# Description : This function Check package instalation status.
#|#
#|# Send Back   : Info and action ( execution of other fcntion to set many information about the system) 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug6" "Current Stack : [ ${Function_PATH} ] "

YumPackageToCheck=${1}


Empty_Var_Control "${YumPackageToCheck}" "YumPackageToCheck" "ErrorN" "2" "package name is a mandatory parameter "
yum list installed ${YumPackageToCheck} -q 2> /dev/null
CTRL_Result_func "${?}" "status for package : [ ${YumPackageToCheck}] " "Not Installed" "0"  "yum_check_Package_sub_u" "yum_check_Package_sub_i" 


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function yum_check_Package_sub_i
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : None             
#|#
#|# Base usage  : yum_check_Package_sub_i 
#|#
#|# Send Back   : YumPackageStatus seted at INSTALLED
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug6" "Current Stack : [ ${Function_PATH} ] "

YumPackageStatus="INSTALLED"

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function yum_check_Package_sub_u
{
#|# Description : This function is used with CTRL_Result_func as success or error result
#|#
#|# Var to set  : None             
#|#
#|# Base usage  : yum_check_Package_sub_u 
#|#
#|# Send Back   : YumPackageStatus seted at NOT INSTALLED
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
MSG_DISPLAY "Debug6" "Current Stack : [ ${Function_PATH} ] "

YumPackageStatus="NOT INSTALLED"

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

function Get_SrvIp () 
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

function install_pythonpip ()
{
#|# Description         : This function is used to build to kill IPV6
#|#
#|# Var to set            : None.
#|#
#|# Base usage          : install_pythonpip
#|#
#|# Send Back           : Message and file or exit level
################################################################################
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}" 
######################################################
cd /tmp
Internet_Http_Get "https://bootstrap.pypa.io/" "get-pip.py" "${Base_Dir_Scripts_Tmp}"
python ${Base_Dir_Scripts_Tmp}/get-pip.py                           
CTRL_Result_func "${?}" "Pyhton pip deployment" "Failled" "8" "" ""
pip install --upgrade setuptools                                       
CTRL_Result_func "${?}" "Pyhton pip setup tool upgrade" "Failled" "8" "" ""
pip install mysql-python                                               
CTRL_Result_func "${?}" "Pyhton pip setup mysql-python" "Failled" "8" "" ""
pip install argparse
CTRL_Result_func "${?}" "Pyhton pip setup argparse" "Failled" "8" "" ""
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

function pkg_inst_sys_default
{
#|# Description         : This function is used to build to kill IPV6
#|#
#|# Var to set            : None.
#|#
#|# Base usage          : install_pythonpip
#|#
#|# Send Back           : Message and file or exit level
################################################################################
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}" 
######################################################
PkgList="vim-enhanced.x86_64 mlocate.x86_64 glibc-devel openssl  gcc-c++.x86_64 python-devel.x86_64 wget.x86_64 python-setuptools.noarch setuptool.x86_64"
for Pkgs in ${PkgList}
   do yum_Install_Package "${Pkgs}"
done 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
} 

function FS-check () 
{
#|# Description         : This function is used to build to kill IPV6
#|#
#|# Var to set            : None.
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


function fs_secure_all_TPMFS ()
{


grep tmpfs /etc/fstab | grep "nodev"
grep tmpfs /etc/fstab | grep "nosuid"
grep tmpfs /etc/fstab | grep "noexec"


}



function Configure_aide_cron 
{ 
MSG_DISPLAY "Info" "Rule : 1.4.2     Implement Periodic Execution of File Integrity"
Perform the following to determine if there is a cron job scheduled to run the aide check. 

crontab -u root -l | grep aide | grep check >> /dev/null 
if [ ${?} = "0" ] 
    then 
        MSG_DISPLAY "Info" "AIDE task in crontab  :   [ OK ] "
    else 
         { crontab -u root -l; echo "0 5 * * * /usr/sbin/aide --check"; } | crontab -u root -
         if [ ${_UPD_TRY_AIDE} = "1" ] 
            then 
                MSG_DISPLAY "ErrorN" "${CRF_Generic_Base_MSG} can t update configuration  [ ERROR  ] " "8"
            else 
                _UPD_TRY_AIDE="1"
                Configure_aide_cron
        fi
fi


}


function Network config
{

echo "net.ipv4.conf.all.send_redirects = 0" 
echo "net.ipv4.conf.default.send_redirects = 0"


}


function update_grubconf_rights
{
MSG_DISPLAY "Info" "Rule : 1.6.1     Set User/Group Owner and permissions on /etc/grub2.conf"
chown root:root /etc/grub2.conf
chmod og-rwx /etc/grub2.conf

}

function set default start target () 
{
MSG_DISPLAY "Info" "Rule : 3.1.1     Remove X Windows"
systemctl set-default multi-user.target
MSG_DISPLAY "Info" "Rule : 3.2       Disable Avahi Server"
systemctl stop avahi-daemon
systemctl disable avahi-daemon 


}


fucntion Set_Boot_Loader_Password
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

echo "* hard core 0"                                    >> /etc/security/limits.conf
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
MSG_DISPLAY "Info" "Rule : 4.4           Enable Firewalld refused"
systemctl stop firewalld 
systemctl disable firewalld
iptables –F
MSG_DISPLAY "Info" "Rule : 4.5       Uncommon Network Protocols"
echo "install dccp /bin/true" >> /etc/modprobe.d/UNP.conf
echo "install sctp /bin/true" >> /etc/modprobe.d/UNP.conf
echo "install rds /bin/true"  >> /etc/modprobe.d/UNP.conf
echo "install tipc /bin/true" >> /etc/modprobe.d/UNP.conf





}


function manage_system_log () 
{
MSG_DISPLAY "Info" "Rule : 5.1.1     Install the rsyslog package"
yum_UnInstall_Package "rsyslog"
MSG_DISPLAY "Info" "Rule : 5.1.2     Activate the rsyslog service"
systemctl enable rsyslog
systemctl start rsyslog


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


function Redhat_secure_yum_key_check
{
# refer to 1.3.2    Verify that gpgcheck is Globally Activated 
CRF_Generic_Base_MSG="GPG checking for yum"
CRF_Generic_Base_MSG_ERR="configuration failled"
_GPGCHECKSTATUS="$(grep gpgcheck /etc/yum.conf)"

grep gpgcheck /etc/yum.conf > /dev/null 


if [ "${?}" = "1" ]
   then
        MSG_DISPLAY "ErrorN" "${CRF_Generic_Base_MSG} ${CRF_Generic_Base_MSG_ERR} [ ERROR  ] " "0"
        File_Backup "/etc/ssh/sshd_config"
        echo "gpgcheck=1" >> /etc/yum.conf
        Redhat_secure_yum_key_check_sub
   else
       Redhat_secure_yum_key_check_sub
fi

rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

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
logfile="/tmp/logAction.log"
MSG_DISPLAY "Message" "upgrading all base backage " 
yum upgrade -y
CTRL_Result_func "${?}" "upgradding system packages" "Failled" "8" "" ""
MSG_DISPLAY "Message" "Building base environment " 
Directory_CRT "${Base_Dir_Scripts}"
Directory_CRT "${Base_Dir_Scripts_BCK}"
Directory_CRT "${Base_Dir_Scripts_Log}"
logfile="${Base_Dir_Scripts_Log}/logAction.log"
MSG_DISPLAY "Message" "Building system configuration " 
Set_IPV6off
Set_sshdconfig
MSG_DISPLAY "Message" "Deploying system packages"
pkg_inst_sys_default


install_pythonpip
Set_sshdconfig
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

ntpserver="51.15.177.17"


main