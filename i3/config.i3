# vim: filetype=i3
# File originally by Luke Smith <https://lukesmith.xyz>

# This config file will use environmental variables such as $BROWSER and $TERMINAL.
# You can set these variables in ~/.profile or ~/.bash_profile if you have it as below:
#
# export FILE="ranger"
# export TERMINAL="st"

# #---Basic Definitions---# #
for_window [class="^.*"] border pixel 1
# for_window [class="^.*"] border normal
gaps inner 25
gaps outer 30

#class			border  backgr. text    indicator child_border
client.focused		#4c7899 #285577 #ffffff #2e9ef4   #ff5858
client.focused_inactive #333333 #5f676a #ffffff #484e50   #00000000
client.unfocused        #333333 #222222 #888888 #292d2e   #00000000
client.urgent           #2f343a #900000 #ffffff #900000   #00000000
client.urgent           #2f343a #900000 #ffffff #900000   #c10031
client.placeholder	#000000 #0c0c0c #ffffff #000000   #830077
#client.focused		#4c7899 #285577 #ffffff #2e9ef4   #00000000
#client.focused_inactive #333333 #5f676a #ffffff #484e50   #830077
#client.unfocused        #333333 #222222 #888888 #292d2e   #830077
#client.urgent           #2f343a #900000 #ffffff #900000   #c10031
#client.placeholder	#000000 #0c0c0c #ffffff #000000   #830077

client.background	#ffffff

set $term --no-startup-id $TERMINAL
set $mod Mod4
set $stoprec --no-startup-id dmenurecord kill
set $shutdown sudo -A shutdown -h now
set $reboot sudo -A reboot
set $netrefresh --no-startup-id sudo -A systemctl restart NetworkManager
set $hibernate sudo -A systemctl hibernate

# #---Dropdown Windows---# #
# General dropdown window traits. The order can matter.
for_window [instance="dropdown_*"] floating enable
for_window [instance="dropdown_*"] move scratchpad
for_window [instance="dropdown_*"] sticky enable
for_window [instance="dropdown_*"] scratchpad show
for_window [instance="dropdown_tmuxdd"] resize set 625 450
for_window [instance="dropdown_dropdowncalc"] resize set 800 300
for_window [instance="dropdown_tmuxdd"] border pixel 3
for_window [instance="dropdown_dropdowncalc"] border pixel 2
for_window [instance="dropdown_*"] move position center

bar {
	font pango:mono 10
	status_command i3blocks
	position top
	mode dock
	modifier None
}

# #---Basic Bindings---# #
bindsym $mod+Return 		exec konsole
bindsym $mod+Shift+Return	exec --no-startup-id samedir

bindsym $mod+p 			exec --no-startup-id picom --experimental-backends
bindsym $mod+shift+p		exec --no-startup-id killall picom
bindsym $mod+Shift+space 	floating toggle
bindsym $mod+space		focus mode_toggle

bindsym $mod+Escape		workspace prev
bindsym $mod+Shift+Escape	exec prompt "Log out of i3?" "i3 exit"

# bindsym $mod+BackSpace
bindsym $mod+Shift+BackSpace	exec --no-startup-id prompt "Reboot computer?" "$reboot"

bindsym $mod+grave		exec --no-startup-id dmenuunicode
##bindsym $mod+asciitilde

#STOP/HIDE EVERYTHING:
bindsym $mod+Shift+Delete	exec --no-startup-id amixer sset Master mute ; exec --no-startup-id mpc pause && pkill -RTMIN+10 i3blocks ; exec --no-startup-id pauseallmpv; workspace 0; exec $term -e htop ; exec $term -e $FILE

# Show selection:
bindsym $mod+Insert		exec --no-startup-id showclip
##bindsym $mod+Pause

