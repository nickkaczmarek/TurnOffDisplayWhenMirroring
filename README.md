# TurnOffDisplayWhenMirroring

A small utility that checks if you have an external display connected and if you are currently mirroring. If both of these are true, it uses [brightness](https://github.com/nriley/brightness) to set your display brightness to 0.

You'll need to `brew install brightness` and then symlink that to `/usr/local/bin` for TurnOffDisplayWhenMirroring to work out of the box.

I'd like to remove the need for `brightness`, but don't yet know how to integrate that code into this utility.

I have this set up in [Keyboard Maestro](http://keyboardmaestro.com/) to run on login and/or system wake so when I login to my computer, it shuts the built-in display off.

### Usage

#### Turn the display completely off
`TurnOffDisplayWhenMirroring 0`

#### Turn the display to full brightness
`TurnOffDisplayWhenMirroring 1`
