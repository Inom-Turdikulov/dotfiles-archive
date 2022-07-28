#Variables {{{
#sub_link_count=1
use_search_hist=0
is_detach=1
info_wait=0
invidious_instance=y.com.sb
##}}}

# Functions {{{
external_menu () {
   # use rofi instead of dmenu
   rofi -dmenu -width 1500 -p "$1"
}
