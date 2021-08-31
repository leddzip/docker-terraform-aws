Terraform AWS
=============

This image should provide a base bash image with terraform and aws-cli so it
can be used in any docker based pipeline to provision terraform deployment on AWS.

The base image comes from the official [BASH docker image](https://hub.docker.com/_/bash)
which is based on Alpine.

Tagging 
-------

### env target prefix
Based on the env we want to target (most common scenario is dev and prod), we generate a prefix or not for each of the tags
described in the following sections.

If the target is prod, we don't generate any prefix.

If the target is no prod (like dev), each tag will be prefixed with the name of the env target:
* dev-latest
* dev-0.1.0
* dev-*whatever*

This prefix is generated using the script [build-env-prefix.sh](./build-scripts/build-env-prefix.sh). 

### dependency based
Those tags are based on the main dependencies of the image:
* bash (5.1.8)
* terraform (1.0.5)
* aws-cli (2.2.33)

based on this, 3 set of tags will be generated: 
* major: 5_1_2
* minor: 5.1_1.0_2.2
* debug: 5.1.8_1.0.5_2.2.33

Those tags are generated using the script [build-version.sh](./build-scripts/build-version.sh).

### project based semantic versioning
The file ["version"](./version) contains the actual version of the project. This version is also used to create a new tag.

This version is manage as follow (as well as using the basics of semantic versioning):
1. if the debug version of any of the main dependency changes, we increase our debug by one.
2. if the minor version of any of the main dependency changes, we increase our minor by one.
3. if the major version of any of the main dependency changes, we increase our major by one.

Building the Dockerfile
-----------------------

There is no `Dockerfile` in this repo, only a template. To build the `Dockerfile` based on this template,
we have to inject the version of our main dependencies.

To do this injection, we are using the `envsubst` command in order to inject env variable in one file.
The  actual command that is doing this injection and file creation is:
```bash
envsubst "`printf '${%s} ' $(cat args | cut -d' ' -f2 | cut -d'=' -f1)`" < Dockerfile.template > Dockerfile
```

The first part of the command is a trick to list only the env variable we want to inject. Otherwise,
ARGS that are in the template file might be wrongly recognised as env variable (since the syntax is the same) and replaced by
either an empty string (if the env variable is not defined) or by the env variable content if one exist with the same name.

To avoid this uncertainty, we only tell `envsubst` to inject the variable listed in the `args` file.

Tool version mismatch
---------------------

To avoid potential mismatch of version between my local env and my CI/CD env (CircleCI), the image is build on a vm
based on *ubuntu 20.04*. 