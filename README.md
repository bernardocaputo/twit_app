![rails](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)
![rails](https://img.shields.io/badge/Rails-5.0.1-red.svg)
![ruby](https://img.shields.io/badge/Ruby-2.4.0-red.svg)

# Twit App

This app has the purpose of being a twitter clone reproducing its features and serving as a study for me.

## Technology:

- [Rails](http://rubyonrails.org/)
- [Docker](https://docs.docker.com/)
- [Devise](https://rubygems.org/gems/devise/versions/4.2.0)
- [Rspec](http://http://rspec.info/)
- [Factory Girl](https://github.com/thoughtbot/factory_girl)
- [PostgreSQL](https://www.postgresql.org/)
- [Materialize](http://materializecss.com/)
- [Nginx](https://codeship.com/)
- [Docker-machine](https://docs.docker.com/machine/)

## 1. Clone the project
```cmd
git clone git@github.com:bernardocaputo/twit_app.git
```
## 2. Installing:
```cmd
cd twit_app
docker-compose build
docker-compose run --rm app bundle exec rake db:create db:migrate
docker-compose up
```

## 3. Testing:
```cmd
docker-compose run --rm app bundle exec rspec 
```
