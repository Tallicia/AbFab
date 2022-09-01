#!/bin/bash
if [ -f ${AbFab_INSTALL_DIR}.git_prompt.sh ]; then
  source ${AbFab_INSTALL_DIR}.git_prompt.sh
fi 
source ~/scripts/.git_prompt.sh
# . ${AbFab_INSTALL_DIR}.git_prompt.sh
# . ~/Abfab/.git_prompt.sh

function parse_git_branch() {
  __git_ps1 "(%s)"
}

function parse_git_user() {
  git config user.name
}

function parse_git_set_info() {
  # git_super_status
  GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWDIRTYSTATE
  gb=$(parse_git_branch)
  if [ "" = "$gb" ]; then
    echo ""  # No git branch
  else
    echo " $(parse_git_user)-$gb"
  fi
  echo "$__CURRENT_GIT_STATUS"
}