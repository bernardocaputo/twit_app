<strong>Twit App</strong>

This app has the purpose of being a twitter clone reproducing its features and serving as a study for me.

Technology:

Rails
Docker
Devise
Rspec
PostgreSQL
Materialize
NginX
docker-machine

1. Clone the project

git clone git@github.com:bernardocaputo/twit_app.git

2.Installing:

1. cd twit_app
1. docker-compose build
2. docker-compose run --rm app bundle exec rake db:create db:migrate
3. docker-compose up
