# greylog-stack
Implementation of Cloud engineering challenge for Greylog

## Structure
This git repository contains implementation for the greylog chanllege.

The terraform modules created are in this [location](./modules):
 - [networking](./modules/networking)
 - [compute](./modules/compute)
 - [database](./modules/database)

The terraform workspace created is in this [location](./workspace):
 - [sandbox](./workspace/sandbox)

## Documentation
To view documentation on each module, please visit the readme.md file located in each module

To view documentation on how to run the terraform scripts, please visit the [sandbox](./workspace/sandbox) workspace and read the readme.md

## Architectural diragram
![Architectural diagram](./greylog.jpg)

> Note: To make it easy for anyone else to run this terraform configuration without doing too much configurations I did not:
- Configure a remote backend, which should be used when collaboration with other engineers.
- Create a separate git repo for my modules, and tag them, so as not to break changes in the future.