Coworfing [![Build Status](https://secure.travis-ci.org/nukomeet/coworfing.png)](http://travis-ci.org/nukomeet/coworfing) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/nukomeet/coworfing)
=========

Coworfing is built by the coworking community to share the best places to work.

Depending on your skills and desires, there are different ways for you to participate. Check the *What To Work On?* section below to find something to help
with, and then the *How to contribute* to get started with our code.

New features are released regularly. Follow us on Twitter
[@coworfing](http://twitter.com/coworfing), [our blog](http://coworfing.tumblr.com/) and like [our Facebook page](http://www.facebook.com/coworfing). If you have any doubts or questions, let us know: coworfing@gmail.com.

Happy contribution!

#WHAT TO WORK ON?

##1. Report an issue

Found a problem?

First check that you are the only one to have spotted it by 
searching similar issues in the [issues list](https://github.com/nukomeet/coworfing/issues). If your issue is not listed, then create a bug report, with at least an explicit title and a descriptive text, the part of code posing a
problem, and (it would be great) a unit test showing what goes wrong.

##2. Solve an issue

Here is a list of the priorities to solve. Click on the item to see the
corresponding issue. Comment on the issue if you have any doubts or questions. The
list is sorted by priority (first item is the most important).

- [Button "Edit place" on the place page](https://github.com/nukomeet/coworfing/issues/279) (public places can be edited by any logged
user)
- [Button "report this place"](https://github.com/nukomeet/coworfing/issues/280) (in order to merge double places)
- [Search by place name](https://github.com/nukomeet/coworfing/issues/285)
- [Search by tag](https://github.com/nukomeet/coworfing/issues/286)
- [When users makes a search on the map, clicks on a place, and goes back to the
map, they should see the map as the result of their
search](https://github.com/nukomeet/coworfing/issues/281) (currently they are taken back to
a map of the world)
- [Insert the fields for signing in directly on the nav
  bar](https://github.com/nukomeet/coworfing/issues/282)
- [User should be able to browse places without going back to the
  list](https://github.com/nukomeet/coworfing/issues/283) (insert
arrows on right and left, like the picture gallery)
- [Sorting places per frequentation](https://github.com/nukomeet/coworfing/issues/224) (number of "I worked here")
- [Display LinkedIn skills on places](https://github.com/nukomeet/coworfing/issues/205) (based on "I worked here")
- [Opening times](https://github.com/nukomeet/coworfing/issues/223)

##3. Try and assess pending pull requests

You can also try pending pull request that have been submitted to us to test
their validity.

##4. Propose new features

Email us at coworfing@gmail.com before you propose a new feature as we are currently focusing on solving
issues rather than introducing new features.

#HOW TO CONTRIBUTE

##1. Getting ready to contribute

First, you'll need to have a working Rails development environment. Check the
[Contributing to Ruby on Rails](http://edgeguides.rubyonrails.org/contributing_to_ruby_on_rails.html) page.

Be sure to have PostgreSQL configured, as well as bundler, and of course Git.

Then grab the code and deploy coworfing locally on your computer:

- Fork the coworfing repo on GitHub

- Clone your fork:

        git clone https://github.com/xxxyourNamexxx/coworfing.git

- Get into your coworfing directory and run

        bundle install

- run

        rake db:seed


Coworfing is now deployed locally on your computer!

##2. Submitting your changes

If you feel like adding your stone to the collaborative coworfing cathedral,
please do so using a clear procedure:

- work on your cloned repo
- commit the changes you are happy with on your computer, with a short and clear
  comment for each commit
- Before pushing, be sure that you updated you cloned repo, changes might have
  occurred while you were working:

  - create a remote

            git remote add coworfing https://github.com/nukomeet/coworfing.git

  - Get the changes

            git fetch coworfing

  - Get back on your branch and merge

            git checkout master
            git merge coworfing/master

  - Update your repo on GitHub

            git push origin master

Then you can issue a pull request. Be sure to comment precisely what your
request adds, and accompany it with all necessary tests. There is a chance that
other contributors or the maintainers may suggest changes to your code before
accepting it. Please take it as a really good sign, it means your contribution
is potentially clever and interesting, and this is the way of the collaborative
revolution.

Now play with the code, play with the app, find the coolest places to coworf!

________________________

License: GPL 3. See the LICENSE file for more details.
