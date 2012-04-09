HostingStack Screenshot Service
===============================

Setup
-----

    git submodule init
    git submodule update
    bundle install --binstubs --path=bundled
    rackup # Just kidding, Nginx for production setups.

Daemontools service config is in services/.

Requirements
------------

Xvfb. Ruby 1.9.

python-qt4 libqt4-webkit for webkit2png.

timeout (from GNU coreutils).


Modus operandi
--------------

Request to

/screenshot?url=http://example.org/&timestamp=2342

Returns either cached copy from /cache if urlhash and timestamp matches or creates a new screenshot and returns that.


TODO
----

Cache cleaning!


Legalese
--------

Copyright 2011, 2012 Efficient Cloud Ltd.

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
