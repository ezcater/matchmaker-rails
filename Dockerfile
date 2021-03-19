FROM ezcater-production.jfrog.io/ruby:ec8b951224

ARG SKIP_REQUIRED_ENV_VAR_ENFORCEMENT=true
COPY Gemfile Gemfile.lock /usr/src/app/
ARG BUNDLE_EZCATER__JFROG__IO
RUN bundle install --without test development staging
ADD . /usr/src/app
RUN RAILS_ENV=production SECRET_KEY_BASE=fakekeybase bundle exec rails assets:precompile
EXPOSE 23008
CMD ["rails", "server", "-p", "23008", "-b", "0.0.0.0"]
