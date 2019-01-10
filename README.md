[![Docker Automated build](https://img.shields.io/docker/automated/hendrik44/docker-ansible-molecule.svg)](https://github.com/Hendrik44/docker-ansible-molecule) [![Docker Build Status](https://img.shields.io/docker/build/hendrik44/docker-ansible-molecule.svg)](https://github.com/Hendrik44/docker-ansible-molecule) [![Pulls on Docker Hub](https://img.shields.io/docker/pulls/hendrik44/docker-ansible-molecule.svg)](https://hub.docker.com/r/Hendrik44/docker-ansible-molecule) [![Open Issues](https://img.shields.io/github/issues/hendrik44/docker-ansible-molecule.svg)](https://github.com/Hendrik44/docker-ansible-molecule)

# Running Molecule in Docker
A minimal docker container to run molecule tests in CI e.g. Jenkins based on a small python 3.6 alpine image.

## Usage
`docker run --rm -v $PWD/:/home/myuser/ansible-role-name -v /var/run/docker.sock:/var/run/docker.sock hendrik44/docker-ansible-molecule`

