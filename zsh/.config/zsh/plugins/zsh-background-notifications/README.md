zsh-background-notifications
============================

Cross-platform background notifications for long running commands! Supports OSX and Linux.

![OS X Screenshot](screenshots/osx.png)

Do you use `oh-my-zsh`?
-----------------------

RobbyRussel [merged](https://github.com/robbyrussell/oh-my-zsh/pull/3301) (and [tweeted](https://twitter.com/ohmyzsh/status/569566134984265729) about it) this plugin to the main-line oh-my-zsh. If that's what you're running then just add 'bgnotify' to your `.zshrc` plugins list and you're all set!

Do you use `Prezto`?
--------------------

I do too! [Prezto](https://github.com/sorin-ionescu/prezto) rocks-- and works great with bg-notify! (although there's no included plugin (yet?)).

Usage
-----

```sh
$ git clone http://0x49.0x2a.xyz/RobertAudi/zsh-background-notifications.git $HOME/.zsh/zsh-background-notifications
$ echo 'source $HOME/.zsh/zsh-background-notifications/zsh-background-notifications.plugin.zsh' >> $HOME/.zshrc
$ source $HOME/.zsh/zsh-background-notifications/zsh-background-notifications.plugin.zsh
```

Requirements:
-------------

### OS X

- [terminal-notifer](https://github.com/alloy/terminal-notifier)

```sh
$ brew install terminal-notifier
```

Or:

```sh
$ gem install terminal-notifier
```

### Lnux

- `notify-send`

#### Arch Linux

```sh
$ sudo pacman -S libnotify
```

### Windows

Install Linux or get a Mac.

Screenshots
-----------

### Linux

![Linux screenshot](screenshots/linux.png)

### OS X

![OS X Screenshot](screenshots/osx.png)

Configuration
-------------

One can configure a few things:

- `BG_NOTIFICATIONS_THRESHOLD`: Sets the notification threshold time (default: 10 seconds)
- `send-formatted-bg-notification`: Function that lets you change the notification
- `bg-notifications-ignored-command`: Function to ignore notifications for a specific command (default: `$EDITOR` and `$PAGER`)

Use these by adding a function definition before sourcing the plugin.

### Example:

```sh
# Set your own notification threshold
export BG_NOTIFICATIONS_THRESHOLD=15

# args: $1=exit_status, $2=command, $3=elapsed_time
send-formatted-bg-notification() {
  [ $1 -eq 0 ] && title="Holy Smokes Batman!" || title="Holy Graf Zeppelin!"
  bg-notifications-notify "$title -- after $3 s" "$2";
}

source $HOME/.zsh/zsh-background-notify/bg-notifications.plugin.zsh

# Custom ignores must be declared after sourcing!
# Ignore notifications for specific commands
bg-notifications-ignored-command "ping"
bg-notifications-ignored-command "find"
```

How it works
------------

In zsh you can add a user-hook `preexec` that runs before executing a command and `precmd` that runs just before re-prompting. Timing the difference between them gives you execution time!

To check if you're in the background we can use xprop to find the NET_ACTIVE_WINDOW in Linux and osascript to run a simple apple script to get the same thing (although slower).

Credits
-------

Original codebase:

- [zsh-background-notify](https://github.com/t413/zsh-background-notify)

Alternatives:
-------------

I like linking.. So here are a few similar alternatives to this script. Most are platform-specific and buggy in some way. (Sure is great to use one script on all of your systems!)

- This [reddit post](http://www.reddit.com/r/linux/comments/1pooe6/zsh_tip_notify_after_long_processes/)
- [zsh-notify](https://github.com/marzocchi/zsh-notify) plugin for Mac OS X
- [dotzsh notify](https://github.com/dotphiles/dotzsh/tree/master/modules/notify)
- [zbell](https://gist.github.com/jpouellet/5278239)
