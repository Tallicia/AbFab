#!/bin/bash
export AbFab_LOLCAT_SEED=1
export AbFab_LOLCAT_INCREMENT=2
export AbFab_LOLCAT_FREQ=0.3
export AbFab_PROMPT_COLOR='rainbow'

AbFab_fn_RAINBOW() {
  lolcat -f -F $AbFab_LOLCAT_FREQ -S $AbFab_LOLCAT_SEED
}

AbFab_fn_COLOR() {  #TODO:This needs to be completed, single color prompt not working
  if [[ "$1" != "" ]]; then
    echo '%{$fg['"$1"']%}'
  else
    echo '%{$fg[$AbFab_PROMPT_COLOR]%}'
  fi
}

AbFab_fn_RAINBOW_INC() {
  AbFab_fn_RAINBOW
  ((AbFab_LOLCAT_SEED += AbFab_LOLCAT_INCREMENT))
}