# #---Letter Key Bindings---# #
bindsym $mod+q			[con_id="__focused__" instance="^(?!dropdown_).*$"] kill
bindsym $mod+Shift+q		[con_id="__focused__" instance="^(?!dropdown_).*$"] exec --no-startup-id kill -9 `xdotool getwindowfocus getwindowpid`

bindsym $mod+w			exec $term -e nmtui
bindsym $mod+Shift+w		exec --no-startup-id $BROWSER

bindsym $mod+e			exec $term -e neomutt && pkill -RTMIN+12 i3blocks
bindsym $mod+Shift+e		exec --no-startup-id tutorialvids

bindsym $mod+r 			exec $FILE
bindsym $mod+Shift+r		exec --no-startup-id winresize

bindsym $mod+t			split toggle
bindsym $mod+Shift+t		gaps inner current set 15; gaps outer current set 15

bindsym $mod+y			exec $term -e calcurse -D ~/.config/calcurse
bindsym $mod+Shift+y		exec --no-startup-id i3resize left

bindsym $mod+u			exec --no-startup-id ddspawn tmuxdd
bindsym $mod+Shift+u		exec --no-startup-id i3resize down

bindsym $mod+i 			exec $term -e htop
bindsym $mod+Shift+i		exec --no-startup-id i3resize up

bindsym $mod+o			sticky toggle
bindsym $mod+Shift+o		exec --no-startup-id i3resize right

#bindsym $mod+p			exec --no-startup-id mpc toggle
#bindsym $mod+Shift+p		exec --no-startup-id mpc pause

bindsym $mod+a			exec --no-startup-id ddspawn dropdowncalc -f mono:pixelsize=24
bindsym $mod+Shift+a		exec $term -e alsamixer

bindsym $mod+s			gaps inner current plus 5
bindsym $mod+Shift+s		gaps inner current minus 5

bindsym $mod+d			exec --no-startup-id rofi -show run
bindsym $mod+Shift+d		gaps inner current set 0; gaps outer current set 0

set $freeze Distraction-free mode (super+shift+f to reactivate bindings)
mode "$freeze" { bindsym $mod+Shift+f mode "default"
}

bindsym $mod+f			fullscreen toggle
bindsym $mod+Shift+f		mode "$freeze" ;; exec --no-startup-id notify-send "Distraction-free mode activated." "Press Super+Shift+f to return."

bindsym $mod+g			workspace prev
bindsym $mod+Shift+g		exec --no-startup-id gimp; workspace $ws5

bindsym $mod+h			focus left
bindsym $mod+Shift+h		move left 30
bindsym $mod+Ctrl+h		move workspace to output left

bindsym $mod+j			focus down
bindsym $mod+Shift+j		move down 30
bindsym $mod+Ctrl+j		move workspace to output down

bindsym $mod+k			focus up
bindsym $mod+Shift+k		move up 30
bindsym $mod+Ctrl+k		move workspace to output up

bindsym $mod+l			focus right
bindsym $mod+Shift+l		move right 30
bindsym $mod+Ctrl+l		move workspace to output right

bindsym $mod+z			gaps outer current plus 5
bindsym $mod+Shift+z		gaps outer current minus 5

bindsym $mod+x			exec --no-startup-id mpc pause; exec --no-startup-id pauseallmpv ; exec --no-startup-id i3lock -e -f -c 1d2021 ; exec --no-startup-id xset dpms force off
bindsym $mod+Shift+x		exec --no-startup-id prompt "Shutdown computer?" "$shutdown"

bindsym $mod+c			exec --no-startup-id cabl
bindsym $mod+Shift+c		exec --no-startup-id camtoggle

bindsym $mod+v			exec --no-startup-id $term -e $EDITOR -c "VimwikiIndex"
#bindsym $mod+Shift+v

bindsym $mod+b			bar mode toggle
bindsym $mod+Shift+b		floating toggle; sticky toggle; exec --no-startup-id hover left

bindsym $mod+n			exec $term -e newsboat && pkill -RTMIN+6 i3blocks
bindsym $mod+Shift+n		floating toggle; sticky toggle; exec --no-startup-id hover right

