Bundler
-------

By default, Bundler's configuration is in `~/.bundle/config`, but the location of the configuration files [can be customized using environment variables](https://bundler.io/whats_new.html#bundler-home-plugin-cache-and-config-environment-variables), and that's exactly what I did.

The environment variables are set from the [Ruby zsh plugin](./.zsh/plugins/ruby/init.zsh#L4-L7) and the configuration now respects  the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) and can be found under [`$XDG_CONFIG_HOME/bundler`](./.config/bundler).
