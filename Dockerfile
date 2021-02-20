FROM ruby:2.7.2-alpine
RUN apk add --no-cache build-base
RUN apk add --no-cache postgresql-dev
RUN apk add --no-cache tzdata
RUN apk add --no-cache bash
RUN rm -rf /var/cache/*/*
RUN echo "" > /root/.ash_history

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
ENV LC_ALL=en_US.UTF-8

WORKDIR /usr/app

RUN gem install bundler
COPY ["Gemfile", "Gemfile.lock", "./"]
RUN bundle config set --local without 'production'
RUN bundle install

COPY . .
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
