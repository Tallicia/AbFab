#!/bin/bash
export AbFab_ANIMAL_FRIENDS=7  # The Number of friends to show in prompt -1 for random
export AbFab_ANIMAL_FRIENDS_MIN=2 
export AbFab_ANIMAL_FRIENDS_MAX=14
export AbFab_ANIMAL_HERD="false"
export AbFab_ANIMAL_PARADE="rotate"  # none || rotate || random 
export AbFab_ANIMAL_SELECT=0  # Set to 0 for random
export AbFab_ANIMALS=🐒🦍🐕🐩🐈🐅🐆🐴🐎🦄🦓🦌🐂🐃🐄🐖🐗🐏🐑🐐🐪🐫🦙🦒🐘🦏🦛🐁🐀🐇🦔🦇🦘🦡🦃🐔🐓🐣🐤🐥🐦🐧🦅🦆🦢🦉🦚🦜🐊🐢🦎🐍🐲🐉🦕🦖🐳🐋🐬🐟🐠🐡🦈🐙🐚🦀🦞🦐🦑🐌🦋🐛🐜🐝🐞🦗🦂

#🕊🐿🕷  # These had kerning issues with font need monospace emojis
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

AbFab_ANIMAL_ARRAY=($(eval echo "$AbFab_ANIMALS" | sed "s/./& /g"))
# mapfile -t AbFab_ANIMAL_ARRAY < <($AbFab_ANIMALS)

AbFab_fn_ANIMAL() {
  if [[ $1 -gt 0 ]]; then
    export AbFab_ANIMAL_SELECT=$1
  else
   export AbFab_ANIMAL_SELECT=0
  fi
  echo "AbFab_ANIMAL_SELECT: $AbFab_ANIMAL_SELECT  (Reminder: 0 is random)"
}

AbFab_fn_ANIMAL_FRIENDS_SET_NUM() {
  if [[ $1 -ge $AbFab_ANIMAL_FRIENDS_MIN && $1 -le $AbFab_ANIMAL_FRIENDS_MAX ]]; then
    AbFab_ANIMAL_FRIENDS=$1
  elif [[ $1 -le $AbFab_ANIMAL_FRIENDS_MIN ]]; then
    AbFab_ANIMAL_FRIENDS=$AbFab_ANIMAL_FRIENDS_MIN
  else
    AbFab_ANIMAL_FRIENDS=$AbFab_ANIMAL_FRIENDS_MAX
  fi
  if [[ $1 -le -1 ]]; then
    lo=$AbFab_ANIMAL_FRIENDS_MIN
    hi=$AbFab_ANIMAL_FRIENDS_MAX
    AbFab_ANIMAL_FRIENDS=$(shuf -i $lo-$hi -n 1)
    echo "Randomly Picked : $AbFab_ANIMAL_FRIENDS"
  fi
  export AbFab_ANIMAL_FRIENDS
}

AbFab_fn_SHOW_ANIMAL_FRIENDS_HERD() {
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
  export animal_friends
  echo "$animal_friends"
}

AbFab_fn_GEN_ANIMAL_FRIENDS() {
  if [[ "$AbFab_ANIMAL_PARADE" != "rotate" ]]; then
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
  else
    while [[ ${#animal_friends} -gt $AbFab_ANIMAL_FRIENDS ]]; do
      animal_friends=${animal_friends:1}
    done
    while [[ ${#animal_friends} -lt $AbFab_ANIMAL_FRIENDS ]]; do
      animal_index=$((RANDOM % ${#AbFab_ANIMAL_ARRAY[@]}))
      animal_friends+=${AbFab_ANIMAL_ARRAY[$animal_index+1]}
    done
  fi
  export animal_friends
}

AbFab_fn_ANIMALS() {
  if [[ "$AbFab_ANIMAL_HERD" = "true" ]]; then
    AbFab_fn_SHOW_ANIMAL_FRIENDS_HERD "$@"
  else
    AbFab_fn_GEN_ANIMAL_FRIENDS
    echo "$animal_friends"
  fi
}

AbFab_fn_ANIMAL_ROTATE() {
  animal_friends=${animal_friends:1}
  animal_index=$((RANDOM % ${#AbFab_ANIMAL_ARRAY[@]}))
  animal_friends+=${AbFab_ANIMAL_ARRAY[$animal_index+1]}
}

AbFab_fn_SHOW_ALL_ANIMAL_NUMBERS() {
  out='Animals with Numbers:\n'
  for (( x = 1; x <= $#AbFab_ANIMAL_ARRAY; x++ ))
  do
    out+="$x ${AbFab_ANIMAL_ARRAY[$x]} "
  done
  echo "$out" | AbFab_fn_RAINBOW_INC
}

AbFab_fn_SHOW_ALL_ANIMALS() {
  echo $AbFab_ANIMALS
}

AbFab_fn_SHOW_ANIMAL() {
  if [[ $1 -gt 0 ]]; then
    echo "$1 is ${AbFab_ANIMAL_ARRAY[$1]}" | AbFab_fn_RAINBOW_INC
  else
    echo "Please enter a number to see that animal, but here they all are."
    AbFab_SHOW_ALL_ANIMAL_NUMBERS "$@"
  fi
}

function get_random() {
  echo $((RANDOM))
}

function get_abfab_animals() {
  AbFab_fn_SHOW_ANIMAL_FRIENDS_RETURN "$(get_random)"
}

function get_animals_rev() {
  AbFab_fn_ANIMALS "$@" | rev
}

function get_animals_fwd() {
  AbFab_fn_ANIMALS "$@"
}
