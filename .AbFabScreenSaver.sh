#!/bin/bash
export AbFab_SCREENSAVER_SELECT=0
export AbFab_SCREENSAVER_IDLE_TIME=45
export AbFab_SCREENSAVER_NOTICE_TIME=3
export AbFab_SCREENSAVER_TIMEOUT=3600
export AbFab_SCREEN_SAVER_DISABLE=false
export AbFab_SCREEN_SAVER_LIST=("cmatrix -bu 4 -a | lolcat -F 0.00015" 
"cmatrix -bu 4 -a | lolcat -F 0.0005" 
"cmatrix -bu 4 -a" 
"nyancat --frames 600" 
"asciiquarium" ) # "hollywood -s 6" )
export AbFab_SCREEN_SAVER_PRESHOW_LIST=("sl -Fal | lolcat" 
"sl -al | lolcat" 
"nyancat --frames 100" )  # randomize the Fal 0..8 -3 bits THis is also only a preexec option it does not loop

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
      timeout_cmd="timeout ${timeout}s $chosen"
      eval "$timeout_cmd"
      prev_scr=$?
    fi
    AbFab_fn_DURATION
    START=$SECONDS+$AbFab_SCREENSAVER_IDLE_TIME
  done
}
