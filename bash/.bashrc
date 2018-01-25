
# Functions gathered from http://bytebaker.com/2012/01/09/show-git-information-in-your-prompt/
function git-branch-name {
  echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function git-dirty {
  st=$(git status 2>/dev/null | tail -n 1)
  if [[ $st != "nothing to commit, working directory clean" ]]
  then
    echo "*"
  fi
}

function git-unpushed {
  brinfo=$(git branch -v | grep $(git-branch-name))
  if [[ $brinfo =~ ("[ahead "([[:digit:]]*)) ]]
  then
    echo "(${BASH_REMATCH[2]})"
  fi
}

function gitify {
  status=$(git status 2>/dev/null | tail -n 1)
  if [[ $status == "" ]]
  then
    echo ""
  else
    echo "[$(git-branch-name)$(git-dirty)$(git-unpushed)]"
  fi
}

function make-prompt {
  local RED="\e[0;31m\]"
  local GREEN="\e[0;32m\]"
  local LIGHT_GRAY="\e[1;37m\]"

  PS1="\u${GREEN} (\w)${RED} \$(gitify)${LIGHT_GRAY}
\$ "
}

make-prompt

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