bindsym $mod+m 			exec --no-startup-id $term -e ncmpcpp
bindsym $mod+Shift+m		exec --no-startup-id amixer sset Master toggle && pkill -RTMIN+10 i3blocks

# #---Workspace Bindings---# #
bindsym $mod+Home		workspace $ws1
bindsym $mod+Shift+Home		move container to workspace $ws1
bindsym $mod+End		workspace $ws10
bindsym $mod+Shift+End		move container to workspace $ws10
bindsym $mod+Prior		workspace prev
bindsym $mod+Shift+Prior	move container to workspace prev
bindsym $mod+Next		workspace next
bindsym $mod+Shift+Next		move container to workspace next
bindsym $mod+Tab		workspace back_and_forth
bindsym $mod+XF86Back		workspace prev
bindsym $mod+Shift+XF86Back	move container to workspace prev
bindsym $mod+XF86Forward	workspace next
bindsym $mod+Shift+XF86Forward	move container to workspace next
bindsym $mod+semicolon		workspace next
bindsym $mod+apostrophe		split horizontal ;; exec $term
bindsym $mod+slash		split vertical ;; exec $term
bindsym $mod+Shift+slash	kill
bindsym $mod+backslash		workspace back_and_forth

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

# switch to workspace
bindsym $mod+1		workspace $ws1
bindsym $mod+2		workspace $ws2
bindsym $mod+3		workspace $ws3
bindsym $mod+4		workspace $ws4
bindsym $mod+5		workspace $ws5
bindsym $mod+6		workspace $ws6
bindsym $mod+7		workspace $ws7
bindsym $mod+8		workspace $ws8
bindsym $mod+9		workspace $ws9
bindsym $mod+0		workspace $ws10

# move focused container to workspace
bindsym $mod+Shift+1	move container to workspace $ws1
bindsym $mod+Shift+2	move container to workspace $ws2
bindsym $mod+Shift+3	move container to workspace $ws3
bindsym $mod+Shift+4	move container to workspace $ws4
bindsym $mod+Shift+5	move container to workspace $ws5
bindsym $mod+Shift+6	move container to workspace $ws6
bindsym $mod+Shift+7	move container to workspace $ws7
bindsym $mod+Shift+8	move container to workspace $ws8
bindsym $mod+Shift+9	move container to workspace $ws9
bindsym $mod+Shift+0	move container to workspace $ws10

for_window [class="Pinentry"] sticky enable
for_window [class="sent"] border pixel 0px
for_window [title="GIMP Startup"] move workspace $ws5
for_window [class="Gimp"] move workspace $ws5
for_window [window_role="GtkFileChooserDialog"] resize set 800 600
for_window [window_role="GtkFileChooserDialog"] move position center
for_window [title="Default - Wine desktop"] floating enable

# Bindings to make the webcam float and stick.
for_window [title="mpvfloat"] floating enable
for_window [title="mpvfloat"] sticky enable
for_window [title="mpvfloat"] border pixel 0
no_focus [title="mpvfloat"]

# #---Function Buttons---# #
bindsym $mod+F1		exec --no-startup-id groff -mom ~/.local/share/larbs/readme.mom -Tpdf | zathura -
bindsym $mod+F2		restart
bindsym $mod+F3		exec --no-startup-id displayselect
bindsym $mod+F4		exec --no-startup-id prompt "Hibernate computer?" "$hibernate"
bindsym $mod+F5		exec --no-startup-id $netrefresh
bindsym $mod+F6		exec --no-startup-id torwrap
bindsym $mod+F7		exec --no-startup-id td-toggle
bindsym $mod+F8		exec --no-startup-id mailsync
bindsym $mod+F9		exec --no-startup-id dmenumount
bindsym $mod+F10	exec --no-startup-id dmenuumount
bindsym $mod+F11	exec --no-startup-id ducksearch
bindsym $mod+F12	exec $term -e nmtui

