# KEPASA (ALPHA version)

### A FEEDS RSS Web App Aggregator stay tuned for News, Blog

Do you want install [Kepasa.co](http://www.kepasa.co) and use it in dev mode follow these steps (recommend using in dev and production [Postgresql](http://www.postgresguide.com/))

before to install the web app in your local machine install the 

- **Ruby** (2.5.1)
- **Rails** (5.2.0)
- **Redis** (4.0.2)

To install **Ruby** in a Unix-Like Machine (e.g.: Ubuntu) you can use [RVM](https://rvm.io/rvm/install).
If you have a Windows or MAC OSX Machine to install **Ruby** you can use [Rails Installer](https://rvm.io/rvm/install).
**Rails** (also known as **Ruby On Rails**) is included in the installation of **RVM** or **Rails Installer**.
For **Redis** a NoSQL Database click [here](http://redis.io/download)

When you have installed all this stuff from your local machine terminal

```sh
$ git clone https://github.com/kepasa-project/kepasa-feeds-aggregator.git
$ cd kepasa-feeds-aggregator
$ cd .
```

```sh

In the kepasa-feeds-aggregator/config/ directory you have to rename

application-example.yml	
database-sqlite3-example.yml (if you want use **sqlite3**)
secrets-example.yml

with

application.yml	
database.yml
secrets.yml

```
## .yml examples files

### application.yml

```sh
DOMAIN: www.kepasa.mx
ENAIL_ADDRESS: reader@kepasa.mx
GMAIL_USERNAME: your_google_email@gmail.com
GMAIL_PASSWORD: your_google_password
SECRET_KEY_BASE: 66a353b3dc7b23582c9da470677bb941ef6bd07a59a576ef3e78a03532a2a0f0b7b0b44a910289288bfebf6328dc3754f1d80cfaa10f1f64b6e16bfeafc8989e [^1]

[^1]: YOU CAN CHANGE the SECRET_KEY_BASE launch from the the root app $ rake test
```

### database.yml

```sh
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: db/development.sqlite3

test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  database: db/production.sqlite3
```

### secrets.yml

```sh
development: <%= ENV["SECRET_KEY_BASE"] %>

test:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

```sh
after that launch the follow commands

$ gem install bundler --no-rdoc --no-ri
$ bundle
$ rake db:setup

```

```sh
$ foreman start
```

```sh

If everything it's ok you can go to localhost:3000 click in 'Login' and insert the following parameters

email: 'reader@kepasa.mx'
password: 'password'

and now you are in in your local copy of **KEPASA**

```
---
$ gem update --system
---
What you can do with **KEPASA**?

- add your own feed RSS 
- add your favourite new to your bookmark 
- follow feed RSS and other user
- add tags to the feeds

What is missing in ***KEPASA**?

- a TDD system

# Contributing

 If you want contribute as developer or simply find a bug are welcome on GitHub at [https://github.com/kepasa-project/kepasa-feeds-aggregator](https://github.com/kepasa-project/kepasa-feeds-aggregator) I found a nice how-to here:

https://akrabat.com/the-beginners-guide-to-contributing-to-a-github-project/ 

# Donation

if you want support the project you can send a donation to any of the following cryptocurrencies addresses:

```sh
BITCOIN: 1ET3io4sXiDJ5GuGmF9UcYw6uHRxMUvfSD
ETHER: 0x33BCA6E4dfd6D650D9d1347c4fA375fe98A3C264
BITCOIN CASH: qq4hj20vyrgsm48tapvawtwssjst2mkn25rry0t0z8
```

# License

MIT LICENSE, see the LICENSE file for further information

# Brand Logo Licence 

The Kepasa logo designed by [José Luis Arraño](https://www.facebook.com/joseluis.arrano) is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.

ciao!

[@Astr0surf3r](https://twitter.com/Astr0surf3r)
