FROM  registry.com/library/tomcat:latest

ENV DIR_WEBAPP $CATALINA_HOME/webapps

COPY assets/ /app/


RUN set -x \
        && rm -fr $DIR_WEBAPP/ROOT \
        && mv /app/web $DIR_WEBAPP/ROOT

RUN rm -f $CATALINA_HOME/lib/tomcat-jdbc.jar

EXPOSE 8080

CMD ["/app/start.sh"]
