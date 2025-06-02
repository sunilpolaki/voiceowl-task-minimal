FROM tomcat:9.0-jdk17-temurin AS tomcat-base
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./jpetstore.war /usr/local/tomcat/webapps/ROOT.war

FROM gcr.io/distroless/java17-debian11:nonroot
COPY --from=tomcat-base /usr/local/tomcat /tomcat
WORKDIR /tomcat
USER nonroot
EXPOSE 8080
ENTRYPOINT ["java", "-cp", "bin/bootstrap.jar:bin/tomcat-juli.jar", "-Djava.security.egd=file:/dev/./urandom", "org.apache.catalina.startup.Bootstrap", "start"]
