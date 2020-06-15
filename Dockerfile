FROM ruby:2.4

RUN mkdir -p /bankingapp
WORKDIR /bankingapp

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY ./Gemfile /bankingapp

RUN gem install rake
RUN bundle install --path vendor/cache
Add ./ /bankingapp

