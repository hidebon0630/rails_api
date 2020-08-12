# Debianがベースのrubyイメージを指定
FROM ruby:2.7.1

# 必要なものをインストール
RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends build-essential \
  libpq-dev \
  nodejs \
  vim \
  yarn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# rails用のディレクトリを作成
RUN mkdir /rails_api
ENV APP_ROOT /rails_api
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
COPY . $APP_ROOT
