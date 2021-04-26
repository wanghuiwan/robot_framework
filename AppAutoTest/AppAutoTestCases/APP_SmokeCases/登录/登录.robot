*** Settings ***
Suite Setup       Set Log Level    trace
Resource          ../../../AppAutoConfigFiles/Resources_Config.robot

*** Test Cases ***
登录
    #定义请求参数
    ${commdata}    set variable    {"account" : "${APP_user_data}[userMobile]","type" : "2","password" : "${APP_user_data}[userPassword]"}
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
