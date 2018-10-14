# Kepasa-FAOSS: Kepasa-Feed Aggregator Open Source Software 

### A social feeds RSS aggregator network to share the last news with your fellows

do you want install [Kepasa.co] (http://www.kepasa.co) and use it in dev mode follow these steps (recommend using in dev and production as DB [Postgresql] (http://www.postgresguide.com/))

```sh
$ git clone https://github.com/kepasa-project/kepasa-feeds-aggregator.git
$ cd kepasa-feeds-aggregator
$ bundle
$ rake db:setup
```

before to launch the web app you have to launch 

- a redis server 
- sidekiq 
- crontab 

to install [redis server] (http://redis.io/download)

```sh
$ redis-server
$ bundle exec sidekiq
$ whenever --update-crontab 
$ rails s
```

What you can do with Kepasa.co?

- add your own feed RSS 
- add your favourite new to your bookmark 
- follow feed RSS and other user
- add tags to the feeds

What is missing in Kepasa.co?

- a TDD system
- a setting User system (hide my own feed RSS, can set if I can receive email when somebody follow me)
- notification system
- DM system

# Donation

if you want to support the project you can send a donation to any of the following cryptocurrencies addresses:

```sh
BITCOIN: 1ET3io4sXiDJ5GuGmF9UcYw6uHRxMUvfSD
ETHER: 0x33BCA6E4dfd6D650D9d1347c4fA375fe98A3C264
BITCOIN CASH: qq4hj20vyrgsm48tapvawtwssjst2mkn25rry0t0z8
```

# License

MIT LICENSE, see the LICENSE file for further information

# Brand Logo Licence 

The Kepasa logo designed by [José Luis Arraño] (https://www.facebook.com/joseluis.arrano) is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.

ciao!

[@Astr0surf3r] (https://twitter.com/Astr0surf3r)