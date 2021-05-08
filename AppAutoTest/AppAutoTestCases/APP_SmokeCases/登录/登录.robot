*** Settings ***
Suite Setup       Set Log Level    trace
Resource          ../../../AppAutoConfigFiles/Resources_Config.robot

*** Test Cases ***
登录
    #定义请求参数
    ${commdata}    set variable    {"fastloginfield":"username", "username":"wanghuiwan", "password":"96e79218965eb72c92a549dd5a330112", "quickforward":"yes", "handlekey":"ls"}
    #定义请求头
    &{headerss}    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    #定义拼接参数
    ${parameters}    Create Dictionary    mod=logging    action=login    loginsubmit=yes    infloat=yes
    Set To Dictionary    ${parameters}    lssubmit    yes    inajax    ${1}
    ${data}    requests.post    ${App_Login}    data=${commdata}    headers=&{headerss}    params=${parameters}
    #打印日志
    log    ${data.text}
    #设置全局变量给其他接口使用
    Comment    Set Global Variable    ${accessToken}    ${data.json()}[data][login][accessToken]
    Comment    Set Global Variable    &{headers}    &{headerss}
    Comment    Set Global Variable    ${tokenType}    ${data.json()}[data][login][tokenType]
    Comment    Set Global Variable    ${mobile}    ${data.json()}[data][userInfo][mobile]
    #断言
    Comment    Should Be Equal    ${mobile}    ${APP_user_data}[userMobile]    登录后手机号不一致

dosomething
    FOR    ${index}    ${english_name}    ${chinese_name}    IN ENUMERATE    cat    猫    dog    狗
        log    ${index}-${english_name}-${chinese_name}
    END
    ${random}    Evaluate    random.randint(0,sys.maxsize)    random,sys
    log    ${random}
