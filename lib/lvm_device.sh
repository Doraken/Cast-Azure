###############################################################################
# lvm_device.lib                                          Version : 1.1.0     #
#                                                                             #
# Creation Date : 18/02/2006                                                  #
# Team          : Only me after all                                           #
# Support mail  : arnaud@crampet.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base loop device manipulation runtimes       #
#                                                                             #
###############################################################################
####
# INFO 

function LVM_Device_Create
{
#|# Var to set  : 
#|# _lv_name : Use this var to set name of the created lv ( Mandatory )
#|# _size_lv : Use this var to set size of the created lv ( Mandatory )
#|# _vg_name : Use this var to set name of the used vg    ( Mandatory )
#|# ${1}          : Use this var to set [ _lv_name ]                   
#|# ${2}          : Use this var to set [ _size_lv ]
#|# ${3}          : Use this var to set [ _vg_name ]                 
#|#
#|# Base usage  : LVM_Device_Create "_lv_name" "_size_lv" "_vg_name" 
#|#
#|# Description : This function is used to creat lvm logical volume
#|#
#|# Send Back   : lvm logical volume
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

_lv_name="${1}"                    
_size_lv="${2}" 
_vg_name="${3}"  

do_empty_var_control "${_lv_name}" "_lv_name" "ErrorN" "2" " logical volume name is a mandatory parameter "
do_empty_var_control "${_size_lv}" "_size_lv" "ErrorN" "2" " logical volume size is a mandatory parameter "
do_empty_var_control "${_vg_name}" "_vg_name" "ErrorN" "2" " volume group name is a mandatory parameter "

lvcreate -L ${_size_lv} -n ${_lv_name} ${_vg_name} 
do_error_control "${?}" "Creation of logical volume ${_lv_name} on vg ${_vg_name}" " [ can't create ] " "2" "" ""
LVM_Device_exist "${_lv_name}" "${_vg_name}"  "2" "" ""
################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function LVM_Device_delete
{
#|# Var to set  : 
#|# _lv_name : Use this var to set ( Mandatory )
#|# _vg_name : Use this var to set ( Mandatory )
#|# ${1}          : Use this var to set [ _lv_name ]                   
#|# ${2}          : Use this var to set [ _vg_name ]                 
#|#
#|# Base usage  : LVM_Device_delete "_lv_name" "_vg_name" 
#|#
#|# Description : This function is used to delete lvm logical volume
#|#
#|# Send Back   : lvm logical volume deletion
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

_lv_name="${1}"                    
_vg_name="${2}" 

do_empty_var_control "${_lv_name}" "_lv_name" "ErrorN" "2" " logical volume name is a mandatory parameter "
do_empty_var_control "${_vg_name}" "_vg_name" "ErrorN" "2" " volume group name is a mandatory parameter "

lvremove  /dev/${_vg_name}/${_lv_name}

do_error_control "${?}" "Deletion of logical volume ${_lv_name} on vg ${_vg_name}" " [ can't create ] " "2" "" ""
################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function LVM_Device_exist
{
#|# Var to set  : 
#|# _lv_name        : Use this var to set Logical volume name to check ( Mandatory )
#|# _vg_name        : Use this var to set Volume group name of the lv  ( Mandatory )
#|# _err_level      : Use this var to set error level of the check     ( Mandatory )
#|# _on_fail_action : Use this var to set on chek fail action          ( Optional )
#|# _on_success_action   : Use this var to set on check ok action           ( Optional )
#|# ${1}          : Use this var to set [ _lv_name ]                   
#|# ${2}          : Use this var to set [ _vg_name ]
#|# ${3}          : Use this var to set [ _err_level ]                   
#|# ${4}          : Use this var to set [ _on_fail_action ]
#|# ${5}          : Use this var to set [ _on_success_action ]              
#|#
#|# Base usage  : LVM_Device_delete "_lv_name" "_vg_name"  "_err_level" "_on_fail_action" "_on_success_action"
#|#
#|# Description : This function is used to check existance of a lvm logical volume
#|#
#|# Send Back   : lvm logical volume Information and action 
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

_lv_name="${1}"                 
_vg_name="${2}"
_err_level="${3}"                
_on_fail_action="${4}"
_on_success_action="${5}"   

do_empty_var_control "${_lv_name}"   "_lv_name"   "ErrorN" "2" " logical volume name is a mandatory parameter "
do_empty_var_control "${_vg_name}"   "_vg_name"   "ErrorN" "2" " volume group name is a mandatory parameter "
do_empty_var_control "${_err_level}" "_err_level" "ErrorN" "2" " error level is a mandatory parameter "

lvdisplay  /dev/${_vg_name}/${_lv_name} > /dev/null
do_error_control "${?}" "Status of logical volume ${_lv_name} on vg ${_vg_name}" " [ Not present ] " "${_err_level}" "${_on_fail_action}" "${_on_success_action}"

################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function LVM_Device_vg_status
{
#|# _vg_name          : Use this var to set the name of the checked VG
#|# LVM_device_vg_Status_action : Use this var to set the action chek to do 
#|# ${1}                        : To set _vg_name
#|# ${2}                        : To set LVM_device_vg_Status_action
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

_vg_name="${1}"

case ${LVM_device_vg_Status_action} in 
                 free_space) vgdisplay ${_vg_name} | grep "VG Name" 
						     vgdisplay ${_vg_name} | grep "Free  PE"  | awk '{ echo $1 " " $4 " " $7 " " $8 }'
						     ;;
                 list) vgdisplay  | grep "VG Name" 
                 ;;
                 *)
esac

################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
###################################################### 	
}

