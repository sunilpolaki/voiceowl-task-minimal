FROM tomcat:8-jre8 
COPY ./target/jpetstore.war /usr/local/tomcat/webapps
EXPOSE 8080 
