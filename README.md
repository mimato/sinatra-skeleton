# Sinatra Hello

This is a hello world app in Sinatra with the basics for development:
 - Sinatra (obviously)
 - ActiveRecord
 - RuboCop
 - Guard
 - Rake

## Development
    ```
    bundle install
    bundle exec rake db:create
    bundle exec guard
    ```

Guard will run rack, and your tests and RuboCop on each save.

## Configuration

Database config is in config/database.yml
Application config is in config/config.yml
