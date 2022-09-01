#!/bin/bash
#shellcheck shell=bash
#shellcheck disable=SC2016,SC1083,SC1090,SC2116,SC2154
export AbFab_EXEC_START_PREFIX='🏳️‍🌈'
export AbFab_EXEC_END_PREFIX='🏁 '
export AbFab_EXEC_DURATION_PRECISION=4
export AbFab_RUN_DURATION_DISABLE=false
export AbFab_INSTALL_DIR=~/AbFab/

setopt promptsubst
alias AbFab-SHOW_SETTINGS='export | rg AbFab'

deps=(
  ".zhooks.sh" "zhooks info display"
  ".AbFabGit.sh" "Git for git stuff"
  ".AbFabAnimal.sh" "Animal for pretty emojis"
  ".AbFabRainbow.sh" "Rainbow for Prettier Prompt"
  ".AbFabScreenSaver.sh" "ScreenSaver to make the Robots work for you!"
)
for key val in "${(@kv)deps}"; do
  f=${AbFab_INSTALL_DIR}${key}
  #echo $f
  if [[ -f "$f" ]]; then
    echo "Sourcing "$f" because $val"
    . "$f"
  fi
done

AbFab_fn_DEPENDENCY_LIST() {
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

__prev_cmd() {
  cmd_hist=$HISTCMD && ((cmd_hist-=1))
  cmd="${history[$cmd_hist]}"
  return "$cmd"
}

AbFab_fn_DURATION() {
  if [[ -v start_cmd && "$AbFab_RUN_DURATION_DISABLE" != "true" ]]; then
    end_cmd=$(AbFab_fn_EXEC_TS)
    cmd_dur="$(bc <<<"$end_cmd-$start_cmd")"
    printf -v cmd_dur "%.${AbFab_EXEC_DURATION_PRECISION}f" "$cmd_dur"
    # echo ${TERM_BLUE}"Duration: ${cmd_dur}"${TERM_DEFAULT} | AbFab_fn_RAINBOW_INC
    prev_hist=$HISTCMD && ((prev_hist-=1))
    prev=$(echo "${history[$prev_hist]}")
    fin=$(echo "$AbFab_EXEC_END_PREFIX" "$(get_date_blink_colon)" Duration "$cmd_dur" - "$prev" | AbFab_fn_RAINBOW_INC )
    echo "$fin"
    done=""
    if [ "$__exit" -ne 0 ]; then
      done+="🚩"
    fi
    done+="${cmd_dur}[$__exit]🏁${prev}🏁(${prev_hist})"
    AbFab_fn_TERM_TITLE "$done"
    unset start_cmd; unset end_cmd; unset cmd_dur
  fi
}

AbFab_fn_EXEC_TS() {
  date -u +%s.%N
}

AbFab_fn_START_EXEC() {
  if [[ "$AbFab_RUN_DURATION_DISABLE" != "true" ]]; then
    start_cmd=$(AbFab_fn_EXEC_TS)
    #echo "$AbFab_EXEC_START_PREFIX $(get_date_blink_colon)-Run Start from: $(pwd)" | AbFab_fn_RAINBOW_INC
  fi
}

AbFab_fn_TERM_TITLE() { printf "\033]0;%s\007" "$*"; }

AbFab_fn_START_TITLE() {
  cmd=""
  if [[ "$1" != "" ]]; then
   cmd=$1
  else
    cmd_hist=$HISTCMD && ((prev_hist-=1))
    cmd=$(echo "${history[$cmd_hist]}")
  fi
  start_run=$(echo "🏳️‍🌈 $(get_date_blink_colon) Started: $cmd" | AbFab_fn_RAINBOW_INC )
  echo "$start_run"
  AbFab_fn_TERM_TITLE "🏳️‍🌈 $cmd_hist Started Running : $cmd"
}

preexec() {
  AbFab_fn_START_TITLE "$1"
  AbFab_fn_START_EXEC
}

AbFab_fn_COUNTDOWN () {
  i="$1"
  while [ "$i" -ge 0 ]; do
    printf "\rStarting in %s seconds." "$i" | AbFab_fn_RAINBOW
    ((i -= 1))
    sleep 1
  done
  printf '\nStarting now.\n' | AbFab_fn_RAINBOW_INC
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
  pr=$__DEFAULT_LITERAL
  pr+='['
  pr+='$('
  pr+='if [ "$__exit" -eq 0 ]; then '
  pr+="echo '$__GREEN_LITERAL'; "
  pr+='else '
  pr+="echo '$__RED_LITERAL'; fi"
  pr+=')'
  pr+='$__exit'
  pr+=$__DEFAULT_LITERAL
  pr+='] '
  echo "$pr"
}

precmd_functions+=('__prompt_command')
# precmd_functions=('__prompt_command' "${precmd_functions[@]}")  # this is to prepend
AbFab_fn_COLORIZE='__abfab'

__prompt_command() {
  __exit=$? # Save last exit code
  AbFab_fn_DURATION
  AbFab_fn_GEN_ANIMAL_FRIENDS
  ((AbFab_LOLCAT_SEED += AbFab_LOLCAT_INCREMENT))
  START=$SECONDS
}

TERM_DEFAULT=$(tput sgr0)
TERM_RED=$(tput setaf 1)
TERM_GREEN=$(tput setaf 2)

ESC=$'\033'
SOH=%{
STX=%}

__DEFAULT_LITERAL=$SOH$TERM_DEFAULT$STX
__RED_LITERAL=$SOH$TERM_RED$STX
__GREEN_LITERAL=$SOH$TERM_GREEN$STX

PS1=$(get_prev_result)

#Seperate Rainbow per section ( date, path, git, etc )
# PS1+='$(eval "$AbFab_fn_COLORIZE" <<<$(get_date))'
# PS1+=' $(eval "$AbFab_fn_COLORIZE" <<<"(\w)")'
# PS1+=' $(eval "$AbFab_fn_COLORIZE" <<<$(parse_git_set_info))'

#Single Rainbow with blinking colons
PS1+='$(eval "$AbFab_fn_COLORIZE" <<< "$(get_animals_fwd)$(get_date_blink_colon)$(get_animals_rev)$(parse_git_set_info)($(print -P "%~"))!>")'

__remove_newline() {
  tr -d '\n'
}
__color_wrap_non_printing() {
  local REGEX=$ESC'\[[[:digit:];]*m'
  local REPLACE=$SOH'&'$STX
  sed "s/$REGEX/$REPLACE/g"
}

__collapse_non_printing() {
  sed -E "s/$SOH/%{/g" -E "s/$STX/%}/g"
}

__abfab() {
  if [[ "$AbFab_PROMPT_COLOR" = "rainbow" ]]; then
    AbFab_fn_RAINBOW | __color_wrap_non_printing 
  else 
    AbFab_fn_COLOR "$AbFab_PROMPT_COLOR" | __color_wrap_non_printing
  fi
}

TRAPALRM () {
  if [ $((SECONDS-START)) -ge "$AbFab_SCREENSAVER_IDLE_TIME" ]; then
    if [[ "$AbFab_SCREEN_SAVER_DISABLE" != "true" && ! -v screen_saver_on ]]; then
      AbFab_fn_SCREENSAVER "$AbFab_SCREENSAVER_SELECT" "$AbFab_SCREENSAVER_TIMEOUT"  # randomly selects by default
    fi
  else
    unset screen_saver_on
  fi
  if [[ "$AbFab_ANIMAL_HERD" = "false" ]]; then
    if [[ "$AbFab_ANIMAL_PARADE" = "random" ]]; then
      get_animals_fwd "" > /dev/null 2>&1  # |& /dev/null
    else
      if [[ "$AbFab_ANIMAL_PARADE" = "rotate" ]]; then
        AbFab_fn_ANIMAL_ROTATE
      fi
    fi
  fi
  zle reset-prompt
}
TMOUT=1
