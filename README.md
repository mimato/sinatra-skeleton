# Sinatra Hello

This is a hello world app in Sinatra with the basics for development:
 - Sinatra (obviously)
 - ActiveRecord
 - RuboCop
 - Guard
 - Rake

## Development
Set up for development using docker.

    ```
    docker-compose build
    docker-compose run web bundle exec rake db:create
    docker-compose run web
    ```

When you run ```docker-compose run web```, it will run guard, and guard will run rack, and your tests and RuboCop will run on each save.

To run other arbitrary commands (rake, etc) just run ```docker-compose run web <command>```

## Configuration

Database config is in config/database.yml
Application config is in config/config.yml
