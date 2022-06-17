#Variables {{{
#sub_link_count=1
use_search_hist=1
is_detach=1
##}}}

# Functions {{{
external_menu () {
   # use rofi instead of dmenu
   rofi -dmenu -width 1500 -p "$1"
}
