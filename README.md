== README

# Kudos
This repo includes code for a very basic app for users to send 'kudos' to others in their organization. 

# Requirements
Every week, each user receives three kudos to give to other users within their organization.  Kudos do not accumulate: if a user doesn't give out their kudos, they do not get 6 to give out next week, only 3.

* Users should be able to give kudos to other users.
* Users can see who has given them kudos.
* The primary call to action should be to give away your kudos.
* You should also be able to tell who you're currently logged in as, and which organization you're associated with.
* When a kudo is given, the user giving the kudo should be able to include a message about why they're giving it.
* You don't need to build a way to CRUD organizations or users, but provide way to generate some fixture/demo data.  The generated data should include some users giving others kudos, and should not be the same every time (different messages, times, users, and amounts of kudos given).
* Authentication and login can be as simple as you can make them.  You won't be penalized if you, for example, store plaintext passwords.
* You can use Ruby 1.9.3, 2.0.0, or 2.1.3 and Rails 3 or 4, whatever you're most comfortable with.  Just include a .ruby-version file so we know which Ruby to use.

# Setup
(Note: This app uses PostgreSQL for its database.) Run `rake db:setup` to create the database, load the schema, and populate it with some sample users and kudos. The task output includes a list of test users that you can use to log into the app. The password for all test users is 'password'.

# Testing
Run `rspec spec/` to run all tests.
