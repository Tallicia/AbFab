#!/bin/bash
export AbFab_SCREENSAVER_SELECT=0
export AbFab_SCREENSAVER_IDLE_TIME=100
export AbFab_SCREENSAVER_NOTICE_TIME=8
export AbFab_SCREENSAVER_TIMEOUT=90
export AbFab_SCREEN_SAVER_DISABLE=false
export AbFab_SCREEN_SAVER_LIST=("cmatrix -bu 4 -a | lolcat -F 0.00015" 
"cmatrix -bu 4 -a | lolcat -F 0.0005" 
"cmatrix -bu 4 -a" 
"nyancat" 
"bashtop" 
"neofetch"
"htop" 
"cbonsai --life=$((RANDOM % 200 + 1)) --message=\"$(fortune)\" --save=~/.AbFab_bonsai_state --load=~/.AbFab_bonsai_state --time=0.01 --live --infinite --multiplier=$((RANDOM % 20 + 1)) --base=$((RANDOM % 3 + 1))"
"pipes.sh" 
"asciiquarium" ) # "hollywood -s 6" )  #hollywood too much for macos
export AbFab_SCREEN_SAVER_PRESHOW_LIST=("sl -Fal | lolcat" 
"sl -al | lolcat" 
"nyancat --frames 100" 
"duf" )  # randomize the Fal 0..8 -3 bits

AbFab_fn_SCREENSAVER() {
  prev_scr=124
  while [[ "$prev_scr" -eq 124 ]]; do
    screen_saver_on="true"
    ind=$1
    timeout=$2
    if [[ "$ind" -eq 0 ]]; then
      printf "\nRandomly selecting screen saver. Iteractively, provide a number to choose specific screensaver.\n" | AbFab_fn_RAINBOW_INC
      ind=$((RANDOM % ${#AbFab_SCREEN_SAVER_LIST[@]} + 1))
    fi
    chosen=${AbFab_SCREEN_SAVER_LIST[$ind]}
    echo "$(get_date) Starting the chosen one: ${chosen}" | AbFab_fn_RAINBOW_INC
    AbFab_fn_COUNTDOWN $AbFab_SCREENSAVER_NOTICE_TIME
    AbFab_fn_START_TITLE "$chosen"
    AbFab_fn_START_EXEC
    #TODO Add pre show screen saver option 
    if [[ "$timeout" -eq 0 ]]; then
      eval "$chosen"
    else
      timeout_cmd="timeout --signal INT ${timeout}s $chosen"
      eval "$timeout_cmd"
      prev_scr=$?
    fi
    AbFab_fn_DURATION
    START=$SECONDS+$AbFab_SCREENSAVER_IDLE_TIME
  done
}
