
可用的环境变量:

* DB_HOST  数据库主机
* DB_PORT MySQL数据库端口,如果不指定缺省为3306.
* DB_NAME 数据库名，如果不指定缺省为`icescrum`.
* DB_USER 连接数据库的用户名，如果不指定缺省为`icescrum`.
* DB_PASS 连接数据库的密码.

``` yml
icescrum:
    image: registry.ecloud.com.cn:5000/icescrum
    container_name: icescrum
    ports:
        - "8083:8080"
    environment:
        - DB_HOST=172.17.42.1
        - DB_NAME=icescrum
        - DB_USER=icescrum
        - DB_PASS=china-ops
```
