*** Settings ***
Documentation     app更新接口验证
...               入参：
...               系统：sysType: 1-android,
...               \ \ \ \ \ \ \ \ \ \ \ 2-ios
...
...               clientVersion: 用户安装的系统版本，如2.9.1
...
...               出参：
...               issueType：更新类型 \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 0：当前为最新版，无需更新
...
...               \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 1：推送更新提示
...
...               forceUpdate： 是否强制更新True False
...
...               By Martin Wang
...
...
...               Date 2021-04-21
Resource          ../../../AppAutoConfigFiles/Resources_Config.robot

*** Test Cases ***
IOS_App更新正常更新
    # 获取基础数据以及测试数据
    ${sys_type}    set variable    2    # 定义手机类型2为iso 1为android
    ${data}    mysql_select    select oct(force_update+0),current_version,apkurl,sys_type from \ `database`.`table` where sys_type = ${sysType};
    Comment    ${force_update1}    set variable    ${data}[0][0]
    ${force_update}    versionChange.true_or_false    ${data}[0][0]    # 获取强制更新状态
    ${NewAppVersion}    versionChange.version_jianyi    ${data}[0][1]    # 设置版本号比当前小1
    #定义请求头
    &{headerss}    Create Dictionary    Content-Type=application/json
    # 定义参数
    &{params}    Create Dictionary    sysType=${sys_type}    clientVersion=${NewAppVersion}
    # App更新地址
    ${NewVersion}    requests.get    ${getNewestIssue}    params=&{params}
    log    ${NewVersion.json()}
    log    ${NewVersion.json()}[data][currentVersion]
    #断言
    Should Be Equal    ${NewVersion.json()}[status]    ${1}    返回信息异常    #1:返回信息正常
    Should Be Equal    ${NewVersion.json()}[data][issueType]    ${1}    正常推送更新提示    #1:需要更新，0:不需要更新
    Should Be Equal    ${NewVersion.json()}[data][forceUpdate]    ${force_update}    强制更新和数据库对比异常

IOS_版本大于后台版本无需更新
    # 获取基础数据以及测试数据
    ${sys_type}    set variable    2    # 定义手机类型2为iso 1为android
    ${data}    mysql_select    select oct(force_update+0),current_version,apkurl,sys_type from \ `database`.`table` where sys_type = ${sysType};
    Comment    ${force_update1}    set variable    ${data}[0][0]
    ${force_update}    versionChange.true_or_false    ${data}[0][0]    # 获取强制更新状态
    ${NewAppVersion}    versionChange.version_jiayi    ${data}[0][1]    # 设置版本号比当前小1
    #定义请求头
    ${headerss}    Create Dictionary    Content-Type=application/json
    # 定义参数
    ${params}    Create Dictionary    sysType=${sys_type}    clientVersion=${NewAppVersion}
    # App更新地址
    ${NewVersion}    requests.get    ${getNewestIssue}    params=${params}
    log    ${NewVersion.json()}
    log    ${NewVersion.json()}[data][currentVersion]
    #断言
    Should Be Equal    ${NewVersion.json()}[status]    ${1}    返回信息异常
    Should Be Equal    ${NewVersion.json()}[data][issueType]    ${0}    是否更新异常    #1:需要更新，0:不需要更新
    Should Be Equal    ${NewVersion.json()}[data][forceUpdate]    ${force_update}    强制更新和数据库对比异常

*** Keywords ***
