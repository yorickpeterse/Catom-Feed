# Catom Feed

An atom feed generator for <http://cat.yorickpeterse.com/>. This feed was
created to satisfy the people of \#forrst-chat (Freenode), a certain Australian
in particular.

## Requirements

* Ruby 1.9.2 or newer
* Some photos and videos of cats
* Not giving a fuck about what people will think of this

## Usage

Quite easy:

    $ ruby catom_feed.rb -p SOURCE DIRECTORY

This will spit out an Atom feed that you can then write to a file. Lazy way of
doing this:

    $ ruby catom_feed.rb -p SOURCE > feed.atom

## License

The code in this repository is licensed under the MIT license. A copy of this
license can be found in the file "LICENSE" in the root directory of this
repository.
