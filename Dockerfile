FROM bitnami/base-ubuntu:14.04
MAINTAINER Voob of Doom <voobscout@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV GIT_SSL_NO_VERIFY 1
ENV container docker

# RUN apt-get update && \
#     apt-get -y -q dist-upgrade && \
#     apt-get install -y -q curl locales && \
#     echo "Europe/Berlin" > /etc/timezone && \
#     dpkg-reconfigure tzdata && \
#     echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections && \
#     echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections && \
# #    apt-get -y -q install less vim zsh screen git-core sudo && \
#     rm /var/log/apt/* /var/log/alternatives.log /var/log/bootstrap.log /var/log/dpkg.log

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["weave", "10.10.0.0/16"]
