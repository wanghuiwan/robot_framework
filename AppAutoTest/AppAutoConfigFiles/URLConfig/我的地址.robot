*** Settings ***
Resource          ../Common_Variable_Config.robot

*** Variables ***
${selectMyAddressList}    ${envSet}[addressUrlApp]/site/shop/selectMyAddressList    # \ 获取地址
${updateMyAddress}    ${envSet}[addressUrlApp]/site/shop/updateMyAddress    # 新增地址
${deleteMyAddress}    ${envSet}[addressUrlApp]/site/shop/deleteMyAddress    # 删除地址
