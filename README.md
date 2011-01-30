Purpose:
--------

The hope for EngineBlock is to support the full Twitter API and provide Authorization
through OAuth. The major difference between EngineBlock and most of the other TwitterEngine
solutions that I've come across is that EngineBlock will use Objective-C blocks as the callbacks
for your Twitter API invocations. This should hopefully solve a lot of threading issues, along with
making your code less verbose.

Building/Running:
-----------------

EngineBlock depends on the [json-framework](https://github.com/stig/json-framework) by [Stig Brautaset](https://github.com/stig), OAuthConsumer by Jon Crosby, and Seriously by Corey Johnson
To that end, I have forked the github repositories for those projects and included them as git submodules.
The steps to get up and running are:
     git clone git://github.com/adamvduke/EngineBlock.git
     cd EngineBlock
     git submodule init
     git submodule update

The submodules will be their own git repositories in the directories EngineBlock/External/
