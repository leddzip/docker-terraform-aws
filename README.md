Terraform AWS
=============

This project provide a docker image (deployed inside DockerHUB)
to execute terraform with aws-cli v2 in a bash context.

The base image comes from the official [BASH docker image](https://hub.docker.com/_/bash)
which is based on Alpine.

Build limitations
-----------------

Most of the limitations come from the different version between
tools in the CI/CD and the local tools used for test and experimentation.

| tool   | local version |  circle-ci version |
|--------|---------------|--------------------|
| make   | 4.2.1         | 3.8.1              |
| bash   | 5.0.17        | 4.3.11             |
| docker | 20.10.8       | 17.09.9-ce         |
    