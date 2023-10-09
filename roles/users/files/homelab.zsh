#    ██╗  ██╗ ██████╗ ███╗   ███╗███████╗██╗      █████╗ ██████╗    ███████╗███████╗██╗  ██╗
#    ██║  ██║██╔═══██╗████╗ ████║██╔════╝██║     ██╔══██╗██╔══██╗   ╚══███╔╝██╔════╝██║  ██║
#    ███████║██║   ██║██╔████╔██║█████╗  ██║     ███████║██████╔╝     ███╔╝ ███████╗███████║
#    ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  ██║     ██╔══██║██╔══██╗    ███╔╝  ╚════██║██╔══██║
# ██╗██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗███████╗██║  ██║██████╔╝██╗███████╗███████║██║  ██║
# ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝
# https://textkool.com/en/ascii-art-generator?hl=default&vl=default&font=ANSI%20Shadow&text=.homelab.zsh

# --- General -----------------------------------------------------------------

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

alias back="cd $OLDPWD"
alias c="clear"
alias check_tunnels="sudo lsof -i -n | grep \"IPv4\" | egrep '\<ssh\>'"
alias cp="cp -rfiv"
alias df="df -h"
alias du="du -c -h"
alias ducks='du -cks -- * | sort -rn | head'
alias get-public-key="ssh-keygen -y -f"
alias grep="grep --color=auto"
alias less="less -CfJMNRSUW"
# alias ll="exa --long --header --group --colour-scale --group-directories-first --octal-permissions --time-style=long-iso -a"
alias ll="exa -alhgnF --group-directories-first --octal-permissions --no-permissions --sort name --no-time"
alias ll_old="ls -alh --time-style=long-iso --group-directories-first"
alias etree="et --ignore-git --dirs-first --sort name -HI"
alias mkdir="mkdir -p -v"
# alias mv="noglob zmv -W"
alias reload="exec -l $SHELL && source $ZSH_CONF && autoload -U compinit && compinit"
alias rm="rm -rfiv"
alias root="sudo -s"
alias rsync+='rsync \
  --partial \
  --progress \
  --recursive \
  --times \
  --stats \
  --human-readable \
  --no-compress \
  --verbose \
  --append-verify'
alias swapcls='sudo swapoff -a && sudo swapon -a'
alias test-color="msgcat --color=test"
alias zshconfig="$EDITOR $ZSH_CONF"

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

timezsh_plugins() {
    for plugin ($plugins); do
    timer=$(($(gdate +%s%N)/1000000))
    if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
        source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
    elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
        source $ZSH/plugins/$plugin/$plugin.plugin.zsh
    fi
    now=$(($(gdate +%s%N)/1000000))
    elapsed=$(($now-$timer))
    echo $elapsed":" $plugin
    done
}

# --- Git ---------------------------------------------------------------------
alias gaa='git add --all'
alias gdf="git diff -U0 --word-diff"
alias ggpull='git pull --autostash --rebase origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'
alias glgf="glgs --follow -U0 --word-diff -p"
alias glgs="git log --pretty=\"format:%C(yellow)%h %Creset| %Cblue%ar - %aD %Creset| %Cgreen%aE %Creset|%Cred%d %Creset%s%n\" --abbrev=12 --graph --full-history --stat"
alias glgs1="git log --pretty=\"format:%C(yellow)%h %Creset| %Cblue%ar %Creset| %Cgreen%aE %Creset|%Cred%d %Creset%s\" --abbrev=12"
alias glgs2="git log --pretty=\"format:%C(yellow)%h %Creset| %Cblue%ar %Creset| %Cgreen%aE %Creset|%Cred%d %Creset%s%n\" --abbrev=12 -U0 -p --word-diff"
alias reyolo='git commit --amend -m "$(whatthecommit)"'
alias yolo='git commit -m "$(whatthecommit)"'

git_squash () {
    git reset $(git merge-base $1 $(git rev-parse --abbrev-ref HEAD))
    git add -A
    git commit -m "${2}"
}

# --- Tooling -----------------------------------------------------------------
alias ac="export ANSIBLE_CONFIG=./ansible.cfg"
alias ap="ansible-playbook"
alias av="ansible-vault"
alias d="docker"
alias dc="docker-compose"
alias k="kubectl"
alias kn="kubens"
alias kx="kubectx"
alias scode="sudo code --user-data-dir=/root"
alias setenv="source ~/venv/bin/activate"
alias tf="terraform"
alias tg="terragrunt"

# --- ZFS ---------------------------------------------------------------------
alias rsync+='rsync \
  --partial \
  --progress \
  --recursive \
  --times \
  --stats \
  --human-readable \
  --no-compress \
  --verbose \
  --append-verify'

# List all disks with links
function list-disk-by-id-with-link() {
  ls -l /dev/disk/by-id/* | \
  grep -E '(scsi-SATA|nvme-[^e]).*[A-Z0-9]{8}\W\->' | \
  tr -s ' ' | \
  cut -d ' ' -f 9,11 | \
  sed -e 's,\.\.\/\.\.,/dev,g'
}

# List all disks
function list-disk-by-id() {
  ls -l /dev/disk/by-id/* | \
  grep -E '(scsi-SATA|nvme-[^e]).*[A-Z0-9]{8}\W\->' | \
  tr -s ' ' | \
  cut -d ' ' -f 9 | \
  sed -e 's,\.\.\/\.\.,/dev,g'
}

# Load encrypted pool
function zload() {
  sudo zfs load-key -L prompt $1 && sudo zfs mount -a
}

# Unload encrypted pool
function zunload() {
  sudo zfs unmount -f $1 && sudo zfs unload-key $1
}

# Load all encrypted pools
function zload-all() {
  IFS=$'\n'
  POOLS=$(zpool get feature@encryption | grep active | tr -s ' ' | cut -d ' ' -f1)

  if [[ -n "$PASS" ]]; then
    for pool in ${POOLS}; do
      echo $PASS | sudo zfs load-key -L prompt $pool
    done
    sudo zfs mount -a
    unset PASS
    zfs get mounted
  else
    echo "PASS missing.."
    exit 1
  fi
}

# Times are in UTC to avoid DST issues.
function list-zfs-snapshots() {
  zfs list -t snapshot -o name -S creation $@
}

# Delete snapshots containing a string
function delete-zfs-snapshots() {
  zfs list -t snapshot -o name | grep $1 | xargs -n1 zfs destroy -r
}
