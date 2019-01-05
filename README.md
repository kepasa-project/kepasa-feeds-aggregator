# Kepasa-FAOSS: Kepasa-Feed Aggregator Open Source Software 

### A social feeds RSS aggregator network to share the last news with your fellows

do you want install [Kepasa.co] (http://www.kepasa.co) and use it in dev mode follow these steps (recommend using in dev and production [Postgresql] (http://www.postgresguide.com/))

before to install the web app in your local machine install the 

- Ruby version (2.4.1)
- Redis Server  

To install Ruby in a Unix-Like Machine (Ubuntu) you can use [RVM] (https://rvm.io/rvm/install)
To install Ruby in a Windows or MAC OSX Machine you can use [Rails Installer] (https://rvm.io/rvm/install)

to install [redis server] (http://redis.io/download)

When you have installed all this stuff 

```sh
$ git clone https://github.com/kepasa-project/kepasa-feeds-aggregator.git
$ cd kepasa-feeds-aggregator
$ cd .
```

```sh
In the kepasa-feeds-aggregator/config/ directory you have to rename

application-example.yml	
database-sqlite3-example.yml (if you want use sqlite)
secrets-example.yml

with

application.yml	
database.yml
secrets.yml

after that launch the follow command

$ bundle
$ rake db:setup (this create the database and tables)
$ rake db:seed (this create the first USER and the first FEED)
```

```sh
$ gem install bundler --no-rdoc --no-ri
$ bundle
$ rake db:setup
```

```sh
$ foreman start
```

```sh
If everything is ok you can go to localhost:5200 click in 'Login' and insert the following parameters

email: 'reader@kepasa.mx'
password: 'password'

and now you are in in your local copy of KEPASA

```

What you can do with Kepasa.co?

- add your own feed RSS 
- add your favourite new to your bookmark 
- follow feed RSS and other user
- add tags to the feeds

What is missing in Kepasa.co?

- a TDD system

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