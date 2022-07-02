# Terminal
export TERMINAL='alacritty'
export TERM=xterm-256color

# Editors
export EDITOR="env TERM=xterm-24bit emacsclient -t -a emacs"
export VISUAL="$EDITOR"
export PAGER='nvimpager'
export MANPAGER="sh -c 'col -bx | nvimpager -p'"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Language
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8';

# Set GPG TTY
# If gnupg2 and gpg-agent 2.x are used, be sure to set the environment variable GPG_TTY.
export GPG_TTY=$(tty)

# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=linkhandler

# Appearance/HighDPI configuration
export QT_QPA_PLATFORMTHEME=qt5ct
export GDK_DPI_SCALE=0.5
export GDK_SCALE=2
export ELM_SCALE=2
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export XCURSOR_PATH=$RUNTIME/usr/share/icons
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_CSD=0

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"

export GOPATH="$HOME/go"

# Add `~/.local/bin` and $GEM_HOME to the `$PATH`
export PATH="$HOME/.local/bin:$GEM_HOME/bin:$GOPATH/bin:$HOME/.emacs.d/bin:$PATH";

# NNN file manager configuration
export NNN_BMS='p:~/projects;d:~/downloads/'
export NNN_SSHFS="sshfs -o follow_symlinks"        # make sshfs follow symlinks on the remote
export NNN_COLORS="2136"                           # use a different color for each context
export NNN_TRASH=1                                 # trash (needs trash-cli) instead of delete

# Enable new docker build system for docker and docker-compose
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Configure default fzf (fuzzy-finder) command
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --follow -g '!{.git,node_modules,tmp,build,downloads}/*'"

# Set ssh agent vars
SSH_AGENT_PID=""
SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
