Sinpuncher
================================

Welcome to Sinpuncher! Sinpuncher is a Restful JSON API web app that makes building web pages easy.

Requirements
------------
- Sinatra
- MongoDB 1.8+
- Redis 2.4+
- git
- ssh

Setup
-----

To setup Facepuncher:

    git clone git@github.com:bigfuel/sinpuncher.git
    cd sinpuncher
    bundle

Rename config files:

    mv config.yml.example config.yml
    mv mongoid.yml.example mongoid.yml

Modify the configuration files to match your environment.

Setup the database:

    rake db:setup

Start the applicaiton:

    foreman start

Project repositories
--------------------

Facepuncher supports both `https` and `git` protocols for project repositories. The `https` protocol may require a username and password if it's a private repository, or if there's http authentication on top of the repo:

    https://username:password@github.com/bigfuel/example_private_repo.git

At Big Fuel we have private repositories on Github and Bit Bucket. What we do is create a deploy specific read-only account and we reference that in repository urls.

If you must use the `git` protocol, then you must install an SSH key and a known_hosts file with the host fingerprint of the repository's host. Add these to `vendor/support/.ssh` and they will be copied to your production environment upon deployment.
