*** Settings ***
Documentation     引入的包
Library           requests
Library           random
Library           DateTime
Library           RequestsLibrary
Library           Collections
Resource          Common_Variable_Config.robot
Resource          URLConfig/登录.robot
Resource          URLConfig/我的地址.robot
Resource          URLConfig/App更新接口.robot
Library           ../AppAutoCommonLib/versionChange.py
Library           ../AppAutoCommonLib/mysqlLib.py

*** Keywords ***
mysql_select
    [Arguments]    ${sql}
    ${result}    Mysql Select With Param    ${sql}    ${envDatabase}[host]    ${envDatabase}[port]    ${envDatabase}[user]    ${envDatabase}[password]
    [Return]    ${result}
