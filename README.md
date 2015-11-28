= Reactions

== Introduction

This is a small app that lets you and your team curate your own library of gifs and photos to insert into your conversations
similar to using the slashie command /giphy. It was originally made because it was more fun than studying for my law school finals.

== Take it for a Spin!
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

After you deploy to Heroku by clicking the button above, you must supply the proper ENV variables. It deploys with Heroku with dummy variables,
so you can find the keys under the app's config by logging into your Heroku dashboard.

== ENV variables to define:
The project uses Figaro, so you can define all of these in application.yml. You can use application.yml-sample as your guide.

Once you set the variables in application.yml, you can set them on Heroku en masse:
`figaro heroku:set -e production`



== Run it Locally
You'll need Postgresql running locally. I recommend this app: http://postgresapp.com/
