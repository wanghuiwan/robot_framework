#!/usr/bin/python
# coding:utf-8
# robot_framework - versionChange.py
# 2021/4/21 17:17

__author__ = 'Martin Wang <357951@qq.com>'


# 编辑版本号减少小版本
def version_jianyi(version):
    version = version.split('.')
    if int(version[2]) >= 1:
        version[2] = str(int(version[2]) - 1)
    elif int(version[1]) >= 1:
        version[1] = str(int(version[1]) - 1)
    else:
        version[0] = str(int(version[0]) - 1)
    return '.'.join(version)


# 编辑版本号增加小版本
def version_jiayi(version):
    version = version.split('.')
    version[2] = str(int(version[2]) + 1)
    return '.'.join(version)


# 将 0改为True 剩下的改为False
def true_or_false(str_int):
    data = int(str_int)
    if data == 0:
        return True
    else:
        return False
