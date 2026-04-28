###############################################################################
# directory.lib                                         Version : 1.0         #
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



function do_check_dir_null_or_slash()
{
#|# Description : This function is used with do_error_control as success or error result
#|#
#|# Var to set  : 
#|#                 Path_To_test : Use this var to set the path to test 
#|#                 ${1}         : use this var to set Path_To_test             
#|#
#|# Base usage  : Do_check_dir_null_or_slash  "My_directory_path"
#|#
#|# Send Back   : error check 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

Path_To_test=${1}

if [ -z "${Path_To_test}" ] 
   then 
          set_message "ErrorN" " Error ON PATH  : [ Value is NULL ]" "1"
   else 
       if [ "${Path_To_test}" = "/" ]
          then 
                  set_message "ErrorN" " Error ON PATH  : [ Value is / ]" "1"
      fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function set_new_directory()
{
#|# Description : This function is used create a directory if is not present
#|#
#|# Var to set  : 
#|#                 Base_param_Dir_To_Create    : use this var to set which irectory to control and create
#|#                 ${1}                        : use this var to set Base_param_Dir_To_Create        
#|#
#|# Base usage  : set_new_directory "My_Directory"
#|#
#|# Send Back   : new directory 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "

Base_param_Dir_To_Create="${1}"

Do_check_dir_null_or_slash ${Base_param_Dir_To_Create}
#set_message "StMessage" "Checking  directory : [ ${Base_param_Dir_To_Create} ] "
if [ -d "${Base_param_Dir_To_Create}" ]
   then 
	T=1
  #     set_message "EdSMessage" "Present"
    else 
        mkdir -p ${Base_param_Dir_To_Create}
        Return_code=$?
        if [ "${Return_code}" = "0" ]
           then
				t=1
   #            set_message "EdSMessage" "CREATED"
           else
    #           set_message "EdEMessage" "Can't be created"
               set_message "ErrorN" " can't create directory : [ ${Base_param_Dir_To_Create} ]" "1"
         fi
fi
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

function Directory_Exist()
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
set_message "Debug4" "Current Stack : [ ${Function_PATH} ] "
Base_Param_Dir_To_TEST="${1}"
set_message "StMessage" "Checking  directory : [ ${Base_param_Dir_To_Create} ] "
if [ -d "${Base_Param_Dir_To_TEST}" ]
   then 
       set_message "EdSMessage" "FOUND" 
   else 
       set_message "EdSMessage" "Not FOUND" 
       set_message "ErrorN" " Directory : [ Not PRESENT ]" "1"
fi 
############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
####################################################
}

Sourced_OK="1"