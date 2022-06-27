FROM ruby:2.7.6-alpine3.16 AS builder

ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk --no-cache add make g++ musl-dev libstdc++ sqlite-dev

RUN bundle install && \
    rm -rf /usr/local/bundle/*/*/cache && \
    find /usr/local/bundle -name "*.c" -delete && \
    find /usr/local/bundle -name "*.o" -delete

#################################################

FROM ruby:2.7.6-alpine3.16

RUN apk add --update --no-cache sqlite-libs && rm -rf /var/cache/apk/*

ENV APP_ROOT /app
ENV RACK_ENV=production

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

RUN addgroup ruby -g 3000 && adduser -D -h /home/ruby -u 3000 -G ruby ruby

COPY . $APP_ROOT
WORKDIR $APP_ROOT

RUN chown -R ruby /app && chmod -R u-w /app
USER ruby

EXPOSE 1080 1025
CMD ["mailcatcher", "--smtp-ip=0.0.0.0", "--http-ip=0.0.0.0", "--foreground"]
