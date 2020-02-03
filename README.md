# RailOverflow

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/RailRunner166/rail-overflow/tree/master)

RailOverflow (we're looking for a better name) is a self-hosted, open-source alternative to StackOverflow.

## Ruby version
RailOverflow requires Ruby 2.7.0. The easiest way to use this is by using our Vagrantfile or using a service like Heroku

## System dependencies

You must have Postgresql installed to use this application. Install it on Ubuntu with:
```
$ sudo apt install postgresql
```

## Configuration
You must install all Ruby and JavaScript dependencies before running any database migrations and before running the web app. To do this, we use [Bundler](https://bundler.io/) and [Yarn](https://yarnpkg.com/getting-started/install). (click on the links to see install instructions for each) Once you have Bundler and Yarn, run these two commands in the app directory.
```
$ bundle install
$ yarn install
```

## Database creation
To create the necessary production database, run:
```
$ sudo -u postgres createdb railoverflow_production
```
> **Note:** If you are not running in production, substitute the word `production` for your Rails environment. (`development` or `test`)

## Database initialization
To initialize the database, you will have to migrate it. No population is needed.

To migrate the database, run:
```
$ RAILS_ENV=production rake db:migrate
```

<!-- * Services (job queues, cache servers, search engines, etc.) -->

## Deployment instructions

### Heroku

### Manual Deploy
Run it yourself, like this:
```
$ export PORT=3000 # can be any port you want, just make sure it is open and accessible to the user that will be running the application
$ export MODE="production" # can also be "development" or "test"
$ bundle exec puma -t 5:5 -p $PORT -e $MODE
```

> **Note:** The `-t 5:5` argument we sent to the `bundle exec puma` command represents the number of worker threads puma will spawn. You can set this to something else based on your system, but remember these two things:
> 
> - The more threads you create, the faster your application will run, but it will also use more memory.
> - Every system has a maximum amount of threads it can run at once. Be mindful of this as it will error if you somehow go over.

## Credits and License
### Credits:
- The logo was made by **JustMrRobBoss#2020** on Discord, here is [his Discord server](https://discord.gg/XYX3WPn).

### License:

This application is licensed under the permissive [MIT license](LICENSE).