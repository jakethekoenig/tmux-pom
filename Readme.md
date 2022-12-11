# Tmux Pomodoro Timer

Enables putting a pomodoro timer in Tmux `status-right` and `status-left`.

## Installation
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```shell
set -g @plugin 'jakethekoenig/tmux-pom'
```

Hit `prefix + I` to fetch the plugin and source it.

### Manual Installation
Clone the repo:

```shell
$ git clone https://github.com/jakethekoenig/tmux-pom ~/installation/path
```
Add this line to your `.tmux.conf`:

```shell
run-shell ~/installation/path/pom.tmux
```
Then reload your tmux environment.

## Usage

A pomodoro can be started or stopped with `prefix+P`. You should edit your `status-right` or `status-left` to make the timer visible. The following strings are available:

- `#{pom_timer}` - Counts down from `@pom_work_time` in the work time colors and then counts up to `@pom_break_time` in the break time colors.
- `#{poms_done}` - Counts the number of pomodoro timers that have been consecutively repeated. Resets on `prefix-P`.
- `#{poms_goal}` - The intended number of consecutive pomodoros.

If `poms_goal` is set to a positive integer then the timer will repeat for that many iterations. Otherwise it will repeat until manually stopped. 

A suggested example for adding the timer to your status bar is:
```shell
# in .tmux.conf
set -g status-right '#{pom_timer} #{poms_done}/#{poms_goal}'
```

To add the timer to your status bar put `#pom_timer` in the string you use to define it. You can now start and stop your pomodoro timer with `prefix+P`.

## Configuration

The extension has the following options with given default values.

```shell
- @pom_work_time "25"
- @pom_break_time "5"
- @pom_work_color_fg "green"
- @pom_work_color_fg "default"
- @pom_break_color_fg "black"
- @pom_break_color_fg "red"
- @pom_start_log_file "$TMUX_POM_DIR/data/pom_start_log.txt"
- @pom_minimum_to_count "20"
- @poms_goal "0"
```

## Logging

The extension automatically logs the start time of your pomodoros for future self analytics. You can change the file (`@pom_start_log_file`) the times are logged to and configure how long your pomodoro has to go to count (`@pom_minimum_to_count`. 

### Maintainer

- [Jake Koenig](https://github.com/jakethekoenig)

### License

[MIT](LICENSE.md)
