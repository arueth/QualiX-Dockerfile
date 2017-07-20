FROM guacamole/guacamole:0.9.10-incubating

ENV GUACAMOLE_HOME_DIR=/opt/guacamole/.guacamole

ENV QUALIX_S3_AUTH_FILE="qualix-0.9.10.tar.gz"
ENV QUALIX_S3_URL="https://s3.amazonaws.com/quali-prod-binaries/"${QUALIX_S3_AUTH_FILE}

ENV QUALIX_GUACAMOLE_VERSION="0.9.10-incubating"
ENV QUALIX_AUTH_PACK_NAME="guacamole-auth-quali-"${QUALIX_GUACAMOLE_VERSION}

WORKDIR /opt/guacamole

COPY qualix .

RUN keytool -genkey -alias tomcat -keyalg RSA -validity 3650 -storepass changeit -keypass changeit -dname "C=US, ST=California, L=Santa Clara, O=Quali" \
&& mkdir -p ${GUACAMOLE_HOME_DIR}/extensions && wget -qO- ${QUALIX_S3_URL} | tar -xzf - && cp ${QUALIX_AUTH_PACK_NAME}/${QUALIX_AUTH_PACK_NAME}.jar ${GUACAMOLE_HOME_DIR}/extensions/ \
&& rm -r ${QUALIX_AUTH_PACK_NAME}

WORKDIR /usr/local/tomcat

COPY tomcat/conf/server.xml conf/server.xml

EXPOSE 8080 8443
