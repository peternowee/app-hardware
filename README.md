# app-hardware

Demo-app for keeping track of which people possess which pieces of
hardware.

This repository `app-hardware` contains the backend.

The frontend can be found in repository `frontend-hardware`.

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](https://git-scm.com/)
* [Docker](https://www.docker.com/)

## Installation

* `git clone <repository-url>` this repository

## Running

* `cd app-hardware`
* `docker-compose up`

## Virus scanner

This stack contains a virus-scanner-service running ClamAV daemon
`clamd`.

Note: The ClamAV authors do not recommend running `clamd` as `root` for
safety reasons because ClamAV scans untrusted files that may be
malware. However, the file-service currently saves its files with
access permission for `root` only. Consider the security implications
for your situation. To let `clamd` run as `root`, add the following to
`docker-compose.override.yml`:

```yaml
version: '3.4'

services:
  virus-scanner:
    environment:
      VIRUS_SCANNER_CLAMD_USER: "root"
```

and run:

* `docker-compose down && docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d`

## Architecture

Based on the [semantic.works](https://semantic.works/) microservice
framework.

This project was bootstrapped from
[mu-project](https://github.com/mu-semtech/mu-project).