# #---Arrow Keys---# #
bindsym $mod+Left		focus left
bindsym $mod+Shift+Left		move left
bindsym $mod+Ctrl+Left		move workspace to output left
bindsym $mod+Down		focus down
bindsym $mod+Shift+Down		move down
bindsym $mod+Ctrl+Down		move workspace to output down
bindsym $mod+Up			focus up
bindsym $mod+Shift+Up		move up
bindsym $mod+Ctrl+Up		move workspace to output up
bindsym $mod+Right 		focus right
bindsym $mod+Shift+Right 	move right
bindsym $mod+Ctrl+Right		move workspace to output right

# #---Media Keys---# #
# Volume keys
bindsym $mod+plus		exec --no-startup-id amixer sset Master 5%+ && pkill -RTMIN+10 i3blocks
bindsym $mod+Shift+plus		exec --no-startup-id amixer sset Master 15%+ && pkill -RTMIN+10 i3blocks
bindsym $mod+minus 		exec --no-startup-id amixer sset Master 5%- && pkill -RTMIN+10 i3blocks
bindsym $mod+Shift+minus	exec --no-startup-id amixer sset Master 15%- && pkill -RTMIN+10 i3blocks
bindsym $mod+less 		exec --no-startup-id mpc prev
bindsym $mod+Shift+less		exec --no-startup-id mpc seek 0%
bindsym $mod+greater		exec --no-startup-id mpc next
bindsym $mod+Shift+greater	exec --no-startup-id mpc next

# For advancing forward/backward in an mpd song
bindsym $mod+bracketleft 	exec --no-startup-id mpc seek -10
bindsym $mod+Shift+bracketleft 	exec --no-startup-id mpc seek -120
bindsym $mod+bracketright 	exec --no-startup-id mpc seek +10
bindsym $mod+Shift+bracketright exec --no-startup-id mpc seek +120

# For screenshots and recording
bindsym Print 			exec --no-startup-id maim pic-full-"$(date '+%y%m%d-%H%M-%S').png"
bindsym Shift+Print 		exec --no-startup-id maimpick
bindsym $mod+Print		exec --no-startup-id dmenurecord
bindsym $mod+Scroll_Lock	exec --no-startup-id "killall screenkey || screenkey"
bindsym $mod+Delete		exec $stoprec
bindsym XF86Launch1		exec --no-startup-id xset dpms force off

