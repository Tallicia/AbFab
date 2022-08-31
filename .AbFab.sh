#!/bin/bash
#shellcheck shell=bash
#shellcheck disable=SC2016,SC1083,SC1090,SC2116,SC2154

export AbFab_SCREENSAVER_SELECT=0
export AbFab_SCREENSAVER_IDLE_TIME=45
export AbFab_SCREENSAVER_NOTICE_TIME=5
# declare -a AbFab_SCREEN_SAVER_LIST
export AbFab_SCREENSAVER_CYCLE_TIME=0
export AbFab_SCREEN_SAVER_LIST=("cmatrix -bu 4 -a | lolcat -F 0.00015" 
"cmatrix -bu 4 -a | lolcat -F 0.0005" 
"cmatrix -bu 4 -a" 
"nyancat --frames 600" 
"asciiquarium" )
# "hollywood -s 6" )
export AbFab_SCREEN_SAVER_PRESHOW_LIST=("sl -Fal | lolcat" 
"sl -al | lolcat" 
"nyancat --frames 100" )  # randomize the Fal 0..8 -3 bits THis is also only a preexec option it does not loop

export AbFab_EXEC_START_PREFIX='🏳️‍🌈'
export AbFab_EXEC_END_PREFIX='🏁 '
export AbFab_LOLCAT_SEED=1
export AbFab_LOLCAT_INCREMENT=2
export AbFab_LOLCAT_FREQ=0.3
export AbFab_PROMPT_COLOR='rainbow'
export AbFab_ANIMAL_FRIENDS=5
export AbFab_ANIMAL_FRIENDS_MIN=2
export AbFab_ANIMAL_FRIENDS_MAX=14
export AbFab_ANIMAL_HERD="false"
# AbFab_ANIMAL_SET_FRIENDS 3
export AbFab_ANIMAL_SELECT=0  # Set to 0 for random
export AbFab_ANIMALS=🐒🦍🐕🐩🐈🐅🐆🐴🐎🦄🦓🦌🐂🐃🐄🐖🐗🐏🐑🐐🐪🐫🦙🦒🐘🦏🦛🐁🐀🐇🐿🦔🦇🦘🦡🦃🐔🐓🐣🐤🐥🐦🐧🕊🦅🦆🦢🦉🦚🦜🐊🐢🦎🐍🐲🐉🦕🦖🐳🐋🐬🐟🐠🐡🦈🐙🐚🦀🦞🦐🦑🐌🦋🐛🐜🐝🐞🦗🕷🦂

#🌈🏳️‍🌈

# 🤑👹☠️
# 😺😸😹😻😼😽🙀😿😾
# 🙈🙉🙊🐵🐽
# 🐺🦊🦝🐱🦁🐯🐸🐻🐨🐼🐭🐮🐷🐹🐰🐶
# 🐒🦍🐕🐩🐈
# 🐅🐆🐴🐎🦄🦓🦌🐂🐃🐄
# 🐖🐗🐏🐑🐐🐪🐫🦙🦒🐘🦏🦛
# 🐁🐀🐇🐿🦔🦘🦡
# 🦇
# 🦜🦃🐔🐓🐣🐤🐥🐦🐧🕊🦅🦆🦢🦉🦚
# 🐢🐊🦎🐍🐲🐉🦕🦖
# 🐳🐋🐬🦈🐟🐠🐡🐙🦀🦞🦐🦑
# 🐌🦋🐛🐜🐝🐞🦗🕷🦂
# 🦟🦠
# 🕸🐾🐚

# 🦄🦚🦜

#😀😁😂😃😄😅😆😉😊😋😎😍😘😗😙😚☺🙂😐😑😶😏😣😥😮😯😪😫😴😌😛😜😝😒😓😔😕😲☹🙁😖😞😟😤😢😭😦😧😨😩😬😰😱😳🤪😵😡😠😷😇😈👿💀💩😺😸😹😻😼😽🙀😿😾👨👩👴👵👌👍🤛🏻🤛🏼🤛🏽🤛🏾🤛🏿🤜🏻🤜🏼🤜🏽🤜🏾🤜🏿💦🕶🐵🐒🐶🐺🐱🐯🐴🐮🐷🐭🐹🐰🐻🐨🐼🐥🐸🐍🐲🍜🌚🌛🌜🌝🌞🌬🎃♥🎵💡📄🏁🚩🏳️‍🌈🏳🏴

