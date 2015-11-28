= Reactions

== Introduction

This is a small app that lets you and your team curate your own library of gifs and photos to insert into your conversations
similar to using the slashie command /giphy. It was originally made because it was more fun than studying for my law school finals.

== Take it for a Spin!
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

After you deploy to Heroku by clicking the button above, you will be prompted for the following ENV variables:
google_client_id:
google_client_secret:
s3_key_id:
s3_secret:
s3_bucket_name:
s3_region:
admin_email:

== ENV variables to define:
The project uses Figaro, so you can define all of these in application.yml. You can use application.yml-sample as your guide.
Once you set the variables in application.yml, you can set them on Heroku en masse:
`figaro heroku:set -e production`

==External Config:

1. Google's Authentication: Using Google's developer's console, add your app's URL as valid JS requests and callback URIs for the OATH Authentication Flow.

2. S3: You will need to create an Amazon S3 Bucket by logging into your Amazon account and creating and S3 bucket. Make sure that the Amazon ID and Amazon Secret you are using correspond with an Amazon user that has a police of "S3 Full Read Write Access." This can be done using the Amazon IAM user management by creating a new user, assigning the policy to the user, and then getting that user's keys for this app.

3. Slack: You'll need to add a custom slash Command, such as "/r" so that when you type in "/r WOW" it will POST to this reactions app. Check out https://api.slack.com/slash-commands for a well-written explanation.


== Run it Locally
You'll need Postgresql running locally. I recommend this app: http://postgresapp.com/
