# README

## Introduction

This web-application was designed for the 2VD student organization at Texas A&M University. Members of this organization can upload their own artwork and have it hosted in a professional looking webpage to include in their resumes or other social media. This page also allows org members to upload their submission for weekly prompts and have their work displayed along with everyone elses.

## Requirements

This code has been run and tested on:

- Ruby - 3.0.2
- Rails - 6.1.4.1
- Ruby Gems - Listed in `Gemfile`
- PostgreSQL - 13.3
- Nodejs - v16.9.1
- Yarn - 1.22.11

## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- Amazon Web Services - make an account at https://aws.amazon.com

## Installation

Download this code repository by using git:

`git clone https://github.com/JClark-TAMU/2VD-Project.git`

## Tests

An RSpec test suite is available and can be ran using:

`rspec spec/`

## Execute Code

Run the following code in Powershell if using windows or the terminal using Linux/Mac

- Make sure docker is running in the background and pull the latest version of the container we worked with in lab:

  `docker pull dmartinez05/ruby_rails_postgresql:latest`

then,

- `cd 2VD-Project`

- for Windows:

  `docker run --rm -it --volume "${PWD}:/webapp_2vd" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000`

- for Mac:

  `docker run --rm -it --volume "$(pwd):/webapp_2vd" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000`

- for Mac M1
  `docker run --rm -it --volume "$(pwd):/webapp_2vd" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 --platform linux/amd64 dmartinez05/ruby_rails_postgresql:latest`

`cd rails_app`

Install the app

`bundle install && rails webpacker:install && rails db:create && db:migrate`

Run the app
`rails server --binding=0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Environmental Variables/Files

\*\* Add instructions/description if your application requires it.

## Amazon Web Services S3 Configuration

- This application has its own user group, keys and S3 bucket. All of these things can be managed from the AWS managment console in your browser

## Deployment

\*\* Add instructions about how to deploy to Heroku

## CI/CD

TBD

## Support

Admins looking for support should first look at the application help page.
Users looking for help seek out assistance from the customer.

Staging: https://web2d-staging.herokuapp.com/
Production: https://web2d.herokuapp.com/
