###############################################################################
#  HTML.lib                                              Version : 1.1.2.2    #
#                                                                             #
# Creation Date : 08/12/2006                                                  #
# Team          : Only me after all                                           #
# Support mail  : arnaud@crampet.net                                          #
# Author        : Arnaud Crampet                                              #
#                                                                             #
# Subject : This library provide base html generate runtime and is provided   #
#           from CAST FRAMWORK from Araud Crampet                             #
###############################################################################
####
# INFO


################### File system reports functions #############################

function do_html_table_head_report_fs
{
  #|# Var to set  :
  #|# _html_file_to_export       : Use this var to set name of the report file
  #|# _server_name     : Use this var to set name of server on which we report
  #|#
  #|# Base usage  : do_html_table_head_report_fs "Html file to generate" "Server"
  #|#
  #|# Description : This fuction create Table header in HTML code for FS reporting
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${1}"
  _server_name="${2}"
  do_html_table_head_report_fs="${3}"

  echo  "<table style=\"text-align: left; width: 750px; border-width:1px;\" cellpadding=\"2\" cellspacing=\"2\">"         >> ${_html_file_to_export}
  echo  "<tbody>"                                                                                                         >> ${_html_file_to_export}
  echo  "<tr>"                                                                                                            >> ${_html_file_to_export}
  echo  "    <td width=\'450\'>Mount Point </td>"                                                                         >> ${_html_file_to_export}
  echo  "    <td >Status </td>"                                                                                           >> ${_html_file_to_export}
  echo  "    <td >Space used in percent</td>"                                                                             >> ${_html_file_to_export}
  echo  "    <td >Free space </td>"                                                                                       >> ${_html_file_to_export}
  echo  "    </td>"                                                                                                       >> ${_html_file_to_export}
  echo  "</tr>"                                                                                                           >> ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function HTML_Table_Close_Report_FS
{
  #|# Var to set  :
  #|# _html_file_to_export       : Use this var to set name of the report file
  #|# _server_name     : Use this var to set name of server on which we report
  #|#
  #|# Base usage  : HTML_Table_Close_Report_FS "Html file to generate" "Server"
  #|#
  #|# Description : This fuction create Table end in HTML code for FS reporting
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
    Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
    ######################################################
    set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

    
  _html_file_to_export="${1}"
  _server_name="${2}"
  do_html_table_head_report_fs="${3}"

  echo  " </tbody>" >> ${_html_file_to_export}
  echo  "</table>"  >> ${_html_file_to_export}
  echo  "<br>"      >> ${_html_file_to_export}
  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}


function HTML_Error_Html_Report_FS
{
  #|# Var to set  :
  #|# _html_file_to_export  : Use this var to set name of the report file
  #|#
  #|# Base usage  : HTML_Error_Html_Report_FS "Html file to generate"
  #|#
  #|# Description : This fuction create Table end in HTML code for FS reporting
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${1}"

  echo  "<tr> <td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${Device_Mnts_To_State} </td>"  >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${State_Case} </td>"                 >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${Device_perc_To_State} </td>"       >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 0, 0);\"> ${Device_Free_To_State} </td></tr>"  >> ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function HTML_Warn_Html_Report_FS
{
  #|# Var to set  :
  #|# _html_file_to_export  : Use this var to set name of the report file
  #|#
  #|# Base usage  : HTML_Warn_Html_Report_FS "Html file to generate"
  #|#
  #|# Description : This fuction create Table end in HTML code for FS reporting
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${1}"

  echo  "<tr> <td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${Device_Mnts_To_State} </td>"    >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${State_Case} </td>"                   >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${Device_perc_To_State} </td>"         >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; font-weight: bold; color: rgb(255, 153, 0);\"> ${Device_Free_To_State} </td></tr>"    >> ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function HTML_Good_Html_Report_FS
{
  #|# Var to set  :
  #|# _html_file_to_export  : Use this var to set name of the report file
  #|# ${1}                 : Use this var to set [ _html_file_to_export ]
  #|#
  #|# Base usage  : HTML_Good_Html_Report_FS "Html file to generate"
  #|#
  #|# Description : This fuction Table HTML code for Good state FS
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${1}"

  echo  "<tr> <td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${Device_Mnts_To_State} </td>"    >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${State_Case} </td>"                   >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${Device_perc_To_State} </td>"         >> ${_html_file_to_export}
  echo  "<td style=\"vertical-align: top; color: rgb(0, 0, 0);\"> ${Device_Free_To_State} </td> </tr>"   >> ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

#################### generics HTML function

function set_html_repport_header
{
  #|# Var to set  :
  #|# _html_file_to_export  : Use this var to set name of the report file
  #|#
  #|# Base usage  : HTML_Good_Html_Report_FS "Html file to generate"
  #|#
  #|# Description : This fuction header HTML code for reports
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${1}"
  HTML_REPORT_TITLE="${2}"
  HTML_REPORT_SERVERNAME="${3}"
  HTML_REPORT_DATETIME="${3}"

  echo  "<html>"                                                                                                              > ${_html_file_to_export}
  echo  "<head>"                                                                                                             >> ${_html_file_to_export}
  echo  "<Style type=\"text/css\"> td { border:thin dotted blue; font-weight: bold;} </style>"                               >> ${_html_file_to_export}
  echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"                                       >> ${_html_file_to_export}
  echo  "<title></title>"                                                                                                    >> ${_html_file_to_export}
  echo  "</head>"                                                                                                            >> ${_html_file_to_export}
  echo  "<body>"                                                                                                             >> ${_html_file_to_export}
  echo  "Repport : ${HTML_REPORT_TITLE} for server ${HTML_REPORT_SERVERNAME} <br>"                                           >> ${_html_file_to_export}
  echo  "This report have been generated AT : ${HTML_REPORT_DATETIME}"                                                       >> ${_html_file_to_export}
  echo  "<br>"                                                                                                               >> ${_html_file_to_export}
  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function HTML_ADD_TITLE
{
  #|# Var to set  :
  #|# _html_file_to_export       : Use this var to set name of the report file
  #|# HTML_TITLE_TEXT           : Use this var to set Title text to inser in file.
  #|#
  #|# Base usage  : HTML_ADD_TITLE_L1 "Html file to generate" "TITLE"
  #|#
  #|# Description : This fuction create Title entry in HTML file 
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
    Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
    ######################################################
    set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

    
  _html_file_to_export="${1}"
  HTML_TITLE_TEXT="${2}"
  

  echo  "<br>"                                  >> ${_html_file_to_export}
  echo  "  <P>"                                 >> ${_html_file_to_export}
  echo  "    <title>${HTML_TITLE_TEXT}</title>" >> ${_html_file_to_export}
  echo  "  </P>"                                >> ${_html_file_to_export}
  echo  "<BR>"                                  >> ${_html_file_to_export}

  
  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function set_html_repport_footer
{
  #|# Var to set  :
  #|# _html_file_to_export  : Use this var to set name of the report file
  #|#
  #|# Base usage  : set_html_repport_footer "Html file to generate"
  #|#
  #|# Description : This fuction footer HTML code for reports
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${1}"

  echo  "</tbody>"    >> ${_html_file_to_export}
  echo  "</table>"    >> ${_html_file_to_export}
  echo  "<br>"        >> ${_html_file_to_export}
  echo  "</body>"     >> ${_html_file_to_export}
  echo  "</html>"     >> ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function HTML_int_Menu_Generator_GEN
{
  #|# Var to set  : None
  #|# HIMGG_Base_Menu_Directory   : use this var to set chere to create the menu file
  #|# HIMGG_INT_lst               : use this var to set the ints list
  #|# ${1}                        : use this var to set HIMGG_Base_Menu_Directory
  #|# ${2}                        : use this var to set HIMGG_INT_lst
  #|#
  #|# Base usage  : HTML_int_Menu_Generator_GEN "my_full_path" "int1 int2 intxxx"
  #|#
  #|# Description : This fuction create report menu
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  HIMGG_Base_Menu_Directory="${1}"
  HIMGG_INT_lst="${2}"

  _html_file_to_export="${HIMGG_Base_Menu_Directory}/index.html"

  echo  "<html>"                                                                         >  ${_html_file_to_export}
  echo  "<head>"                                                                        >>  ${_html_file_to_export}
  echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"  >>  ${_html_file_to_export}
  echo  "<title></title>"                                                               >>  ${_html_file_to_export}
  echo  "</head>"                                                                       >>  ${_html_file_to_export}
  echo  "<body>"                                                                        >>  ${_html_file_to_export}
  for ints in ${HIMGG_INT_lst}
    do
      echo  "<a href=\"${ints}/index.html\">${ints}</a><br>"                           >>  ${_html_file_to_export}
  done
  echo  "</body>"                                                                       >>  ${_html_file_to_export}
  echo  "</html>"                                                                       >>  ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function HTML_Internal_HTML_int_Menu_Generator_GEN
{
  #|# Var to set  :
  #|# HIHIMGG_Base_PATH_OF_FILES_INTS   : use this var to set chere to create the menu file
  #|# HIMGG_INT_lst                     : use this var to set the ints list
  #|# ${1}                              : use this var to set HIMGG_Base_Menu_Directory
  #|# ${2}                              : use this var to set HIMGG_INT_lst
  #|#
  #|# Base usage  : HTML_Internal_HTML_int_Menu_Generator_GEN  "my_full_path" "int1 int2 intxxx"
  #|#
  #|# Description : This fuction create report menu
  #|#
  #|# Send Back   : HTML code
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 


  HIHIMGG_Base_PATH_OF_FILES_INTS="${1}"
  HIHIMGG_INT_lst="${2}"

  for HIHIMGG_ints in ${HIHIMGG_INT_lst}
      do
        HIHIMGG__html_file_to_export="${HIHIMGG_Base_PATH_OF_FILES_INTS}/${HIHIMGG_ints}/index.html"
        set_message "Debug2" "HTML File to export is set to : [ ${HIHIMGG__html_file_to_export} ] "

        echo  "<html>"                                                                         >  ${HIHIMGG__html_file_to_export}
        echo  "<head>"                                                                        >>  ${HIHIMGG__html_file_to_export}
        echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"  >>  ${HIHIMGG__html_file_to_export}
        echo  "<title></title>"                                                               >>  ${HIHIMGG__html_file_to_export}
        echo  "</head>"                                                                       >>  ${HIHIMGG__html_file_to_export}
        echo  "<body>"                                                                        >>  ${HIHIMGG__html_file_to_export}
        for HIHIMGG_files in `ls ${HIHIMGG_Base_PATH_OF_FILES_INTS}/${HIHIMGG_ints}/ | egrep -v index `
            do
              HIHIMGG_File_Name_To_lnk=$( echo ${HIHIMGG_files} | awk -F\. '{ print $1 }' )
              echo  "<a href=\"./${HIHIMGG_files}\">${HIHIMGG_File_Name_To_lnk}</a><br>"      >>  ${HIHIMGG__html_file_to_export}
            done
        done
        echo  "</body>"                                                                       >>  ${HIHIMGG__html_file_to_export}
        echo  "</html>"                                                                       >>  ${HIHIMGG__html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}

function set_html_table_start
{
  #|# Base_Menu_Directory   : use this var to set chere to create the menu file
  #|# INT_lst               : use this var to set the ints list
  #|# Base use              :
  #|#                          Base_Menu_Directory="my_full_path"
  #|#                          INT_lst="int1 int2 intxxx"
  #|#                          HTML_int_Menu_Generator_GEN
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 

  _html_file_to_export="${Base_Menu_Directory}/index.html"

  echo  "<html>"                                                                         >  ${_html_file_to_export}
  echo  "<head>"                                                                        >>  ${_html_file_to_export}
  echo  "<meta content=\"text/html; charset=ISO-8859-1\" http-equiv=\"content-type\">"  >>  ${_html_file_to_export}
  echo  "<title></title>"                                                               >>  ${_html_file_to_export}
  echo  "</head>"                                                                       >>  ${_html_file_to_export}
  echo  "<body>"                                                                        >>  ${_html_file_to_export}
  for ints in ${INT_lst}
    do
      echo  "<a href=\"${ints}/index.html\">${ints}</a><br>"                           >>  ${_html_file_to_export}
  done
  echo  "</body>"                                                                       >>  ${_html_file_to_export}
  echo  "</html>"                                                                       >>  ${_html_file_to_export}

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}


function HTML_create_Frame
{
  #|# Description : This fucnction create all needed frame for autodoc site
  ############ STACK_TRACE_BUILDER #####################
  Function_PATH="${Function_PATH}/${FUNCNAME[0]}"
  ######################################################
  set_message "Debug6" "Current Stack : [ ${Function_PATH} ] " 


  _number_frame="${1}"
  _name_frame="${2}"

  HCF_NUM_From_Name="$(echo  ${_name_frame} | awk '{ print NF }')"
  if [ "${HCF_NUM_From_Name}"	= "${_name_frame}" ]
    then
          set_message "Debug5" "Number of frame : [ ${_number_frame} ]"
          HCF_Fnumb="1"
          for HCF_FName in
            do
                set_message "Debug5" "Name of frame number ${HCF_Fnumb} : [ ${_name_frame} ] "
          done
    else
          set_message "ErrorN" "Number of frame : [ ${_number_frame} ] is not equal to : [ ${HCF_NUM_From_Name} ] " "2"
  fi

  ############### Stack_TRACE_BUILDER ################
  Function_PATH="$( dirname ${Function_PATH} )"
  ####################################################
}



Sourced_OK="1"