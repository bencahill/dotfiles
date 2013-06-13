
# Check for an interactive session
#[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# alias sudo='sudo '
alias grep='grep --color=auto'
alias wic='wicd-curses'
alias x='startx'
alias cdw='cd /var/www/wordpress/wp-content/themes/'
alias svi='sudoedit'
alias fw='WINEPREFIX="/home/bencahill/.wine_fw8/" wine "C:\Program Files\Macromedia\Fireworks 8\Fireworks.exe"'
alias hg='history | grep'
alias vix="vi ~/.xmonad/xmonad.hs"
alias wic="wicd-curses"
alias mpf='mplayer -forceidx'
alias rm='rm -I'
alias vi='vim'
alias cower='cower -c --ignore=mysql-workbench'
alias cs='cower -s --color=always'
csl() {
    cower -s --color=always "$_"
}
alias msi='makepkg -si'
alias p='pacman-color'
alias Ql='pacman-color -Ql'
alias Qi='pacman-color -Qii'
alias Qo='pacman-color -Qo'
# Qo() {
#     if [[ "$(echo "$1"|cut -b1)" = "/" ]] && [[ -e "$1" ]]; then pacman-color -Qo $1
#     else pacman-color -Qo "$(which "$1")"; fi
# }
alias Qs='pacman-color -Qs'
alias Ss='pacman-color -Ss'
alias Si='pacman-color -Sii'
alias sp='sudo pacman-color'
alias Syu='sudo pacman-color -Syu'
alias Syuw='sudo pacman-color -Syuw'
alias Sy='sudo pacman-color -Sy'
alias S='sudo pacman-color -S'
alias U='sudo pacman-color -U'
alias R='sudo pacman-color -R'
alias Rsn='sudo pacman-color -Rsn'
# alias ssrdp='rdesktop -Pzg 1024x768 -u owner -p ssbc 10.0.1.180'
alias svd='sudo vimdiff'
alias vd='vimdiff'
alias srm='sudo rm -I'
alias smv='sudo mv'
alias rr='rrip_cli'
alias ssh='TERM=xterm ssh'
alias cdm='mplayer -cdrom-device /dev/sr0 -cache 5000 cdda://'
alias lsl='ls --color=auto -lh --time-style="+%m-%d-%Y %H:%M:%S"'
alias edate='exiv2 -g Exif.Photo.DateTimeOriginal -Pv'
alias pic2toat='rsync -ritP --delete /media/BC_2T_ext/picasa/Picasa2/ "/mauto/sat/Documents and Settings/Cahill/Local Settings/Application Data/Google/Picasa2/" && rsync -ritP --delete /media/BC_2T_ext/picasa/Picasa2Albums/ "/mauto/sat/Documents and Settings/Cahill/Local Settings/Application Data/Google/Picasa2Albums/"'
alias vih='vi ~/.bash_history'
alias edates='for i in *.[Jj][Pp][Gg]; do echo -n "$i "; edate "$i"; done'
alias e='[[ -n "$TMUX" ]] && tmux detach; exit'
alias et='exit'
alias dfh='cdf -h'
alias pst='elmer -1'
alias c='calc --'
alias keys='eval $(keychain --eval --agents ssh -Q --quiet .ssh/id_rsa)'
alias cux='chmod u+x'
alias m='mplayer'
alias dfc='dfc -t -tmpfs,devtmpfs,rootfs'
alias t='tmx ben new'
alias ta='tmx ben'
alias u='unison'
alias up='unison; unison pic2'
alias u='. ~/bin/inc/auto_mnt; auto_mnt BC_1t && { unison; auto_unmnt; }'
alias up='. ~/bin/inc/auto_mnt; auto_mnt BC_1t && { unison pics; auto_unmnt; }'
alias u2='. ~/bin/inc/auto_mnt; auto_mnt BC_2T_ext BC_1T_ext && { unison 2tb; auto_unmnt; }'
alias u1='. ~/bin/inc/auto_mnt; auto_mnt BC_2T_ext BC_1t && { unison 1t; auto_unmnt; }'
alias eq='alsamixer -D equal'
# alias ping='grc ping'
# alias diff='grc diff'
# alias tail='grc tail'
plugcount() {
sshg ./plugcount|awk '{a[$1]++;b[$1]=b[$1](b[$1]?",":"")$2} END{for(e in b){print a[e],e,b[e]}}'|sort -k 2
}
#dic() {
#    if [[ -n "$@" ]]; then
#        opera http://dictionary.reference.com/browse/$@;
#    fi
#}
sprunge() {
   if [[ -z "$1" ]]
   then
      url=$(curl -s -F 'sprunge=<-' http://sprunge.us)
      echo $url
   else
      for f in "$@"
      do
         url=$(curl -s -F 'sprunge=<-' http://sprunge.us < "$f")
         echo $url
      done
   fi
   echo -n $url | xclip -i
}

uzip() {
# if (($(unzip -l "$1" |awk 'FNR>3'|sed -n -e :a -e '1,2{N;ba' -e '}' -e 'P;N;D'|awk -F" " '{print $4}'|cut -d"/" -f1|sort -u|wc -l) > 1))
#     then if [[ ! -e "${1%.*}" ]]; then mkdir "${1%.*}" && unzip "$1" -d "${1%.*}"; else echo "Directory '${1%.*}' exists!"; fi
#     else unzip "$1"
# fi
[[ ! -e "$1" ]] && { echo "$1 does not exist!" >&2; return 1; }
zipdir="$(dirname "$1")/"
files="$(bsdtar tf "$1"|cut -d'/' -f1|uniq)"
dir="${1%.*}"
dir="${dir%.tar}"
if [[ "$(echo "$files"|wc -l)" = "1" ]]; then
	if [[ ! -e "$zipdir$files" ]]; then
		echo "Extracting to $zipdir$files..."
		bar "$1" | bsdtar xf - -C "$zipdir"
	else
		echo "$zipdir$files exists!" >&2
		( exit 1 )
	fi
elif [[ ! -e "$dir" ]]; then
	mkdir "$dir"
	echo "Extracting to $dir..."
	bar "$1" | bsdtar xf - -C "$dir"
else
	echo "$dir exists!" >&2
	( exit 1 )
fi
}

faketype() {
    wpm=100
    rate=$(echo "scale=2; $(echo "$1"|wc -w)/$wpm*60000/$(echo "$1"|wc -m)"|bc) # bc calcs "words/wpm=minutes*60000=ms/characters=delay between chars"
    xdotool type --delay "$rate" "$1"
}

pg() {
	pids="$(pgrep $1)"
	[[ $? = 0 ]] && ps $pids
}

dus() {
	cwd="$PWD"
	[[ -n "$1" ]] && cd "$1"
	find . -type f | awk -F'/' '{ dir[$2]++ } END { for (d in dir) { total+=dir[d]; printf "%s\t%s\n", dir[d], d } print total "\ttotal" }' | sort -n
	cd "$cwd"
}

fless() {
	for file; do
		less "$file"
	done
}

PATH="$HOME/.gem/ruby/2.0.0/bin:$HOME/vcsh:$HOME/bin:$PATH"

ipr=$(ip route); ipr=${ipr#*default via }; ipr=${ipr%% dev*};
case $ipr in
	10.0.[012].1) http_proxy="http://$(<~/.inc/proxy_home)@$ipr:8080/"; https_proxy="$http_proxy"; export http{,s}_proxy;;
	10.2.[23].1) http_proxy="http://$(<~/.inc/proxy_iaa)/"; https_proxy="$http_proxy"; export http{,s}_proxy;;
	10.1.16.50) http_proxy="http://$(<~/.inc/proxy_iaa)/"; https_proxy="$http_proxy"; export http{,s}_proxy;;
	*) unset http_proxy; unset https_proxy ;;
esac
unset ipr

export OPERAPLUGINWRAPPER_PRIORITY=0
export OPERA_KEEP_BLOCKED_PLUGIN=0

export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTCONTROL=ignoredups

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# export TERM='rxvt-256color'

export LESS="-RSM~gIsw"

export EDITOR=vim

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi

# function kingbash.fn() {
#   echo -n "KingBash> $READLINE_LINE" #Where "KingBash> " looks best if it resembles your PS1, at least in length.
#   OUTPUT=`kingbash --bashcompletion --plustoall --noretab-backspace --extracommands "$(compgen -ab -A function)" --extrafiles "$(compgen -v -P $)"`
#   READLINE_POINT=`echo "$OUTPUT" | tail -n 1`
#   READLINE_LINE=`echo "$OUTPUT" | head -n -1`
#   echo -ne "\r\e[2K"; }
# [[ $- =~ i ]] && bind -x '"\t":kingbash.fn'

complete -cf sudo
complete -cf man
