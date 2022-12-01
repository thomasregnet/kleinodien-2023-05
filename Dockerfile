FROM ruby:3.1.3-bullseye

RUN apt-get update \
  && apt-get -y install curl \
  && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
  &&  apt-get update \
	&& apt-get install -y --no-install-recommends \
    nodejs \
		postgresql-client \
    yarn \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
