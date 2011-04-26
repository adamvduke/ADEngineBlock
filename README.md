Purpose:
--------

The hope for ADEngineBlock is to support the full Twitter API and provide Authorization
through OAuth. The major difference between ADEngineBlock and most of the other TwitterEngine
solutions that I've come across is that EngineBlock will use Objective-C blocks as the callbacks
for your Twitter API invocations. This should hopefully solve a lot of threading issues, along with
making your code less verbose.

Submodules:
-----------------

ADEngineBlock depends on a number of other projects/source which have been set up as git submodules.

The steps to get all of the source to build ADEngineBlock are:

     git clone git://github.com/adamvduke/ADEngineBlock.git
     cd ADEngineBlock
     git submodule init
     git submodule update

The submodules will be their own git repositories in the directory ADEngineBlock/External/.

In order to build ADEngineBlockDemo, one of the submodules, ADOAuthorizeiOS, has it's own submodule that needs to be initialized.

     cd ADEngineBlockDemo/External/ADOAuthorizeiOS
     git submodule init
     git submodule update

Third party dependencies:
-----------------

* [json-framework](https://github.com/stig/json-framework) by [Stig Brautaset](https://github.com/stig)
* OAuthConsumer by Jon Crosby
* [Seriously](https://github.com/probablycorey/seriously) by [Corey Johnson](https://github.com/probablycorey)

Credits:
--------
ADEngineBlock includes ideas/code from

* [MGTwitterEngine](https://github.com/mattgemmell/MGTwitterEngine) by [Matt Gemmell](https://github.com/mattgemmell)
* [Twitter-OAuth-iPhone](https://github.com/bengottlieb/Twitter-OAuth-iPhone) by [Ben Gottlieb](https://github.com/bengottlieb)