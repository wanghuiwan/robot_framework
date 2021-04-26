*** Settings ***
Documentation     获取用户的地址
...               更新用户的地址
...
...
...
...               By Martin Wang
...
...
...               Date 2021-04-20
Suite Setup       Set Log Level    trace
Resource          ../../../AppAutoConfigFiles/Resources_Config.robot

*** Test Cases ***
获取地址
    [Setup]    update_address    # 查询前创建地址
    ${params}    Create Dictionary
    set to Dictionary    ${params}    token=${accessToken}
    #我的地址
    ${dataMyAddress}    requests.post    ${selectMyAddressList}    \    headers=${headers}    params=${params}
    log    ${dataMyAddress.json()}
    ${address}    set variable    99999
    ${address}    set variable if    ${dataMyAddress.json()}[result]!=[]    ${dataMyAddress.json()}[result][0][id]
    log    ${address}
    [Teardown]    del_address    ${address}    # 查询后删除地址

新增地址
    #引用登录关键字    #在进行操作前，用户必须先登录，故需要在此处引用login关键字
    APP_login
    #创建地址
    ${updateMyAdd}    Create Dictionary
    set to Dictionary    ${updateMyAdd}    name=Martin Wang    detail=建国门    postalcode=    isdefault=否    mobile=${mobile}
    set to Dictionary    ${updateMyAdd}    token=${accessToken}    provinceid=110000    cityid=110100    districtid=110101
    ${updataMyAddress}    requests.post    ${updateMyAddress}    \    headers=${headers}    params=${updateMyAdd}
    log    ${updataMyAddress.json()}
    get_address
    [Teardown]    del_address    ${address}    # 删除新增的地址

删除地址
    [Setup]    update_address    # 删除前需要创建地址
    #引用登录关键字    #在进行操作前，用户必须先登录，故需要在此处引用login关键字
    APP_login
    Comment    update_address
    Comment    get_address
    #创建地址
    ${updateMyAdd}    Create Dictionary    addressid=${address}
    ${updataMyAddress}    requests.post    ${deleteMyAddress}    \    headers=${headers}    params=${updateMyAdd}
    log    ${updataMyAddress.json()}

*** Keywords ***
del_address
    [Arguments]    ${address}
    #引用登录关键字    #在进行操作前，用户必须先登录，故需要在此处引用login关键字
    APP_login
    get_address
    #创建地址
    ${updateMyAdd}    Create Dictionary    addressid=${address}
    ${updataMyAddress}    requests.post    ${deleteMyAddress}    \    headers=${headers}    params=${updateMyAdd}
    log    ${updataMyAddress.json()}

update_address
    #引用登录关键字    #在进行操作前，用户必须先登录，故需要在此处引用login关键字
    APP_login
    #创建地址
    log    ${mobile}
    ${updateMyAdd}    Create Dictionary
    set to Dictionary    ${updateMyAdd}    name=Martin Wang    detail=建国门    postalcode=None    isdefault=否    mobile=${mobile}
    set to Dictionary    ${updateMyAdd}    token=${accessToken}    provinceid=110000    cityid=110100    districtid=110101
    ${updataMyAddress}    requests.post    ${updateMyAddress}    \    headers=&{headers}    params=${updateMyAdd}
    log    ${updataMyAddress.json()}
    get_address

get_address
    #引用登录关键字    #在进行操作前，用户必须先登录，故需要在此处引用login关键字
    APP_login
    ${params}    Create Dictionary
    set to Dictionary    ${params}    token=${accessToken}
    #我的地址
    ${dataMyAddress}    requests.post    ${selectMyAddressList}    \    headers=${headers}    params=${params}
    log    ${dataMyAddress.json()}
    ${address}    set variable    99999
    ${address}    set variable if    ${dataMyAddress.json()}[result]!=[]    ${dataMyAddress.json()}[result][0][id]
    log    ${address}
    Set Global Variable    ${address}
