FROM ruby:3.2-slim

# Install system dependencies required for native Gem extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

# Install bundler
RUN gem install bundler

# Install gems
COPY Gemfile ./
RUN bundle install

# Expose ports for Jekyll server and Livereload
EXPOSE 4000
EXPOSE 35729

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling"]