#🌿🌽🌶🍞🍟🍕🍲🍚🍜☕🔪

#export AbFab_SCREEN_SAVER_DISABLE=true # This turns off the terminal screensaver
#unset AbFab_SCREEN_SAVER_DISABLE  # This resumes screen saver timeout 

#export AbFab_RUN_DURATION_DISABLE=true # This turns off the duration feature
#unset AbFab_RUN_DURATION_DISABLE  # This resumes duration feature

AbFab_ANIMAL_ARRAY=($(eval echo "$AbFab_ANIMALS" | sed "s/./& /g"))
# mapfile -t AbFab_ANIMAL_ARRAY < <($AbFab_ANIMALS)
# animal_emoji=${AbFab_ANIMAL_ARRAY[$AbFab_ANIMAL_SELECT]}

setopt promptsubst

alias AbFab_SETTINGS='export | rg AbFab'

AbFab_DEPENDENCY_LIST() {
  export AbFab_DEPENDENCIES=("coreutils" 
  "tmux" 
  "cmatrix" 
  "cowsay" 
  "lolcat" 
  "fortune" 
  "hollywood" 
  "asciiquarium" 
  "nyancat" "sl" )
}

AbFab_ANIMAL() {
  if [[ $1 -gt 0 ]]; then
    export AbFab_ANIMAL_SELECT=$1
  else
   export AbFab_ANIMAL_SELECT=0
  fi
  echo "AbFab_ANIMAL_SELECT: $AbFab_ANIMAL_SELECT  (Reminder: 0 is random)"
}

AbFab_ANIMAL_FRIENDS_SET_NUM() {
  if [[ $1 -gt $AbFab_ANIMAL_FRIENDS_MIN && $1 -le $AbFab_ANIMAL_FRIENDS_MAX ]]; then
    AbFab_ANIMAL_FRIENDS=$1
  elif [[ $1 -le $AbFab_ANIMAL_FRIENDS_MIN ]]; then
    AbFab_ANIMAL_FRIENDS=$AbFab_ANIMAL_FRIENDS_MIN
  else
    AbFab_ANIMAL_FRIENDS=$AbFab_ANIMAL_FRIENDS_MAX
  fi
  if [[ $1 -eq -1 ]]; then
    AbFab_ANIMAL_FRIENDS=-1
  fi
  export AbFab_ANIMAL_FRIENDS
  echo "AbFab_ANIMAL_FRIENDS: $AbFab_ANIMAL_FRIENDS "
}

