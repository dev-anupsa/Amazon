FROM tomcat:9.0-jdk17

# Remove default webapps (optional cleanup)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat webapps
COPY Amazon.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]