function LVM_Get_lvs
{
#|# This function is used to get full list of all LV device on the computer.
#|# _lvm_device_name          : This var is user to store the name of var used to send back data.
#|# 
#|# ${1}                        : To set _vg_name
#|# ${2}                        : To set LVM_device_vg_Status_action
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "

_lvm_device_name="${1}"

set_message "Debug5" "Send back var is : [ ${_lvm_device_name} ]"
	
################# Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
######################################################
}


function Loop_linker_format
{
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug10" "Current Stack : [ ${Function_PATH} ] "


set_message "Info" "Creating links between loop and files  : [ Started ] "

last_att_loop=$(cat ${Base_Chroot_catalog_file} | grep last_loop | awk '{ echo $2 }')
New_att_loop=$(expr ${last_att_loop} + 1) 
echo "${Chroot_Name}| created on $(date) | | |D|" >> ${Base_Chroot_catalog_file}
echo " echo \" regenerating configuration loop device for ${Chroot_Name}\"" >> ${Base_Dir_Scripts_Tmp_Auto_Lib}/Loop_configuration.ksh
for _loops_to_map in ${_loops_file_liste}
do 
   echo "losetup /dev/loop${New_att_loop} ${_loops_to_map}"
   losetup /dev/loop${New_att_loop} ${_loops_to_map}
   echo "${Chroot_Name}| loop Device loop${New_att_loop} | file   |  ${_loops_to_map}|T|" >> ${Base_Chroot_catalog_file}
   echo "losetup /dev/loop${New_att_loop} ${_loops_to_map}" >> ${Base_Scriptname_auto_loop_conf}
   echo "losetup -d /dev/loop${New_att_loop} "   >> ${Base_Scriptname_auto_loop_deconf}
   mkfs.ext2 /dev/loop${New_att_loop} 
   New_att_loop=$(expr ${New_att_loop} + 1) 
done
echo "" >>  ${Base_Chroot_catalog_file}  
cat ${Base_Chroot_catalog_file} | egrep -v last_loop > ${Base_Chroot_catalog_tmp_file}
cat ${Base_Chroot_catalog_tmp_file} > ${Base_Chroot_catalog_file}
echo "last_loop ${New_att_loop}" >> ${Base_Chroot_catalog_file}
set_message "Info" "Creating links between loop and files  : [ Started ] "


############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}


Sourced_OK="1"
