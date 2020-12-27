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

### Prerequisites

- Ruby 2.7.2 is required. If you're using rbenv you may need to `rbenv install 2.7.2`
- Bundler for ruby package management. You may install it with `gem install bundler`
- PostgreSQL
- Redis is optional for a development environment.
- Yoy may want to use Postman or curl to play with the API.

### Setup

1. Clone this repo in your local environment and cd to the project's folder
```
git clone git@github.com:mapra99/cats-wiki-api.git
cd cats-wiki-api
```
2. Install the project dependencies
```
bundle install
```
3. Create the database and run the migrations
```
rails db:create
rails db:migrate
```
4. Start the server
```
rails server
```

### 3rd Party Services and Env Variables

#### Cat API
This app consumes data for some services from this [Cat API](https://thecatapi.com/). To get these services running, you need to go there and request an API key, then add it in a `.env` file like this:
```
CATS_API_BASE_URL=https://api.thecatapi.com/v1
CATS_API_KEY=your-key
```

#### Caching and Redis
On production this project uses redis for caching, but in development caching is disabled. If you want to enable it, you can either choose to use redis or local memory storage as caching backend.

- To use local memory storage, run this:
```
rails dev:cache
```

- To use Redis, add a `REDISCLOUD_URL` variable in your `.env` file with the URL where your redis instance is running. Probably something like this:
```
REDISCLOUD_URL=redis://localhost:6379
```

And that's it :). You'll need to restart the server for changes to take effect.

#### CORS Policy

On development, the backend will only accept requests from another localhost port instance if sent from a browser, otherwise the request will fail because of the current CORS Policy

### Usage

This project is a backend API. Following the setup steps, you'll get the API running at http://localhost:3000. You may want to use Postman or curl to have a playground with the API, or you may want to check out [our frontend project](https://github.com/mapra99/cats-wiki) and [it's live version](https://cats-wiki.vercel.app/).

Feel free to visit the [API docs here](https://documenter.getpostman.com/view/10455715/TVmJhyoV).

### Run tests

We are using RSpec as testing framework. Run `bundle exec rspec spec` to check the tests, and explore the `spec/` dir to have a look at their code.

Also, this repository has GitHub Actions enabled to run the specs before merging any PR. If you are contributing, make sure that the specs are passing locally on your end :).

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
