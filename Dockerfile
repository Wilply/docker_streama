FROM debian:latest

RUN apt update && apt install -y \
	openjdk-8-jre \
	curl
	

RUN curl -o streama.war -L $(curl -s https://api.github.com/repos/streamaserver/streama/releases/latest | grep 'browser_' | cut -d\" -f4)
RUN mkdir streama
RUN mv *.war /streama/streama_latest.war
RUN curl -o application.yml -L https://raw.githubusercontent.com/dularion/streama/master/docs/sample_application.yml
RUN cp application.yml /streama/application.yml
RUN chmod 775 /streama/streama_latest.war
RUN mkdir data

EXPOSE 8080

RUN rm -rf /tmp/* \
	/var/lib/apt/lists/*

CMD ["java", "-jar", "/streama/streama_latest.war"]
