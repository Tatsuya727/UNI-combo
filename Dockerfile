FROM ruby:2.7.7

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /UNI-combo

WORKDIR /UNI-combo

COPY Gemfile /UNI-combo/Gemfile
COPY Gemfile.lock /UNI-combo/Gemfile.lock

RUN bundle install

COPY . /UNI-combo

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
