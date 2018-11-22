## `remote`

Generate remote repository strings.

- GitHub: https://github.com/casey/remote

---

## `used-mem`

Print memory status for Mac OSX and Linux.

```console
$ used-mem
77.8%(6.2G/8.0G)

$ used-mem '#f%(#FG/#TG)'
22%(2G/8G)

$ used-mem 'Free: #.2f % (#.3F GB) | Used: #.2u % (#.3U GB) | Total: #.3T GB'
Free: 38.32 % (3.065 GB) | Used: 61.68 % (4.933 GB) | Total: 7.998 GB
```

### Usage

```
used-mem [Output format]
```

Default format:

- ``#.1u%(#.1UG/#.1TG)``

Format string:

- ``#f`` : Free memory(%).
- ``#u`` : Used memory(%).
- ``#F`` : Free memory(GB).
- ``#U`` : Used memory(GB).
- ``#T`` : Total memory(GB).

- GitHub: https://github.com/yonchu/used-mem

---

## Slack colors

Themes can be found on [Slack Themes](https://slackthemes.net/) website and must be saved under `$XDG_CONFIG_HOME/Slack/<theme>.colors`.

### Usage

1. Open Slack > Team Preferences > Sidebar Theme
2. Paste the contents of the `<theme>.colors` file into the "Custom Theme" field
