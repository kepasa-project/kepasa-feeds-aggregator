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

# License

MIT LICENSE, see the LICENSE file for further information

# Brand Logo Licence 

The Kepasa logo designed by [José Luis Arraño] (https://www.facebook.com/joseluis.arrano) is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.

ciao!

[@Astr0surf3r] (https://twitter.com/Astr0surf3r)



