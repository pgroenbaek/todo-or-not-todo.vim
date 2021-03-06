================
Todo or not todo
================
A plugin for you to manage your TODOs, or NOT TODOs.

This project is still at an early development stage, many features are not customizable yet.

Ideas, issues and many other things are appreciated!


Installation
-------------
Use Vundle_

..  _Vundle: https://github.com/VundleVim/Vundle.vim


Key Mappings
-------------
These mappings should finally be customizable.

Customizable mappings:

* [normal][insert][visual] ``<C-c>``: switch between checkboxes.

  - Customize with ``g:todo_loop_checkbox``

* [normal][insert][visual] ``<Leader>b``: set current line a bulleted item, checkbox will be destroyed.

  - Customize with ``g:todo_set_bullet``

* [visual] ``<Leader>c``: colorize selected text with highlighter.

  - Customize with ``g:todo_highlighter``
  - The start marker and end marker of highlighter is also customizable

    ..  code-block:: vim

        let g:todo_highlighter_start = '⢝'
        let g:todo_highlighter_end = '⡢'

* [normal] ``<Leader>c``: erase highlighter of current line.

  - Customize with ``g:todo_highlighter``

Default mappings:

* [normal] ``>`` ``<``: increase and decrease indent
* [visual] ``>`` ``<``: increase and decrease indent of selected lines
* [normal] ``o``: open a new line with bullet
* [insert] ``<CR>``: create a new bulleted item in new line, same indent
* [normal] ``I``: insert text at logical line start
* [normal] ``^``: move cursor to line start smartly
* [normal] ``J``: join two lines, bullet or checkbox on next line will de destroyed
* [insert] ``<TAB>``, ``<S-TAB>``: if cursor is at line start, increase/decrease indent
* [insert] ``<C-d>``, ``<C-t>``: decrease/increase indent of current line

You can disable default mappings with ``let g:todo_default_mappings = 0``


Customizable Settings
----------------------

Checkboxes
````````````
Checkboxes are separated into two types ::

  [ ][v][x] [i][?][!]

These checkboxes are recognized by this plugin, i.e. they are colorized and can be switched with ``<C-c>``.

Depend on their type, ``<C-c>`` changes them in different way:

* If your cursor is on a bulleted item, press ``<C-c>`` makes that bullet a ``[ ]``
* If your cursor is on the same line with ``[ ]``, ``[v]`` or ``[x]``, ``<C-c>`` makes them the next one (round-robin)
* If your cursor is on the same line with ``[i]``, ``[?]`` or ``[!]``, ``<C-c>`` makes them a ``[ ]``

To add a checkbox, stick this into your vimrc:

..  code-block:: vim

    call todo#add#checkbox('[ ]', 'White')

This checkbox can be looped with ``<C-c>``.

To add a checkbox without participated in ``<C-c>`` loop, add a ``noloop`` as the third argument:

..  code-block:: vim

    call todo#add#checkbox('[i]', 'Yellow', 0)

Here is the default settings of this plugin:

..  code-block:: vim

    call todo#checkbox#add('[ ]', 'White', 'Todo')
    call todo#checkbox#add('[v]', 'Green', 'Done')
    call todo#checkbox#add('[x]', 'Red', 'Not todo')
    call todo#checkbox#add('[i]', 'Yellow', 'noloop', 'Doing')
    call todo#checkbox#add('[?]', 'Yellow', 'noloop', 'Not sure')
    call todo#checkbox#add('[!]', 'Red', 'noloop', 'Important')

And if you prefer to use unicode checkboxes:

..  code-block:: vim

    call todo#checkbox#clear()
    call todo#checkbox#add('☐', 'white')
    call todo#checkbox#add('☑', 'green')
    call todo#checkbox#add('☒', 'red')

The color strings are evaluated into argument ``ctermfg``, if you are new to vim, you can pick colors here:

* Black
* DarkBlue
* DarkGreen
* DarkCyan
* DarkRed
* DarkMagenta
* Brown, DarkYellow
* LightGray, LightGrey, Gray, Grey
* DarkGray, DarkGrey
* Blue, LightBlue
* Green, LightGreen
* Cyan, LightCyan
* Red, LightRed
* Magenta, LightMagenta
* Yellow, LightYellow
* White


File-specific checkboxes can be defined with modeline-like colon-separated string placed at the top of file ::

  # todo: [c]: cyan: Canceled
  # todo: [n]: cyan: noloop: Canceled

--------

For those who loves popup menu, this plugin also provides menu mode:

..  code-block:: vim

    let g:todo_select_checkbox = '<C-c>'

Under menu mode, all checkboxes can be selected, no matter they are added with no-loop option.

Menu mode and loop mode can be configured with different key mappings.


Bullets
`````````
Currently only one kind of bullets supported:

..  code-block:: vim

    let g:todo_bullet = '>'


Colors
````````
You can assign color of certain patterns:

..  code-block:: vim

    let g:todo_bullet_color = 'Cyan'
    let g:todo_url_color = 'Cyan'
    let g:todo_comment_prefix = '\v(^| )#'
    let g:todo_comment_color = 'Cyan'
    let g:todo_highlighter_color = 'Yellow'

Currently only foreground color setting supported, no underline or background color yet.


Screenshot
-----------
..  image:: screenshot.png


License
--------
This project is released under WTFPL Version 2.
See http://sam.zoy.org/wtfpl/COPYING.
