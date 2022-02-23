# README

## Getting Started

- Clone the repo on your local machine:

`git clone https://github.com/joniguerrero/2VD-Project.git`

- Make sure docker is running in the background and pull the latest version of the container we worked with in lab:

`docker pull dmartinez05/ruby_rails_postgresql:latest`

- Navigate to the directory you just cloned and run the command for Windows/Mac:

  - for Windows:

    `docker run --rm -it --volume "${PWD}:/webapp_2vd" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000`

  - for Mac:

    `docker run --rm -it --volume "$(pwd):/webapp_2vd" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000`

  - for Mac M1
    `docker run --rm -it --volume "$(pwd):/webapp_2vd" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 --platform linux/amd64 dmartinez05/ruby_rails_postgresql:latest`

- Now run the following commands:

  `bundle install`

  `rails webpacker:install`

  `rails db:create`

  `rails db:migrate`

- To run the app:

  `rails server -e dev --binding=0.0.0.0`

After Navigating to localhost:3000 on your browser you should see the 'Yay! You're on Rails' page.

## Useful Rails Commands

`rails scaffold`

`Keep on adding to this`

`rails g controller <route> <name>`

Staging: https://web2d-staging.herokuapp.com/
Production: https://web2d.herokuapp.com/
