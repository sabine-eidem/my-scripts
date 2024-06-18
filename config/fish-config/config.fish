# Enable vi key bindings
fish_vi_key_bindings

# Define the vi mode key bindings explicitly
function fish_user_key_bindings
    fish_vi_key_bindings
end

# Add custom greeting message with color
# Add custom greeting message with various dynamic information, including weather
# Add custom greeting message with various dynamic information, including weather
# Add custom greeting message with various dynamic information, including weather
function fish_greeting
    # Get various pieces of dynamic information
    set current_user (whoami)
    set current_dir (pwd)
    set my_hostname (hostname)
    set current_uptime (uptime -p)
    set ip_address (hostname -I | awk '{print $1}')
    set disk_usage (df -h / | tail -1 | awk '{print $5}')
    set cpu_load (cat /proc/loadavg | awk '{print $1, $2, $3}')
    set memory_usage (free -h | awk '/^Mem:/ {print $3 "/" $2}')
    set logged_in_users (who | wc -l)
    set background_jobs (jobs -p | wc -l)
    # Fetch weather data from wttr.in with a shorter format
    set weather (curl -s "wttr.in/?format=%C+%t")

    # Set color to green for borders
    set_color green
    echo '─────────────────────────────────────────────'
    # Set color to cyan for the dynamic welcome message
    set_color cyan
    echo "Welcome, $current_user!"
    echo "Hostname: $my_hostname"
    echo "System uptime: $current_uptime"
    echo "IP Address: $ip_address"
    echo "Disk Usage: $disk_usage"
    echo "CPU Load: $cpu_load"
    echo "Memory Usage: $memory_usage"
    echo "Logged In Users: $logged_in_users"
    echo "Background Jobs: $background_jobs"
    echo "Weather: $weather"
    echo "You are in: $current_dir"
    set_color green
    echo '─────────────────────────────────────────────'
    set_color magenta
    echo '     █████╗ ███╗   ███╗ ██████╗ ███████╗'
    echo '    ██╔══██╗████╗ ████║██╔═══██╗██╔════╝'
    echo '    ███████║██╔████╔██║██║   ██║███████╗'
    echo '    ██╔══██║██║╚██╔╝██║██║   ██║╚════██║'
    echo '    ██║  ██║██║ ╚═╝ ██║╚██████╔╝███████║'
    echo '    ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝'
    set_color green
    echo '─────────────────────────────────────────────'
    # Reset color to normal
    set_color normal
end

# Aliases
alias ll 'ls -lah'
alias gst 'git status'
alias gl 'git log'

# Custom Functions
function mkcd
    mkdir -p $argv; and cd $argv
end

# Environment Variables
set -gx PATH $HOME/bin $PATH
set -gx EDITOR 'vim'

# Abbreviations
abbr -a gco 'git checkout'
abbr -a gcob 'git checkout -b'

# Syntax Highlighting
set fish_color_normal normal
set fish_color_command cyan
set fish_color_keyword green

# Command History
set -U fish_history_limit 10000

# Conditional Configuration
if test (uname) = 'Linux'
    set -gx BROWSER 'firefox'
else if test (uname) = 'Darwin'
    set -gx BROWSER 'safari'
end

# Color Scheme
set fish_color_autosuggestion '555' 'brblack'
set fish_color_command 'green'
set fish_color_param 'cyan'
set fish_color_comment 'yellow'
set fish_color_selection 'white' '--bold' 'brblue'

# Custom prompt function
function fish_prompt
    # Get the current time
    set -l current_time (date "+%H:%M:%S")

    # Get vi mode status
    if test "$fish_bind_mode" = "default"
        set -l vi_mode "INSERT"
    else
        set -l vi_mode "NORMAL"
    end

    # First line: username@hostname and current directory
    set -l left_prompt (set_color yellow) (whoami) '@' (hostname | cut -d'.' -f1) ' ' (set_color cyan) (prompt_pwd) (set_color normal)

    # Right side: time and vi mode
    set -l right_prompt (set_color green) $current_time ' ' $vi_mode

    # Calculate the available space for padding
    # set -l available_space (math (tput cols) - (string length "$left_prompt") - (string length "$right_prompt"))

    # Print the prompt
    echo -n $left_prompt (string repeat -n $available_space ' ') $right_prompt

    echo ''
    # Second line: git branch if in a git repository
    echo -n (set_color magenta) (git branch --show-current 2>/dev/null)

    # Symbol to indicate ready for new command
    echo -n (set_color normal) '❯ '
end


# Check if running inside tmux and source tmux configuration
if test -n "$TMUX"
    source ~/.tmux.conf
end