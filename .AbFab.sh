#!/bin/bash
#shellcheck shell=bash
#shellcheck disable=SC2016,SC1083,SC1090,SC2116,SC2154

export ABFAB_SCREENSAVER_SELECT=0
export ABFAB_SCREENSAVER_IDLE_TIME=45
export ABFAB_SCREENSAVER_NOTICE_TIME=5
# declare -a ABFAB_SCREEN_SAVER_LIST
export ABFAB_SCREENSAVER_CYCLE_TIME=0
export ABFAB_SCREEN_SAVER_LIST=("cmatrix -bu 4 -a | lolcat -F 0.00015" 
"cmatrix -bu 4 -a | lolcat -F 0.0005" 
"cmatrix -bu 4 -a" 
"nyancat --frames 600" 
"asciiquarium" )
# "hollywood -s 6" )
export ABFAB_SCREEN_SAVER_PRESHOW_LIST=("sl -Fal | lolcat" 
"sl -al | lolcat" 
"nyancat --frames 100" )  # randomize the Fal 0..8 -3 bits THis is also only a preexec option it does not loop

export ABFAB_EXEC_START_PREFIX='🏳️‍🌈'
export ABFAB_EXEC_END_PREFIX='🏁 '
export ABFAB_LOLCAT_SEED=1
export ABFAB_LOLCAT_INCREMENT=2
export ABFAB_LOLCAT_FREQ=0.3
export ABFAB_ANIMAL_FRIENDS=5
export ABFAB_ANIMAL_HERD="false"
# ABFAB_ANIMAL_SET_FRIENDS 3
export ABFAB_ANIMAL_SELECT=0  # Set to 0 for random
export ABFAB_ANIMALS=🐒🦍🐕🐩🐈🐅🐆🐴🐎🦄🦓🦌🐂🐃🐄🐖🐗🐏🐑🐐🐪🐫🦙🦒🐘🦏🦛🐁🐀🐇🐿🦔🦇🦘🦡🦃🐔🐓🐣🐤🐥🐦🐧🕊🦅🦆🦢🦉🦚🦜🐊🐢🦎🐍🐲🐉🦕🦖🐳🐋🐬🐟🐠🐡🦈🐙🐚🦀🦞🦐🦑🐌🦋🐛🐜🐝🐞🦗🕷🦂

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

#export ABFAB_SCREEN_SAVER_DISABLE=true # This turns off the terminal screensaver
#unset ABFAB_SCREEN_SAVER_DISABLE  # This resumes screen saver timeout 

#export ABFAB_RUN_DURATION_DISABLE=true # This turns off the duration feature
#unset ABFAB_RUN_DURATION_DISABLE  # This resumes duration feature

ABFAB_ANIMAL_ARRAY=($(eval echo "$ABFAB_ANIMALS" | sed "s/./& /g"))
# mapfile -t ABFAB_ANIMAL_ARRAY < <($ABFAB_ANIMALS)
# animal_emoji=${ABFAB_ANIMAL_ARRAY[$ABFAB_ANIMAL_SELECT]}

setopt promptsubst

alias ABFAB_SETTINGS='export | rg ABFAB'

ABFAB_DEPENDENCY_LIST() {
  export ABFAB_DEPENDENCIES=("coreutils" 
  "tmux" 
  "cmatrix" 
  "cowsay" 
  "lolcat" 
  "fortune" 
  "hollywood" 
  "asciiquarium" 
  "nyancat" "sl" )
}

ABFAB_ANIMAL() {
  if [[ $1 -gt 0 ]]; then
    export ABFAB_ANIMAL_SELECT=$1
  else
   export ABFAB_ANIMAL_SELECT=0
  fi
  echo "ABFAB_ANIMAL_SELECT: $ABFAB_ANIMAL_SELECT  (Reminder: 0 is random)"
}

ABFAB_ANIMAL_SET_FRIENDS() {
  if [[ $1 -gt 0 ]]; then
    export ABFAB_ANIMAL_FRIENDS=$1
  fi
  echo "ABFAB_ANIMAL_FRIENDS: $ABFAB_ANIMAL_FRIENDS "
}

