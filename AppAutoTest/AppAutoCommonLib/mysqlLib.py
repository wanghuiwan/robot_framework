#!/usr/bin/python
# coding:utf-8
# robot_framework - mysqlLib.py
# 2021/4/22 09:28
"""
mysql数据库操作
mysql_select执行查询语句并返回所有查询结果（元组类型）
mysql_execute执行增、删、改操作
mysql_close 关闭连接
注意事项：建立连接时未限定数据库名，编写sql语句时需要在表名前加入数据库名（database.table）
"""
__author__ = 'Martin Wang <357951@qq.com>'


import pymysql
from robot.api import logger
import datetime
import json


class mysqlLib():
    """连接数据库，并进行操作"""

    def __init__(self):
        self.charset = 'utf8'

    def mysql_close(self):
        self.cursor.close()  # 关闭游标
        self.cnn.close()  # 关闭数据连接

    def mysql_execute_with_param(self, sql, host, port, user, passwd):
        """执行sql语句并提交：包含增、删、改"""

        self.cnn = pymysql.connect(host=host, port=int(port), user=user, passwd=passwd, charset=self.charset)
        self.cursor = self.cnn.cursor()
        try:
            logger.info(sql)
            self.cursor.execute(sql)
            self.cnn.commit()
        except Exception as e:
           logger.info(e)
           self.cnn.rollback()
           logger.info('execute error, rollback')


    def mysql_executemany_with_param(self,sql, values, host, port, user, passwd):
        """执行sql语句并提交：包含增、删、改"""

        #self.__init__(host, port, user, passwd)
        self.cnn = pymysql.connect(host=host, port=int(port), user=user, passwd=passwd, charset=self.charset)
        self.cursor = self.cnn.cursor()
        try:
            self.cursor.executemany(sql, values)
            self.cnn.commit()
        except Exception as e:
            logger.info(e)
            self.cnn.rollback()


    def mysql_select_with_param(self, sql, host, port, user, passwd):
        """执行查询sql语句，并返回所有查询结果"""

        #self.__init__(host, port, user, passwd)
        self.cnn = pymysql.connect(host=host, port=int(port), user=user, passwd=passwd, charset=self.charset)
        self.cursor = self.cnn.cursor()
        try:
            logger.info(sql)
            self.cursor.execute(sql)
            data = self.cursor.fetchall()
            logger.info(data)
            return data

        except Exception as e:
            logger.info('select error in mysql : {}'.format(e))



def get_datetime(delay=0):
        today = datetime.datetime.now()
        future = today + datetime.timedelta(days=delay)
        futuredate = future.strftime('%Y-%m-%d %H:%M:%S')
        return datetime.datetime.strptime(futuredate, "%Y-%m-%d %H:%M:%S")


def bit_to_int(bits):
    # 数据库存的bit(1),bit类型转化到int类型
    data = int.from_bytes(bits, 'little', signed=True)
    return data


if __name__ == '__main__':
    connect = mysqlLib()
    # force_update是否强制更新，current_version当前apk版本，apkurl apk下载地址，sys_type 操作系统类型 1.Android: 2.IOS
    result= connect.mysql_select_with_param("select * from  `database`.`table` ;", "host",port, "user", "password")
    print(result)