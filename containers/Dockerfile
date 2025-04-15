FROM ruby:3.4.2
RUN apt-get update -qq && apt-get install -y build-essential

# Setting environment variables
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_APP_CONFIG=/usr/local/bundle \
    GEM_HOME=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    PATH=/usr/local/bundle/bin:$PATH \
    API_ROOT=/app

# Create work directory
RUN mkdir $API_ROOT
WORKDIR $API_ROOT

COPY Gemfile Gemfile.lock $API_ROOT

# Run entrypoint.sh
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
