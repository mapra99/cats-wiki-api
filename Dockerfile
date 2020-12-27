FROM ruby:2.7.2-alpine
RUN apk add --no-cache build-base
RUN apk add --no-cache postgresql-dev
RUN apk add --no-cache tzdata

WORKDIR /usr/app
RUN gem install bundler
COPY ["Gemfile", "Gemfile.lock", "./"]
RUN bundle config set --local without 'production'
RUN bundle install

COPY . .
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