# #---Extra XF86 Keys---# #
bindsym XF86AudioMute		exec --no-startup-id amixer sset Master toggle && pkill -RTMIN+10 i3blocks
bindsym XF86AudioLowerVolume	exec --no-startup-id amixer sset Master 5%- && pkill -RTMIN+10 i3blocks
bindsym Shift+XF86AudioLowerVolume	exec --no-startup-id amixer sset Master 10%- && pkill -RTMIN+10 i3blocks
bindsym Control+XF86AudioLowerVolume	exec --no-startup-id amixer sset Master 1%- && pkill -RTMIN+10 i3blocks
bindsym XF86AudioRaiseVolume	exec --no-startup-id amixer sset Master 5%+ && pkill -RTMIN+10 i3blocks
bindsym Shift+XF86AudioRaiseVolume	exec --no-startup-id amixer sset Master 10%+ && pkill -RTMIN+10 i3blocks
bindsym Control+XF86AudioRaiseVolume	exec --no-startup-id amixer sset Master 1%+ && pkill -RTMIN+10 i3blocks
bindsym XF86PowerOff		exec --no-startup-id prompt "Shutdown computer?" "$shutdown"
##bindsym XF86Copy		exec
##bindsym XF86Open		exec
##bindsym XF86Paste		exec
##bindsym XF86Cut		exec
##bindsym XF86MenuKB		exec
bindsym XF86Calculator		exec --no-startup-id ddspawn dropdowncalc -f mono:pixelsize=24
##bindsym XF86Sleep		This binding is typically mapped by systemd automatically.
##bindsym XF86WakeUp		exec
bindsym XF86Explorer		exec $term -e $FILE
##bindsym XF86Send		exec
##bindsym XF86Xfer		exec
bindsym XF86WWW			exec --no-startup-id $BROWSER
##bindsym XF86DOS		exec
bindsym XF86ScreenSaver		exec exec --no-startup-id lockscreen
##bindsym XF86RotateWindows	exec
##bindsym XF86TaskPane		exec
##bindsym XF86Favorites		exec
bindsym XF86MyComputer		exec $term -e $FILE
##bindsym XF86Back		exec
##bindsym XF86Forward		exec
bindsym XF86Eject		exec --no-startup-id dmenuumount
bindsym XF86AudioNext		exec --no-startup-id mpc next
bindsym XF86AudioPlay		exec --no-startup-id mpc toggle
bindsym XF86AudioPrev		exec --no-startup-id mpc prev
bindsym XF86AudioStop		exec --no-startup-id mpc toggle
##bindsym XF86AudioRecord
bindsym XF86AudioRewind		exec --no-startup-id mpc seek -10
bindsym XF86AudioForward	exec --no-startup-id mpc seek +10
##bindsym XF86Phone		exec
##bindsym XF86Tools		exec
bindsym XF86HomePage		exec $BROWSER https://lukesmith.xyz
bindsym XF86Reload		restart
##bindsym XF86ScrollUp		exec
##bindsym XF86ScrollDown		exec
##bindsym XF86New		exec
##bindsym XF86LaunchA		exec
##bindsym XF86LaunchB		exec
##bindsym XF86Launch2		exec
##bindsym XF86Launch3		exec
##bindsym XF86Launch4		exec
##bindsym XF86Launch5		exec
##bindsym XF86Launch6		exec
##bindsym XF86Launch7		exec
##bindsym XF86Launch8		exec
##bindsym XF86Launch9		exec
#bindsym XF86AudioMicMute	exec $micmute
bindsym XF86TouchpadToggle	exec --no-startup-id toggletouchpad
bindsym XF86TouchpadOn		exec --no-startup-id synclient TouchpadOff=0
bindsym XF86TouchpadOff		exec --no-startup-id synclient TouchpadOff=1
bindsym XF86Suspend		exec --no-startup-id lockscreen
bindsym XF86Close		kill
bindsym XF86WebCam		exec --no-startup-id camtoggle
bindsym XF86Mail		exec $term -e neomutt && pkill -RTMIN+12 i3blocks
bindsym XF86Messenger		exec $term -e weechat
bindsym XF86Search		exec $BROWSER https://duckduckgo.com
##bindsym XF86Go			exec
##bindsym XF86Finance		exec
##bindsym XF86Game		exec
bindsym XF86Shop		exec $BROWSER https://ebay.com
bindsym XF86MonBrightnessDown	exec --no-startup-id xbacklight -dec 15
bindsym XF86MonBrightnessUp	exec --no-startup-id xbacklight -inc 15
bindsym XF86AudioMedia		exec --no-startup-id $term -e ncmpcpp
bindsym XF86Display		exec --no-startup-id displayselect
#bindsym XF86KbdLightOnOff	exec
#bindsym XF86KbdBrightnessDown	exec
#bindsym XF86KbdBrightnessUp	exec
##bindsym XF86Reply		exec
##bindsym XF86MailForward	exec
##bindsym XF86Save		exec
bindsym XF86Documents		exec $term -e $FILE ~/Documents
##bindsym XF86Battery		exec
##bindsym XF86Bluetooth		exec
bindsym XF86WLAN		exec $netrefresh
exec_always --no-startup-id notify-send -i ~/.local/share/larbs/larbs.png 'Welcome to LARBS:' 'Press Super+F1 for the manual.' -t 10000
