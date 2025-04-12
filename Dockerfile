FROM tomcat:9.0-jdk17

# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file (make sure it's in the same directory as this Dockerfile)
COPY Amazon.war /usr/local/tomcat/webapps/ROOT.war

# Default Tomcat start
CMD ["catalina.sh", "run"]

