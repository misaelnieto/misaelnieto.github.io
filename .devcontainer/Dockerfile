ARG VARIANT="3"
FROM mcr.microsoft.com/devcontainers/ruby:3

# Install system dependencies required by Jekyll builds and image processing
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    imagemagick \
    nodejs \
    npm \
    build-essential \
    git \
    curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Ensure bundler is installed/up-to-date
RUN gem install bundler --no-document

ENV BUNDLE_PATH=/workspaces/.bundle

WORKDIR /workspaces