AbFab_SHOW_ANIMAL_FRIENDS_HERD() {
  animal_friends=""
  i=0
  if [[ "$AbFab_ANIMAL_HERD" = "true" ]]; then
    herd_index=$((RANDOM % ${#AbFab_ANIMAL_ARRAY[@]}))
  fi
  until [[ $i -ge $AbFab_ANIMAL_FRIENDS ]]; do
    if [[ "$AbFab_ANIMAL_SELECT" -eq 0 ]]; then
      if [[ "$AbFab_ANIMAL_HERD" = "true" ]]; then
        idx=$herd_index
      else
        idx=$((RANDOM % ${#AbFab_ANIMAL_ARRAY[@]}))
      fi
      animal_friends+=${AbFab_ANIMAL_ARRAY[$idx+1]}
    else
      animal_friends+=${AbFab_ANIMAL_ARRAY[$AbFab_ANIMAL_SELECT]}
    fi
    ((i++))
  done
  echo "$animal_friends"
}

AbFab_SHOW_ANIMAL_FRIENDS() {
  animal_friends=""
  i=0
  until [[ $i -ge $AbFab_ANIMAL_FRIENDS ]]; do
    if [[ "$AbFab_ANIMAL_SELECT" = "0" ]]; then
      animal_index=$((RANDOM % ${#AbFab_ANIMAL_ARRAY[@]}))
      animal_friends+=${AbFab_ANIMAL_ARRAY[$animal_index+1]}
    else
      animal_friends+=${AbFab_ANIMAL_ARRAY[$AbFab_ANIMAL_SELECT]}
    fi
    ((i++))
  done
  export animal_friends
}

AbFab_PS1_ANIMALS() {
  if [[ "$AbFab_ANIMAL_HERD" = "true" ]]; then
    AbFab_SHOW_ANIMAL_FRIENDS_HERD "$@"
  else
    AbFab_SHOW_ANIMAL_FRIENDS
    echo "$animal_friends"
  fi
}

AbFab_RAINBOW() {
  lolcat -f -F $AbFab_LOLCAT_FREQ -S $AbFab_LOLCAT_SEED
}

AbFab_COLOR() {  #TODO:This needs to be completed, single color prompt not working
  if [[ "$1" != "" ]]; then
    echo '%{$fg['$1']%}'
  else
    echo '%{$fg[$AbFab_PROMPT_COLOR]%}'
  fi
}

AbFab_RAINBOW_INC() {
  AbFab_RAINBOW
  ((AbFab_LOLCAT_SEED += AbFab_LOLCAT_INCREMENT))
}

AbFab_SHOW_ALL_ANIMAL_NUMBERS() {
  out='Animals with Numbers:\n'
  for (( x = 1; x <= $#AbFab_ANIMAL_ARRAY; x++ ))
  do
    out+="$x ${AbFab_ANIMAL_ARRAY[$x]} "
  done
  echo "$out" | AbFab_RAINBOW
}

AbFab_SHOW_ALL_ANIMALS() {
  echo $AbFab_ANIMALS
}

AbFab_SHOW_ANIMAL() {
  if [[ $1 -gt 0 ]]; then
    echo "$1 is ${AbFab_ANIMAL_ARRAY[$1]}" | AbFab_RAINBOW
  else
    echo "Please enter a number to see that animal, but here they all are."
    AbFab_SHOW_ALL_ANIMAL_NUMBERS "$@"
  fi
}

__prev_cmd() {
  cmd_hist=$HISTCMD && ((cmd_hist-=1))
  cmd="${history[$cmd_hist]}"
  return "$cmd"
}

AbFab_DURATION() {
  if [[ -v start_cmd && ! -v AbFab_RUN_DURATION_DISABLE ]]; then
    end_cmd=$(AbFab_EXEC_TS)
    cmd_dur="$(bc <<<"$end_cmd-$start_cmd")"
    # echo ${TERM_BLUE}"Duration: ${cmd_dur}"${TERM_DEFAULT} | AbFab_RAINBOW_INC
    prev_hist=$HISTCMD && ((prev_hist-=1))
    prev=$(echo "${history[$prev_hist]}")
    fin=$(echo "$AbFab_EXEC_END_PREFIX" "$(get_date_blink_colon)" Duration "$cmd_dur" - "$prev" | AbFab_RAINBOW_INC )
    echo "$fin"
    done=""
    if [ "$PS1_exit" -ne 0 ]; then
      done+="🚩"
    fi
    done+="🏁 $prev_hist $prev Completed Duration: $cmd_dur"
    AbFab_TERM_TITLE "$done"
    unset start_cmd; unset end_cmd; unset cmd_dur
  fi
}

AbFab_EXEC_TS() {
  date -u +%s.%N
}

AbFab_START_EXEC() {
  if [[ ! -v AbFab_RUN_DURATION_DISABLE ]]; then
    start_cmd=$(AbFab_EXEC_TS)
    #echo "$AbFab_EXEC_START_PREFIX $(get_date_blink_colon)-Run Start from: $(pwd)" | AbFab_RAINBOW_INC
  fi
}

AbFab_TERM_TITLE() { printf "\033]0;%s\007" "$*"; }

AbFab_START_TITLE() {
  cmd=""
  if [[ "$1" != "" ]]; then
   cmd=$1
  else
    cmd_hist=$HISTCMD && ((prev_hist-=1))
    cmd=$(echo "${history[$cmd_hist]}")
  fi
  start_run=$(echo "🏳️‍🌈 $(get_date_blink_colon) Started: $cmd" | AbFab_RAINBOW_INC )
  echo "$start_run"
  AbFab_TERM_TITLE "🏳️‍🌈 $cmd_hist Started Running : $cmd"
}

preexec() {
  AbFab_START_TITLE
  AbFab_START_EXEC
}

AbFab_COUNTDOWN () {
  i="$1"
  while [ "$i" -ge 0 ]; do
    printf "\rStarting in %s seconds." "$i" | AbFab_RAINBOW
    ((i -= 1))
    sleep 1
  done
  printf '\nStarting now.\n' | AbFab_RAINBOW_INC
}

AbFab_SCREENSAVER() {
  screen_saver_on="true"
  ind=$1
  if [[ $1 -eq 0 ]]; then
    printf "\nRandomly selecting screen saver. Iteractively, provide a number to choose specific screensaver.\n" | AbFab_RAINBOW_INC
    ind=$((RANDOM % ${#AbFab_SCREEN_SAVER_LIST[@]} + 1))
  fi
  chosen=${AbFab_SCREEN_SAVER_LIST[ind]}
  echo "$(get_date) Starting the chosen one: ${chosen}" | AbFab_RAINBOW_INC
  #sleep $AbFab_SCREENSAVER_NOTICE_TIME
  AbFab_COUNTDOWN $AbFab_SCREENSAVER_NOTICE_TIME
  #timeout --preserve-status --kill-after=$AbFab_SCREENSAVER_NOTICE_TIME > nul
  AbFab_START_TITLE "$chosen"
  AbFab_START_EXEC 
  eval "${chosen}"
  # echo "$(get_date) '-' Screensaver exited." | AbFab_RAINBOW_INC
  AbFab_DURATION
  START=$SECONDS+$AbFab_SCREENSAVER_IDLE_TIME
}

if [ -f ~/scripts/.git_prompt.sh ]; then
    . ~/scripts/.git_prompt.sh
fi 

function parse_git_branch() {
  __git_ps1 "(%s)"
}

function parse_git_user() {
  git config user.name
}

function parse_git_set_info() {
  GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWDIRTYSTATE
  gb=$(parse_git_branch)
  if [ "" = "$gb" ]; then
    echo ""  # No git branch
  else
    echo " $(parse_git_user)-$gb"
  fi
}

function get_work_dir() {
  wdir='('
  wdir+=$(print -P '%~')
  wdir+=')'
  echo "$wdir"
}

function get_date() {
  date +"%a %F %T.%3N"
}

function get_date_blink_colon() {
  bcl=$(tput blink):$(tput sgr0)
  get_date | sed "s/:/$bcl/g"
}

function get_prev_result() {
  pr=$PS1_DEFAULT_LITERAL
  pr+='['
  pr+='$('
  pr+='if [ "$PS1_exit" -eq 0 ]; then '
  pr+="echo '$PS1_GREEN_LITERAL'; "
  pr+='else '
  pr+="echo '$PS1_RED_LITERAL'; fi"
  pr+=')'
  pr+='$PS1_exit'
  pr+=$PS1_DEFAULT_LITERAL
  pr+='] '
  echo "$pr"
}

function get_random() {
  echo $((RANDOM))
}

function get_abfab_animals() {
  AbFab_SHOW_ANIMAL_FRIENDS_RETURN "$(get_random)"
}

precmd_functions+=('__prompt_command')
# precmd_functions=('__prompt_command' "${precmd_functions[@]}")  # this is to prepend
AbFab_COLORIZE='__abfab'

# export PS1_DEBUG_COMMAND='__ps1_debug'
# export PS1_DEBUG='false'

__prompt_command() {
  PS1_exit=$? # Save last exit code

  AbFab_DURATION
  AbFab_SHOW_ANIMAL_FRIENDS

  # if [[ "$PS1_DEBUG" = 'true' ]]; then
  #   if [[ "$PS1" = "$PS1_DEBUG_DISABLED" ]]; then
  #     PS1=$PS1_DEBUG_ENABLED
  #   fi
  # else
  #   if [[ "$PS1" = "$PS1_DEBUG_ENABLED" ]]; then
  #     PS1=$PS1_DEBUG_DISABLED
  #   fi
  # fi

  ((AbFab_LOLCAT_SEED += AbFab_LOLCAT_INCREMENT))
  START=$SECONDS
}

# ps1_set_debug_mode() {
#   if [[ "$PS1_DEBUG" = 'true' ]]; then
#     PS1=$PS1_DEBUG_ENABLED
#   else
#     PS1=$PS1_DEBUG_DISABLED
#   fi
# }

TERM_DEFAULT=$(tput sgr0)
TERM_RED=$(tput setaf 1)
TERM_GREEN=$(tput setaf 2)

ESC=$'\033'
SOH=%{
STX=%}

PS1_DEFAULT_LITERAL=$SOH$TERM_DEFAULT$STX
PS1_RED_LITERAL=$SOH$TERM_RED$STX
PS1_GREEN_LITERAL=$SOH$TERM_GREEN$STX

#PS1_HISTORY_NUMBER=$(print -P '%!')
PS1=$(get_prev_result)

#Seperate Rainbow per section ( date, path, git, etc )
# PS1+='$(eval "$AbFab_COLORIZE" <<<$(get_date))'
# PS1+=' $(eval "$AbFab_COLORIZE" <<<"(\w)")'
# PS1+=' $(eval "$AbFab_COLORIZE" <<<$(parse_git_set_info))'

#Single Rainbow with blinking colons
PS1+='$(eval "$AbFab_COLORIZE" <<< "$(AbFab_PS1_ANIMALS | rev)$(get_date_blink_colon)$(AbFab_PS1_ANIMALS)$(parse_git_set_info)($(print -P "%~"))!>")'

# PS1_DEBUG_ENABLED='$(eval "$PS1_DEBUG_COMMAND" <<<"'$PS1'")'
# PS1_DEBUG_ENABLED='$(__ps1_escape_percent <<<"'$PS1_DEBUG_ENABLED'")'

# PS1_DEBUG_DISABLED=$PS1

__remove_newline() {
  tr -d '\n'
}
__color_wrap_non_printing() {
  local REGEX=$ESC'\[[[:digit:];]*m'
  local REPLACE=$SOH'&'$STX
#   local REPLACE=%{$SOH&$STX%}
  sed "s/$REGEX/$REPLACE/g"
}

__collapse_non_printing() {
  sed -E "s/$SOH/%{/g" -E "s/$STX/%}/g"
}

__abfab() {
  if [[ "$AbFab_PROMPT_COLOR" = "rainbow" ]]; then
    AbFab_RAINBOW | __color_wrap_non_printing 
  else 
    AbFab_COLOR $AbFab_PROMPT_COLOR | __color_wrap_non_printing
  fi
}

__ps1_colorize_debug() {
  local SOH_REGEX='(\^A)'
  local COLOR_CODE_REGEX='((\^\[\(B)?\^\[\[[[:digit:];]*m)'
  local STX_REGEX='(\^B)'
  local REGEX=$SOH_REGEX$COLOR_CODE_REGEX$STX_REGEX

  local SOH_REPLACE=$PS1_RED_LITERAL'\1'$PS1_DEFAULT_LITERAL
  local COLOR_CODE_REPLACE=$PS1_BLUE_LITERAL'\2'$PS1_DEFAULT_LITERAL
  local STX_REPLACE=$PS1_GREEN_LITERAL'\4'$PS1_DEFAULT_LITERAL
  local REPLACE=$SOH_REPLACE$COLOR_CODE_REPLACE$STX_REPLACE

  sed -E "s/$REGEX/$REPLACE/g"
}

# __ps1_debug() {
#   cat -v | __ps1_colorize_debug
# }

# __ps1_debug_sed() {
#   # sed -e 's/'$ESC'/[ESC]/g' -e 's/'$SOH'/[SOH]/g' -e 's/'$STX'/[STX]/g'
#   sed -e "s/$ESC/[ESC]/g" -e "s/$SOH/[SOH]/g" -e "s/$STX/[STX]/g"
# }

__ps1_escape_percent() {
  sed 's/%/%&/g'
}

TRAPALRM () {
  if [ $((SECONDS-START)) -ge $AbFab_SCREENSAVER_IDLE_TIME ]; then
    if [[ ! -v AbFab_SCREEN_SAVER_DISABLE && ! -v screen_saver_on ]]; then
      AbFab_SCREENSAVER $AbFab_SCREENSAVER_SELECT  # randomly selects by default
    fi
  else
    unset screen_saver_on
  fi
  zle reset-prompt
}
TMOUT=1
