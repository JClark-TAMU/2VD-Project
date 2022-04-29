# README

## Introduction

Web2D is a organizational community event page and portfolio website for the TAMU organization 2VD. Members and alumni are able to create accounts, submit images of their artwork, and then put their artwork in community galleries and personal albums. Moreover, they are able to look at other members artwork. Officers are shown off on their own page. Information on how to use the application can be found on the website.

## Useful Rails Commands

`rails scaffold` can be used to autogenerate tables and migrations.

`Keep on adding to this`

`rails g controller <route> <name>`

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

`bundle install && rails webpacker:install && rails db:create && db:migrate && db:seed`

Run the app
`rails server --binding=0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/. Heroku should automatically do every needed step on a successful deployment.

## Environmental Variables/Files

This application requires five configuration variables. These can be configurated within the development.rb file for the development side, or the 'config vars' section in the heroku settings panel for the production side. Here is the required variables:

  `AWS_ACCESS_KEY_ID` is the key for the s3 bucket

  `AWS_SECRET_ACCESS_KEY` is the secret key for the s3 bucket

  `S3_BUCKET_NAME` is the name for the s3 bucket

  `GOOGLE_OAUTH_CLIENT_ID` is the key for the Google OAuth service

  `GOOGLE_OAUTH_CLIENT_SECRET` is the secret key for the Google OAuth service

The first three variables come from the AWS portal, and allow the application to store submitted images into the bucket. The latter two variables allow for the authentication service to go through Google OAuth, and can be acquired from the Google Cloud Platform under credentials.

When locally testing, navigating to localhost:3000 on your browser you should see the Web2D homepage. Note that the rspec testing suite uses mock versions of both of these services, so keys are not needed for the testing environment.

## Deploying the Code

To deploy the code on Heroku, connect the heroku webapp to the github. Then, hit manual deployment on the Deploy page. The Main branch should be used, as it is the most stable recent build of the application.

To fully use the website, it will have to be connected to a OAuth and S3bucket. The respective keys for each service, and any other needed environmental variables, will need to be put within the config variables page in the heroku settings page.

## CI/CD Process

Currently, the CI process for this app is running these three tests:

  `rspec` for unit and integration testing
  
  `brakeman` for integrity scans
  
  `rubocop` for a linter
  
In terms of the CD process, the two current apps, staging and production, are connected to the branches dev and main respectively. Staging automatically deploys the newest dev commit, no matter on if the CI passed. Production will only automatically deploy the main branch if it is passing the CI.

Currently, all tests are disabled on the main and dev branches due to a conflict between rspec and bootstrap's ajax. All tests have recently passed on the no-bootstrap branch.

Staging: https://web2d-staging.herokuapp.com/
Production: https://web2d.herokuapp.com/
