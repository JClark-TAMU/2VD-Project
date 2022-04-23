# README

## Introduction

Web2D is a organizational community event page and portfolio website for the TAMU organization 2VD. Members and alumni are able to create accounts, submit images of their artwork, and then put their artwork in community galleries and personal albums. Moreover, they are able to look at other members artwork. Officers are shown off on their own page. Information on how to use the application can be found on the website.

## Useful Rails Commands

`rails scaffold`

`Keep on adding to this`

`rails g controller <route> <name>`

## Executing the Code

- Clone the repo on your local machine:

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

After Navigating to localhost:3000 on your browser you should see the Web2D homepage.

## Deploying the Code

To deploy the code on Heroku, connect the heroku webapp to the github. Then, hit manual deployment on the Deploy page. The Main branch should be used, as it is the most stable recent build of the application.

To fully use the website, it will have to be connected to a OAuth and S3bucket. The respective keys for each service, and any other needed environmental variables, will need to be put within the config variables page in the heroku settings page.

## CI/CD Process

Currently, the CI process for this app is running these three tests:

  `rspec` for unit and integration testing
  
  `brakeman` for integrity scans
  
  `rubocop` for a linter
  
In terms of the CD process, the two current apps, staging and production, are connected to the branches dev and main respectively. Staging automatically deploys the newest dev commit, no matter on if the CI passed. Production will only automatically deploy the main branch if it is passing the CI.

Staging: https://web2d-staging.herokuapp.com/
Production: https://web2d.herokuapp.com/
