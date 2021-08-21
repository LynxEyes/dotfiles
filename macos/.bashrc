source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

chruby 2.6

red="\[\033[1;31m\]";
gre="\[\033[1;32m\]";
yel="\[\033[1;33m\]";
pur="\[\033[1;34m\]";
pin="\[\033[1;35m\]";
cya="\[\033[1;36m\]";
whi="\[\033[1;37m\]";
nor="\[\033[0;39m\]";
bld="\[\033[1;39m\]";
time='$(date +%H:%M:%S)'

function __parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function __git_status_color() {
  git status 1> /dev/null 2> /dev/null

  if [[ $? == 0 ]]; then
    git status 2> /dev/null | grep "working tree clean" > /dev/null
    if [[ $? == 0 ]]; then
      printf "\033[1;32m"
    else
      printf "\033[1;31m"
    fi
  else
    printf "\033[0;39m"
  fi
}

PS1="\n$bld$yel$time $pur@$nor \w \$(__git_status_color)\$(__parse_git_branch)$nor\n$ "
# PS1="[$gre\u$bld#$cya\h$bld @ $yel$time$nor]: \w\n$ "

APPLE_INTERFACE_STYLE=$(defaults read -g AppleInterfaceStyle 2> /dev/null)
if [[ "Dark" == $APPLE_INTERFACE_STYLE ]]; then
  export DARKENV="true"
fi

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=00;33:*.tgz=00;33:*.7z=00;33:*.arj=00;33:*.taz=00;33:*.lzh=00;33:*.zip=00;33:*.z=00;33:*.Z=00;33:*.gz=00;33:*.bz2=00;33:*.deb=04;31:*.rpm=04;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:*.rb=00;31:*.js=00;32:*.json=00;32:*.sql=00;32:*.yml=00;32:*.rake=00;31';
export GREP_OPTIONS='--color=auto -I --exclude-dir=.git --exclude=.tags* --exclude=*.tlf'

source ~/.alias
EDITOR='nvim'

export JAVA_HOME=$(/usr/libexec/java_home)
PATH=./bin:~/bin:$HOME/.composer/vendor/bin:$PATH

# export BAT_THEME="OneHalfDark"
export BAT_THEME="OneHalfLight"

# export NVM_DIR="/Users/ijesus/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

source /Users/ijesus/.phpbrew/bashrc

eval "$(direnv hook bash)"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# PATH="/Users/ijesus/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/Users/ijesus/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/Users/ijesus/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/Users/ijesus/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/Users/ijesus/perl5"; export PERL_MM_OPT;

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
. $HOME/.asdf/installs/rust/1.41.1/env

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
