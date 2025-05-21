# Build Server Debugging Doc

This document serves to discuss the issues seen while trying to install yarn and node under Ubuntu 22.04 with TeamCity build runner.

-----

## Setup
This is setup as a test environment using a standard docker image for Ubuntu 22.04.

### Required Software:
- Yarn v1.22 (v4.91 latest)
- Node 18.x or 20.x (I think 18 is the LTS)
- Team City v2025.03.2

### Expected Outcomes:
Yarn should be able
* be installed fully either 1.22 or latest 4.9 versions
* to compile a simple project
* to compile an actual project
* to compile a project through a team city deployment process

-----

## Environment setup

This is a docker project to set up a container for Ubuntu 22.04 server and get yarn and team city running so it can build project files

**docker-compose.yml**

This file serves as the starting point for the container.

**Dockerfile**
This serves to run the various scripts for the systems we want to control and have operational

### teamcity.sh
bash commands for installing teamcity
### node.sh
bash commands for installing node 18.x
### yarn.sh
bash commands for installing yarn 1.22 or with the env flag set to latest will install latest yarn 4.9.x

-----

## Artifacts
When testing builds you can use the preconfigured team city with the credientials of chad:chad to get in, run the build for the status portal project.

Before a build delete the contents of `public/assets/@BUILDNUMBER@/` this will just help provide a clean slate for the output of the build rather than have to decipher the contents from the contents stored in git.

Once the build is run in TeamCity you can navigate to the folder `workspace/system/artifacts/Statusportal/Build/<buildnumber>/` where you will see the tar gzip file. This can be extracted by `tar -xf quantum-status.tar.gz` and the public assets directory can be see with in the extracted direcory structure.

