FROM eclipse-temurin:17.0.8.1_1-jre-jammy
MAINTAINER martin@zukal.net

# set timezone to Europe/Zurich
ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV KARAF_INSTALL_PATH /opt
ENV KARAF_HOME $KARAF_INSTALL_PATH/apache-karaf
ENV KARAF_EXEC exec
ENV PATH $PATH:$KARAF_HOME/bin


COPY apache-karaf-4.4.3.zip /karaf.zip

RUN \
	unzip karaf.zip -d /opt/ && \
	rm karaf.zip && \
	ln -s /opt/apache-karaf-4.4.3 $KARAF_HOME && \
        useradd --shell /bin/bash --home /opt -u 1500 karaf && \
	chmod u+x $KARAF_HOME/bin/* && \
	chown karaf:karaf /opt -R

	 
USER karaf 

EXPOSE 8080

CMD ["karaf", "run"]
