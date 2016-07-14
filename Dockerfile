# Pull base image.
FROM dtr.cucloud.net/cs/awscli

RUN apt-get update
RUN apt-get install zlib1g-dev
RUN gem install aws-sdk
RUN gem install nokogiri
RUN gem install json -v 1.8.3
RUN gem install aws-sdk-v1

COPY health-check.rb /opt/health-check.rb

RUN groupadd -g 7070 tcadm
RUN useradd -u 105 -g 7070 tomcat7
RUN chown tomcat7:tcadm /opt/health-check.rb
RUN chmod 775 /opt/health-check.rb

USER tomcat7
CMD /opt/health-check.rb 
