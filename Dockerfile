FROM ruby:2.5.3

WORKDIR /app
ADD Gemfile* /app/

RUN bundle install -j3

EXPOSE 1080 1025
CMD ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]
