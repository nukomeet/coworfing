Coworfing
=========

WHAT IS IT ABOUT ?!
-------------------

Welcome into the coworfing source code !

Want to discover cool places to work? Tired of working alone from home, of
queueing hours in front of a library?

Coworfing displays a map with the best places to work, provides the contact to get
there and helps building the collaborative working community. New features are to be released regularly, follow us on twitter
[@coworfing](http://twitter.com/coworfing), [our blog](http://coworfing.tumblr.com/) and like [our facebook page](http://www.facebook.com/coworfing)

Coworfing is made by you, the users, the coworfer community, and also by you,
contributers to the code. Depending on your skills and desire to participate in
the collaborative revolution through Coworfing development, here are different
ways by which you can help !

HOW TO CONTRIBUTE
-----------------

1. Reporting an issue

As Coworfing code is hosted on github, we use their issue tracking tool. You
found a problem ? Check first that you are the only one to have spotted it by
searching similar issues in the issues list. No ? Then create a bug report, with
at least an explicit title and a descriptive text, the part of code posing
problem, and (you'd be great) a unit test showing what goes wrong.

2. Getting ready to contribute

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

3. Help resolve an open issue

Check the issue list https://github.com/nukomeet/coworfing/issues?state=open

You can try to reproduce a bug report, leaving a comment to say you have the
same problem, you can also precise a fairly vague report, you can add a test
showing how things go wrong (pretty useful).

You can also try pending pull request that have been submitted to us to test
their validity.

If you feel like adding your stone to the collaborative coworfing cathedral,
please do so using a clear procedure :

- work on you cloned repo
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
