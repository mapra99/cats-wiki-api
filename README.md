# Cats Wiki API

> Get, search for information about cat breeds. If you love cats, you got to the right place :)

![screenshot](https://raw.githubusercontent.com/mapra99/cats-wiki/master/docs/mockup.png)

In the cats wiki you can learn many things about all kinds of cats. You can search for cat breeds, see some daily top breeds and get amazed with lots of cute photos.

This is the backend component of the cats wiki project. You can find the [web app here](https://github.com/mapra99/cats-wiki)

## Built With

- Ruby on Rails 5
- PostgreSQL
- Redis as caching backend
- RSpec for testing framework

For some services this backend consumes data from a 3rd party [Cat API](https://thecatapi.com/)

## Live Demo

[Live Demo Link](https://cats-wiki.herokuapp.com/)

## Getting Started

To get a local copy up and running follow these simple example steps.

### Setup

First of all, clone this repo in your local environment and cd to the project's folder
```
git clone git@github.com:mapra99/cats-wiki-api.git
cd cats-wiki-api
```
Then follow the next steps for a docker or manual setup.

#### Docker Setup **[recommended]**

##### Prerequisites

- Docker
- Docker Compose
- You may want to use Postman or curl to play with the API.

##### Installation
Run the following commands:
```
docker-compose build
docker-compose up -d
docker-compose exec rails db:create db:migrate
```

Alternativelly, you can run the following script:
```
./bin/docker/setup
```
#### Manual Setup

##### Prerequisites

- Ruby 2.7.2 is required. If you're using rbenv you may need to `rbenv install 2.7.2`
- Bundler for ruby package management. You may install it with `gem install bundler -v '2.1.4'`
- PostgreSQL
- Redis is optional for a development environment.
- You may want to use Postman or curl to play with the API.

##### Installation

1. Install the project dependencies
```
bundle install
```
2. Create a postgres username with password, and add those credentials in your `.env` file:
```
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=mypassword123
```

3. Create the database and run the migrations
```
rails db:create
rails db:migrate
```

3. On production this project uses redis for caching, but in development caching is disabled. If you want to enable it, you can either choose to use redis or local memory storage as caching backend.

- To use local memory storage, run this:
```
rails dev:cache
```

- To use Redis, add a `REDISCLOUD_URL` variable in your `.env` file with the URL where your redis instance is running. Probably something like this:
```
REDISCLOUD_URL=redis://localhost:6379
```

4. Start the server
```
rails server
```
### 3rd Party Services

#### Cat API
This app consumes data for some services from this [Cat API](https://thecatapi.com/). To get these services running, you need to go there and request an API key, then add it in a `.env` file like this:
```
CATS_API_BASE_URL=https://api.thecatapi.com/v1
CATS_API_KEY=your-key
```
### CORS Policy

On development, the backend will only accept requests from another localhost port instance if sent from a browser, otherwise the request will fail due to the current CORS Policy

### Usage

This project is a backend API. Following the setup steps, you'll get the API running at http://localhost:3000. You may want to use Postman or curl to have a playground with the API, or you may want to check out [our frontend project](https://github.com/mapra99/cats-wiki) and [it's live version](https://cats-wiki.vercel.app/).

Feel free to visit the [API docs here](https://documenter.getpostman.com/view/10455715/TVmJhyoV).

### Run tests

We are using RSpec as testing framework. To check the tests do the following:
If you have a docker setup, run:
```
docker-compose exec backend bundle exec rspec
```
If you have a manual setup, run:
```
bundle exec rspec
```
Also, you can enable guard to watch the project files and continuouslt run the specs on any detected change.
```
bundle exec guard
```

This repository has GitHub Actions enabled to run the specs before merging any PR. If you are contributing, make sure that the specs are passing locally on your end :).

## Authors

**Miguel Prada**

- GitHub: [@mapra99](https://github.com/mapra99)
- LinkedIn: [/in/mprada/](https://www.linkedin.com/in/mprada/?locale=en_US)

## Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to devchallenges.io for their design

## License

This project is [MIT](lic.url) licensed.
