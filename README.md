# Reactions

## Introduction

This is a small app that lets your Slack team curate your own library of gifs and photos to insert into your conversations
similar to using the slashie command /giphy. It was originally made because it was more fun than studying for my law school finals.

## Who Will Like This
It assumes you have a team using Slack, and everyone on your team has a Google account. It uses Omniauth with the Login with Google strategy to handle authentication, but it's a simple matter to swap out Google for Facebook or another identity/authentication provider. Just change the config, initializer, and user-creation code.

It assumes that you've already got an Amazon S3 bucket setup where you can stash your images. http://aws.amazon.com/

## Take it for a Spin!

Collect these ENV variables then click the Deploy to Heroku button below. You'll be prompted for the variables then it will be live.
* google_client_id:
* google_client_secret:
* s3_key_id:
* s3_secret:
* s3_bucket_name:
* s3_region:
* admin_email:
* slack_team_token:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

If the postdeploy script on Heroku doesn't run, you'll need to run it manually:
`heroku run rake post_install_task`

The task is safe to run repeatedly.

## Clone and Deploy Yourself

1. Clone it locally
`$ git clone https://github.com/Grantimus9/slackreactions.git`

2. Define ENV vars
The project uses Figaro, so you can define all of the above ENV vars in application.yml. You can use application.yml-sample as your guide. To create config/application.yml, run this from the command line:
`$ bundle exec figaro install`

3. Deploy (Heroku instructions here)
Once you set the variables in application.yml, you can set them on Heroku en masse:
`$ figaro heroku:set -e production`

4. Post-Deploy:
Run `rake post_install_task` to make sure the Postgres add-on trigram is installed for the pg_search gem, which handles the searching of the gif inventory.

Note: The app will fail to even start if it's missing a required ENV var. Make sure you've defined them all.

## External Config:

1. Google's Authentication: Using Google's developer's console, add your app's URL as valid JS request origins and callback URIs for the OATH Authentication Flow.

2. S3: You will need to create an Amazon S3 Bucket by logging into your Amazon account and creating and S3 bucket. Make sure that the Amazon ID and Amazon Secret you are using correspond with an Amazon user that has a police of "S3 Full Read Write Access." This can be done using the Amazon IAM user management by creating a new user, assigning the policy to the user, and then getting that user's keys for this app.

3. Slack: You'll need to add a custom slash Command, such as "/r" so that when you type in "/r WOW" it will POST to this reactions app. Add a slash command here (and note the TOKEN): https://yourdomain.slack.com/services/new/slash-commands.

## How it works:

Your team visits the app you just setup, logs in, and can upload a gif or other image either from their computer or from a URL (`carrierwave` handles this). It's saved to your S3 Bucket, and the uploader can supply text keywords that they want to associate with that image.  

When someone invokes your /r command, Slack POSTs a payload to the /incoming route, handled by slack_controller#incoming. It uses the text field as the search term, and searches the Reaction model using the `pg_search` gem. If it finds several matches, it'll choose a random one from the set of matches and return it to Slack. If it finds no matches, it'll return a message only you can see that simply says no match. 
