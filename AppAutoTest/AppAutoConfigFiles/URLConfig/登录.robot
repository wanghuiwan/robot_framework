*** Settings ***
Documentation     登录地址
Resource          ../Common_Variable_Config.robot

*** Variables ***
${App_Login}      ${envSet}[baseUrlApp]/member.php    # 用户登录地址