ABFAB_SHOW_ANIMAL_FRIENDS_HERD() {
  animal_friends=""
  i=0
  if [[ "$ABFAB_ANIMAL_HERD" = "true" ]]; then
    herd_index=$((RANDOM % ${#ABFAB_ANIMAL_ARRAY[@]}))
  fi
  until [[ $i -ge $ABFAB_ANIMAL_FRIENDS ]]; do
    if [[ "$ABFAB_ANIMAL_SELECT" -eq 0 ]]; then
      if [[ "$ABFAB_ANIMAL_HERD" = "true" ]]; then
        idx=$herd_index
      else
        idx=$((RANDOM % ${#ABFAB_ANIMAL_ARRAY[@]}))
      fi
      animal_friends+=${ABFAB_ANIMAL_ARRAY[$idx+1]}
    else
      animal_friends+=${ABFAB_ANIMAL_ARRAY[$ABFAB_ANIMAL_SELECT]}
    fi
    ((i++))
  done
  echo "$animal_friends"
}

ABFAB_SHOW_ANIMAL_FRIENDS() {
  animal_friends=""
  i=0
  until [[ $i -ge $ABFAB_ANIMAL_FRIENDS ]]; do
    if [[ "$ABFAB_ANIMAL_SELECT" = "0" ]]; then
      animal_index=$((RANDOM % ${#ABFAB_ANIMAL_ARRAY[@]}))
      animal_friends+=${ABFAB_ANIMAL_ARRAY[$animal_index+1]}
    else
      animal_friends+=${ABFAB_ANIMAL_ARRAY[$ABFAB_ANIMAL_SELECT]}
    fi
    ((i++))
  done
  export animal_friends
}

ABFAB_PS1_ANIMALS() {
  if [[ "$ABFAB_ANIMAL_HERD" = "true" ]]; then
    ABFAB_SHOW_ANIMAL_FRIENDS_HERD "$@"
  else
    ABFAB_SHOW_ANIMAL_FRIENDS
    echo "$animal_friends"
  fi
}

ABFAB_RAINBOW() {
  lolcat -f -F $ABFAB_LOLCAT_FREQ -S $ABFAB_LOLCAT_SEED
}

ABFAB_RAINBOW_INC() {
  ABFAB_RAINBOW
  ((ABFAB_LOLCAT_SEED += ABFAB_LOLCAT_INCREMENT))
}

ABFAB_SHOW_ALL_ANIMAL_NUMBERS() {
  out='Animals with Numbers:\n'
  for (( x = 1; x <= $#ABFAB_ANIMAL_ARRAY; x++ ))
  do
    out+="$x ${ABFAB_ANIMAL_ARRAY[$x]} "
  done
  echo "$out" | ABFAB_RAINBOW
}

ABFAB_SHOW_ALL_ANIMALS() {
  echo $ABFAB_ANIMALS
}

ABFAB_SHOW_ANIMAL() {
  if [[ $1 -gt 0 ]]; then
    echo "$1 is ${ABFAB_ANIMAL_ARRAY[$1]}" | ABFAB_RAINBOW
  else
    echo "Please enter a number to see that animal, but here they all are."
    ABFAB_SHOW_ALL_ANIMAL_NUMBERS "$@"
  fi
}

__prev_cmd() {
  cmd_hist=$HISTCMD && ((cmd_hist-=1))
  cmd="${history[$cmd_hist]}"
  return "$cmd"
}

ABFAB_DURATION() {
  if [[ -v start_cmd && ! -v ABFAB_RUN_DURATION_DISABLE ]]; then
    end_cmd=$(ABFAB_EXEC_TS)
    cmd_dur="$(bc <<<"$end_cmd-$start_cmd")"
    # echo ${TERM_BLUE}"Duration: ${cmd_dur}"${TERM_DEFAULT} | ABFAB_RAINBOW_INC
    prev_hist=$HISTCMD && ((prev_hist-=1))
    prev=$(echo "${history[$prev_hist]}")
    fin=$(echo "$ABFAB_EXEC_END_PREFIX" "$(get_date_blink_colon)" Duration "$cmd_dur" - "$prev" | ABFAB_RAINBOW_INC )
    echo "$fin"
    done=""
    if [ "$PS1_exit" -ne 0 ]; then
      done+="🚩"
    fi
    done+="🏁 $prev_hist $prev Completed Duration: $cmd_dur"
    ABFAB_TERM_TITLE "$done"
    unset start_cmd; unset end_cmd; unset cmd_dur
  fi
}

ABFAB_EXEC_TS() {
  date -u +%s.%N
}

ABFAB_START_EXEC() {
  if [[ ! -v ABFAB_RUN_DURATION_DISABLE ]]; then
    start_cmd=$(ABFAB_EXEC_TS)
    #echo "$ABFAB_EXEC_START_PREFIX $(get_date_blink_colon)-Run Start from: $(pwd)" | ABFAB_RAINBOW_INC
  fi
}

ABFAB_TERM_TITLE() { printf "\033]0;%s\007" "$*"; }

ABFAB_START_TITLE() {
  cmd=""
  if [[ "$1" != "" ]]; then
   cmd=$1
  else
    cmd_hist=$HISTCMD && ((prev_hist-=1))
    cmd=$(echo "${history[$cmd_hist]}")
  fi
  start_run=$(echo "🏳️‍🌈 $(get_date_blink_colon) Started: $cmd" | ABFAB_RAINBOW_INC )
  echo "$start_run"
  ABFAB_TERM_TITLE "🏳️‍🌈 $cmd_hist Started Running : $cmd"
}

preexec() {
  ABFAB_START_TITLE
  ABFAB_START_EXEC
}

ABFAB_COUNTDOWN () {
  i="$1"
  while [ "$i" -ge 0 ]; do
    printf "\rStarting in %s seconds." "$i" | ABFAB_RAINBOW
    ((i -= 1))
    sleep 1
  done
  printf '\nStarting now.\n' | ABFAB_RAINBOW_INC
}

ABFAB_SCREENSAVER() {
  screen_saver_on="true"
  ind=$1
  if [[ $1 -eq 0 ]]; then
    printf "\nRandomly selecting screen saver. Iteractively, provide a number to choose specific screensaver.\n" | ABFAB_RAINBOW_INC
    ind=$((RANDOM % ${#ABFAB_SCREEN_SAVER_LIST[@]} + 1))
  fi
  chosen=${ABFAB_SCREEN_SAVER_LIST[ind]}
  echo "$(get_date) Starting the chosen one: ${chosen}" | ABFAB_RAINBOW_INC
  #sleep $ABFAB_SCREENSAVER_NOTICE_TIME
  ABFAB_COUNTDOWN $ABFAB_SCREENSAVER_NOTICE_TIME
  #timeout --preserve-status --kill-after=$ABFAB_SCREENSAVER_NOTICE_TIME > nul
  ABFAB_START_TITLE "$chosen"
  ABFAB_START_EXEC 
  eval "${chosen}"
  # echo "$(get_date) '-' Screensaver exited." | ABFAB_RAINBOW_INC
  ABFAB_DURATION
  START=$SECONDS+$ABFAB_SCREENSAVER_IDLE_TIME
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
  ABFAB_SHOW_ANIMAL_FRIENDS_RETURN "$(get_random)"
}

precmd_functions+=('__prompt_command')
# precmd_functions=('__prompt_command' "${precmd_functions[@]}")  # this is to prepend
PS1_COLORIZE_COMMAND='__ps1_abfab'

export PS1_DEBUG_COMMAND='__ps1_debug'
export PS1_DEBUG='false'

__prompt_command() {
  PS1_exit=$? # Save last exit code

  ABFAB_DURATION
  ABFAB_SHOW_ANIMAL_FRIENDS

  if [[ "$PS1_DEBUG" = 'true' ]]; then
    if [[ "$PS1" = "$PS1_DEBUG_DISABLED" ]]; then
      PS1=$PS1_DEBUG_ENABLED
    fi
  else
    if [[ "$PS1" = "$PS1_DEBUG_ENABLED" ]]; then
      PS1=$PS1_DEBUG_DISABLED
    fi
  fi

  ((ABFAB_LOLCAT_SEED += ABFAB_LOLCAT_INCREMENT))
  START=$SECONDS
}

ps1_set_debug_mode() {
  if [[ "$PS1_DEBUG" = 'true' ]]; then
    PS1=$PS1_DEBUG_ENABLED
  else
    PS1=$PS1_DEBUG_DISABLED
  fi
}

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
# PS1+='$(eval "$PS1_COLORIZE_COMMAND" <<<$(get_date))'
# PS1+=' $(eval "$PS1_COLORIZE_COMMAND" <<<"(\w)")'
# PS1+=' $(eval "$PS1_COLORIZE_COMMAND" <<<$(parse_git_set_info))'

#Single Rainbow with blinking colons
PS1+='$(eval "$PS1_COLORIZE_COMMAND" <<< "$(ABFAB_PS1_ANIMALS)$(get_date_blink_colon)$(ABFAB_PS1_ANIMALS)$(parse_git_set_info)($(print -P "%~"))!>")'

PS1_DEBUG_ENABLED='$(eval "$PS1_DEBUG_COMMAND" <<<"'$PS1'")'
PS1_DEBUG_ENABLED='$(__ps1_escape_percent <<<"'$PS1_DEBUG_ENABLED'")'

PS1_DEBUG_DISABLED=$PS1

__ps1_remove_newline() {
  tr -d '\n'
}
__ps1_color_wrap_non_printing() {
  local REGEX=$ESC'\[[[:digit:];]*m'
  local REPLACE=$SOH'&'$STX
#   local REPLACE=%{$SOH&$STX%}
  sed "s/$REGEX/$REPLACE/g"
}

__collapse_non_printing() {
  sed -E "s/$SOH/%{/g" -E "s/$STX/%}/g"
}

__ps1_abfab() {
  ABFAB_RAINBOW | __ps1_color_wrap_non_printing 
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
__ps1_debug() {
  cat -v | __ps1_colorize_debug
}

__ps1_debug_sed() {
  # sed -e 's/'$ESC'/[ESC]/g' -e 's/'$SOH'/[SOH]/g' -e 's/'$STX'/[STX]/g'
  sed -e "s/$ESC/[ESC]/g" -e "s/$SOH/[SOH]/g" -e "s/$STX/[STX]/g"
}

__ps1_escape_percent() {
  sed 's/%/%&/g'
}

TRAPALRM () {
  if [ $((SECONDS-START)) -ge $ABFAB_SCREENSAVER_IDLE_TIME ]; then
    if [[ ! -v ABFAB_SCREEN_SAVER_DISABLE && ! -v screen_saver_on ]]; then
      ABFAB_SCREENSAVER $ABFAB_SCREENSAVER_SELECT  # randomly selects by default
    fi
  else
    unset screen_saver_on
  fi
  zle reset-prompt
}
TMOUT=1
