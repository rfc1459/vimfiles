~/.vim
======

Contents of my ~/.vim directory, take two.


Why did you start over?
-----------------------

Because there was so much cruft that I ended up nuking half the repo, so...


Vim
---

Personally, I recommend you use gVim on Windows and plain vim with a decent
terminal emulator everywhere else. xfce4-terminal is a good starting point.

You can download vim from:

 * (Linux) your favorite package manager
 * (Windows) [http://www.vim.org/download.php#pc](http://www.vim.org/download.php#pc)
   (gvim74.exe)


Usage
-----

Clone this repo into your home directory either as .vim (linux/mac) or
vimfiles (Windows). Such as:

    git clone git://github.com/rfc1459/vimfiles.git ~/.vim

Then 'cd' into the repo and run this to initialize the various submodules:

    git submodule init
    git submodule update

### Command-T Setup ###

[Command-T][] requires a working ruby installation, a C compiler, ruby
development files and a ruby-enabled version of Vim.

Provided your environment meets the requirements, cd into
~/.vim/bundle/command-t and run:

    rake make

to build Command-T.

### Activating the new configuration ###

After finishing setup, you should create a new `.vimrc` file in your home
directory that loads the pre-configured one that comes bundled in this
package. On Linux, a symbolic link will suffice:

    $ ln -s ~/.vim/vimrc .vimrc
    $ ln -s ~/.vim/gvimrc .gvimrc

On Windows, you should create a `_vimrc` and a `_gvimrc` in your profile's
home directory and add the following line inside:

\_vimrc:

    source ~/vimfiles/vimrc

\_gvimrc:

    source ~/vimfiles/gvimrc

#### Note ####

On Vim 7.4 or later you can safely skip the previous step altogether.


Help Tags
---------

At first usage of vim, type ":" while in command mode and then execute:

    call pathogen#helptags()

This will make the plugins documentation available upon :help


Dependencies
------------

You will need the following software on your system:

 * Ruby (plus its development files)
 * a working C compiler
 * Ncurses-term (in Linux only)

On Debian derivatives, for example, you will have to do:

    apt-get install build-essential ncurses-term ruby1.9-dev

replacing `ruby1.9-dev` with the appropriate Ruby version for your system.

As for Windows, you're on your own. Have fun.


Vim? WTF?
---------

Visit the following sites to learn more about Vim:

 * http://vimcasts.org

There are many sites teaching Vim, if you know of any other that are easy to
follow for newcomers, let me know.


Credits
-------

 * Letting me know that versioning ~/.vim was a good idea: @vjt
 * Inspiration for cleanup: @mislav
 * Vim demigod: @tpope

[Command-T]: https://wincent.com/products/command-t
