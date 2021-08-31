ARG AWS_CLI_VERSION=2.2.33
ARG TERRAFORM_VERSION=1.0.5
ARG BASH_VERSION=5.1.8

FROM bash:${BASH_VERSION}

#COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]