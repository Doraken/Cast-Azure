###############################################################################
#  mail.lib                                             Version : 1.0         #
#                                                                             #
# Creation Date : 17/03/2008                                                  #
# Team          : Only me                                          #
# Support mail  : arnaud@crampet.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base functions to handle mails sending       #
#                                                                             #
###############################################################################
####
# INFO 

function get_mailler_status
{
#|# Var to set  : None
#|# _mail_reciever            : Use this var to set mail to sent a mail
#|# _mail_subject             : Use this var to set to set subject of the mail 
#|# _mail_attached_file       : Use this var to set to set wich file to send with mail 
#|# _mail_message             : Use this var to set to set Message of the mail  
#|# ${1}        : Use this var to set [ _mail_reciever ]                
#|# ${2}        : Use this var to set [ _mail_subject ]   
#|# ${3}        : Use this var to set [ _mail_attached_file ]                
#|# ${4}        : Use this var to set [ _mail_message ]                 
#|#
#|# Base usage  : Mail_Send "_mail_reciever" "_mail_subject" "_mail_attached_file" "_mail_message" 
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

if  [ "${Global_Tool_mutt_Status}" = "ENABLED" ] 
  then
  	  Global_Mail_Mode="MUTT"
  elif [ "${Global_Tool_mailx_Status}" = "ENABLED" ] 
       then
            Global_Mail_Mode="mailx"
  elif [ "${Global_Tool_mail_Status}" = "ENABLED" ] 
       then 
       	   Global_Mail_Mode="mail"
       else
           set_message "ErrorN" "No mail utility activated" "1"
fi  

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function Mail_check_att
{
#|# Var to set  : None
#|# MCA_User_Attached_File            : Use this var to set mail to sent a mail
#|# ${1}        : Use this var to set [ _mail_reciever ]                
#|#
#|# Base usage  : Mail_Send "_mail_reciever" "_mail_subject" "_mail_attached_file" "_mail_message" 
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 



############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 	
}

function Mail_Send
{
#|# Var to set  : None
#|# _mail_reciever            : Use this var to set mail to sent a mail
#|# _mail_subject             : Use this var to set to set subject of the mail 
#|# _mail_attached_file       : Use this var to set to set wich file to send with mail 
#|# _mail_message             : Use this var to set to set Message of the mail  
#|# ${1}        : Use this var to set [ _mail_reciever ]                
#|# ${2}        : Use this var to set [ _mail_subject ]   
#|# ${3}        : Use this var to set [ _mail_attached_file ]                
#|# ${4}        : Use this var to set [ _mail_message ]                 
#|#
#|# Base usage  : Mail_Send "_mail_reciever" "_mail_subject" "_mail_attached_file" "_mail_message" 
#|#
#|# Description : None
#|#
#|# Send Back   : None
############ STACK_TRACE_BUILDER #####################
Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
######################################################
set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

_mail_reciever="${1}"
_mail_subject="${2}"
_mail_attached_file="${3}"
_mail_message="${4}"

get_mailler_status

do_empty_var_control "${_mail_reciever}"      "_mail_reciever"      "ErrorN" "1"  "can t send message to nobody" 
do_empty_var_control "${_mail_subject}"       "_mail_subject"       "ErrorN" "0"  "Use defaul subject [ from script ${Action_Type} ]" "_mail_subject=\"from script ${Action_Type}\"" 
_on_success_action="Global_Mail_Mode=$( print -- "${Global_Mail_Mode}_ATT" )" 
_on_faille_action=""
do_empty_var_control "${_mail_attached_file}" "_mail_attached_file" "ErrorN" "0"  "No file to send" "${_on_faille_action}" "${_on_success_action}" 
do_empty_var_control "${_mail_message}"       "_mail_message"       "ErrorN" "1"  "" 



case ${Global_Mail_Mode} in 
        MAIL_ATT) if [ "${Global_Tool_uuencode_Status}" = "ENABLED" ] 
                   then 
                   	   MF_Simple_Filename="$( echo ${_mail_attached_file} | awk -F "/" '{ print $NF }')"
                       _mail_command_line="${Global_Tool_uuencode_bin}  ${_mail_attached_file} ${MF_Simple_Filename} | cat ${_mail_message} - |   ${Global_Tool_mail_bin} -s ${_mail_subject} ${_mail_reciever}"
                   else 
                       _mail_command_line="cat ${_mail_message} | ${Global_Tool_mail_bin} -s ${_mail_subject} ${_mail_reciever}"
                  fi
                  ;; 
       MAILX_ATT) if [ "${Global_Uuencode_Mode}" = "ENABLED" ] 
                    then 
                   	   MF_Simple_Filename="$( echo ${_mail_attached_file} | awk -F "/" '{ print $NF }')"
                       _mail_command_line="${Global_Tool_uuencode_bin}  ${_mail_attached_file} ${MF_Simple_Filename} | cat ${_mail_message} - |   ${Global_Tool_mailx_bin} -s ${_mail_subject} ${_mail_reciever}"
                   else 
                       _mail_command_line="cat ${_mail_message} |  ${Global_Tool_mailx_bin} -s ${_mail_subject} ${_mail_reciever}"
                  fi
                  ;;
        MUTT_ATT) if [ "${Global_Uuencode_Mode}" = "ENABLED" ] 
                     then 
                         _mail_command_line="${Global_Tool_mutt_bin} -s \" ${_mail_subject}\" -a ${_mail_attached_file} ${_mail_reciever}  < ${_mail_message}"
                     else 
                         _mail_command_line="${Global_Tool_mutt_bin} -s \" ${_mail_subject}\" ${_mail_reciever}  < ${_mail_message}"
                   fi
                   ;;
             MAIL) _mail_command_line=" cat ${_mail_message} |   ${Global_Tool_mail_bin} -s ${_mail_subject} ${_mail_reciever}"
                   ;; 
            MAILX) _mail_command_line=" cat ${_mail_message} |   ${Global_Tool_mailx_bin} -s ${_mail_subject} ${_mail_reciever}"
                   ;;
             MUTT) _mail_command_line="${Global_Tool_mutt_bin} -s \" ${_mail_subject}\" ${_mail_reciever}  < ${_mail_message}"
                   ;;
                *) set_message "ErrorN" "Not supported case ${Global_Mail_Mode}" "2"
                   ;;
esac 

${_mail_command_line}

############### Stack_TRACE_BUILDER ################
Function_PATH="$( dirname ${Function_PATH} )"
#################################################### 
}

Sourced_OK="1"  