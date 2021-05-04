*** Settings ***
Resource          Resources_Config.robot

*** Variables ***
&{uatEnvConfig}    baseUrlApp=http://bbs.51testing.com    addressUrlApp=http://bbs.51testing.com    # \ UAT环境
&{APP_user_one}    name=wanghuiwan    password=111111    # 用户一号
&{APP_user_two}    name=wanghuiwan    password=111111    # 用户二号
&{uat_mysql}      user=root    password=123456    host=192.168.1.100    port=3306    # uat 数据库
&{prod_mysql}     user=root    password=123456    host=192.168.1.100    port=3306    # prod 数据库
${APP_user_data}    ${APP_user_one}    #选择APP登录用户
${envSet}         ${uatEnvConfig}    #选择配置环境
${envDatabase}    ${uat_mysql}    #选择数据库配置环境

*** Keywords ***
APP_login
    #定义请求参数
    ${commdata}    set variable    {"account" : "${APP_user_data}[userMobile]","did" : "${APP_user_data}[did]","type" : "2","password" : "${APP_user_data}[userPassword]"}
    #定义请求头
    &{headerss}    Create Dictionary    Content-Type=application/json
    ${data}    requests.post    ${App_Login}    data=${commdata}    headers=&{headerss}
    #打印日志
    log    ${data.json()}
    #设置全局变量给其他接口使用
    Set Global Variable    ${accessToken}    ${data.json()}[data][login][accessToken]
    Set Global Variable    &{headers}    &{headerss}
    Set Global Variable    ${tokenType}    ${data.json()}[data][login][tokenType]
    Set Global Variable    ${mobile}    ${data.json()}[data][userInfo][mobile]
    #断言
    Should Be Equal    ${mobile}    ${APP_user_data}[userMobile]    登录后手机号不一致
