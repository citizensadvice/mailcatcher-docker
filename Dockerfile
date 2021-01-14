FROM ruby:2.6.5-alpine3.11

ENV APP_ROOT /app

WORKDIR $APP_ROOT

ADD Gemfile* ./

RUN \
  apk update && apk upgrade && \
  apk --no-cache add \
    make \
    g++ \
    musl-dev \
    libstdc++ \
    sqlite-dev

RUN gem update --system && \
    gem install bundler && \
    bundle install

EXPOSE 1080 1025
CMD ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]
