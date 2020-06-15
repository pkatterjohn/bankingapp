FROM ruby:2.4
ENV APP_HOME /rails-docker

#Installation of dependencies
Run apt-get update -qq \
 && apt-get install -y \
#needed for certain gems
  build-essential \
#needed for postgres gem
  libpq-dev \
  nodejs \
#following trims down the size of the image
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf \
  /var/lib/apt \
  /var/lib/dpkg \
  /var/lib/cache \
  /var/lib/log

#Create a directory for our application
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#Add gemfile and install gems
Add Gemfile* $APP_HOME/
RUN bundle install

#Copy over application code
Add . $APP_HOME

#Run out application
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:create db:migrate db:seed && bundle exec rails s -p ${PORT} -b '0.0.0.0'


