#
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{profile,prompt,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Enable some Bash features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * `globstar`, recursive globbing, e.g. `echo **/*.txt`
# * `nocaseglob`, case-insensitive globbing (used in pathname expansion)
# * `cdspell`, autocorrect typos in path names when using `cd`
# * `histappend`, append to the Bash history file, rather than overwriting it
# * `checkwinsize`, checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS
# * `expand_aliases`, aliases are not expanded when the shell is not interactive, unless the expand_aliases shell option is set
for option in autocd globstar nocaseglob cdspell histappend checkwinsize expand_aliases; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "alacritty" killall;

# Completion with sudo
complete -cf sudo

# Anaconda specific configuration
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# FZF specific configuration
[ -f /usr/share/fzf/key-bindings.bash ] && source  /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
