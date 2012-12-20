Coworfing [![Build Status](https://secure.travis-ci.org/nukomeet/coworfing.png)](http://travis-ci.org/nukomeet/coworfing)
=========

Coworfing is built by the coworking community to share the best places to work.

Depending on your skills and desire, you can find here different ways to participate. Check the *Menu* section below to find something to work
on, and then the *How to contribute* to get started with our code. 



New features are to be released regularly, follow us on twitter
[@coworfing](http://twitter.com/coworfing), [our blog](http://coworfing.tumblr.com/) and like [our facebook page](http://www.facebook.com/coworfing). Any doubt or question, tell us: coworfing@gmail.com. 

Happy contribution!

MENU: WHAT TO WORK ON?
----

**1. Report an issue**

You found a problem ?

Check first that you are the only one to have spotted it by
searching similar issues in the [issues list](https://github.com/nukomeet/coworfing/issues/283). If your issue is not listed, then create a bug report, with
at least an explicit title and a descriptive text, the part of code posing
problem, and (you'd be great) a unit test showing what goes wrong.

**2. Solve an issue**

Here is a list of the priority items to solve, click on the item to see the
corresponding issue, comment on the issue if you have any doubt or question. The
list is sorted per priority (first item is the most important).

- [Button "Edit place" on the place page](https://github.com/nukomeet/coworfing/issues/279) (public places can be edited by any logged
user)
- [Button "report this place"](https://github.com/nukomeet/coworfing/issues/280) (in order to merge double places)
- [Search by place name](https://github.com/nukomeet/coworfing/issues/285)
- [Search by tag](https://github.com/nukomeet/coworfing/issues/286)
- [When users makes a search on the map, clicks on a place, and goes back to the
map, he should see the map as the result of his
search](https://github.com/nukomeet/coworfing/issues/281) (current: taken back to
map of the world)
- [Insert the fields for signing in directly on the nav
  bar](https://github.com/nukomeet/coworfing/issues/282)
- [User should be able to browse places without going back to the
  list](https://github.com/nukomeet/coworfing/issues/283) (insert
arrows on right and left, like the picture gallery)
- [Sorting places per frequentation](https://github.com/nukomeet/coworfing/issues/224) (number of "I worked here") 
- [Display Linkedin skills on places] (based on "I worked here")
- [Opening times](https://github.com/nukomeet/coworfing/issues/223)

**3. Try and assess pending pull requests**

You can also try pending pull request that have been submitted to us to test
their validity.

**4. Propose new features**

Write to us before this (coworfing@gmail.com) as we are focusing now on solving
issues rather than introducing new features.

HOW TO CONTRIBUTE
-----------------

**1. Getting ready to contribute**

First you need to have a working rails development environment. Check the
[Contributing to Ruby on Rails](http://edgeguides.rubyonrails.org/contributing_to_ruby_on_rails.html page).

Be sure to have postgresql configured, as well as bundler, and of course git.

Then grab the code and deploy coworfing locally on your computer:

- Fork the coworfing repo on github

- Clone your fork :

    git clone https://github.com/xxxyourNamexxx/coworfing.git

- Get into your coworfing directory and run 
  
    bundle install 

- run 
    
    rake db:seed


Coworfing is now deployed locally on your computer !

**2. Submitting your changes**

If you feel like adding your stone to the collaborative coworfing cathedral,
please do so using a clear procedure :

- work on your cloned repo
- commit the changes you are happy with on your computer, with a short and clear
  comment for each commit
- Before pushing, be sure that you updated you cloned repo, changes might have
  occured while you were working:

  - create a remote

    git remote add coworfing https://github.com/nukomeet/coworfing.git
  
  - Get the changes
  
    git fetch coworfing
    
  - Get back on your branch and merge  

    git checkout master
    git merge coworfing/master
  
  - Update your repo on github

    git push origin master

Then you can issue a pull request. Be sure to comment precisely what your
request adds, to accompany it with all necessary tests. There is a chance that
other contributors or the mainteners suggest changes to your code before
accepting it. Please take it as a really good sign, it means your contribution
is potentially clever and interesting, and this is the way of the collaborative
revolution.

Now play with the code, play with the app, find the coolest places to coworf!

________________________

License: GPL 3, see the LICENSE file for more details.
