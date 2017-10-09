FROM  registry.dev.ecloud.com.cn/tomcat:6.0

ENV CATALINA_HOME /usr/local/tomcat6
ENV DIR_WEBAPP $CATALINA_HOME/webapps
ENV DIR_CONF $CATALINA_HOME/conf

COPY assets/ /app/



RUN set -x \
        && rm -fr $DIR_WEBAPP/ROOT \
#        && rm -fr $DIR_CONF/web.xml \
#        && mv /app/web.xml $DIR_CONF \
        && mv /app/web $DIR_WEBAPP/ROOT

RUN rm -f $CATALINA_HOME/lib/tomcat-jdbc.jar

EXPOSE 8080

CMD ["/app/start.sh"]
