# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[ -r /home/amresh/.byobu/prompt ] && . /home/amresh/.byobu/prompt   #byobu-prompt#

# USER COMMANDS

alias cdp4c='cd ~/bf-p4c-compilers'
alias cdp4cbld='cdp4c && cd build'
alias pushdd='pushd `pwd`'

debug=false

# Git prompt
source ~/.git-prompt.sh

export MAKEFLAGS='-j6'

export MHOME="${HOME}/Desktop/Parallels Shared Folders/Home"
export MDLDS=$MHOME/Downloads

# All paths relative to $WORK
export WORK=~/

export P4C=$WORK/bf-p4c-compilers
export P4CTST=$P4C/p4-tests
export P4CBLD=$P4C/build
export BRIGBLD=$P4CBLD/p4c
export TSM=$P4C/bf-asm
export TSMTST=$TSM/test
export TSMBLD=$P4CBLD/bf-asm
export MODEL=$WORK/model
export P4F=$WORK/p4factory
export BLD_P416=$P4C/build/tofino/extensions/p4_tests/p4_16
export TST_P416=$P4C/extensions/p4_tests/p4_16
export TST_P414=$P4C/extensions/p4_tests/p4_14
export SCHEMA=$TSM/tofino/chip.schema

# Aliases
alias llr='ls -lr'
alias lrt='ls -lrt'
alias h='history'
alias vi='vim'
alias sb='source ~/.bashrc'
alias vb='vim ~/.bashrc'
alias tmux='tmux -2' #Force tmux to use 256 colors
alias make='make -j6'
alias mkcc='make -j4 CC="ccache gcc" CXX="ccache g++"'
alias g='grep -InHs --exclude-dir="\.git" --exclude="tags"'
alias gr='g -R'
alias gdb='gdb -q'

# Switch dir aliases
alias cdwork='cd $WORK'
alias cdp4c='cd $P4C'
alias cdp4cbld='cd $P4CBLD'
alias cdasm='cd $TSM'
alias cdasmtst='cd $TSMTST'
alias cdmodel='cd $MODEL'
alias cdglass='cd $P4C/glass'
alias cdp4f='cd $P4F'
alias cdtorbld='cd $P4CBLD/p4c/tofino/extensions/p4_tests/p4_16/google-tor/p4/spec/'

alias mksth='cd $MODEL/build/tests/simple_test_harness && make && cd -'
alias ma='cd $TSM && mkcc && cd -'
alias mad='cd $TSM/build/ && mkcc && cd -'

# Git aliases
alias gs='git status'
alias gst='git stash'
alias gsts='git stash show -p'
alias gsta='git stash apply'
alias gl='git log'
alias gll='git log --stat'
alias glll='git log --full-diff -p'
alias glf='git log -p'
alias gd='git diff'
alias gdd='git diff --cached'
alias gdm='git diff master'
alias gp='git pull'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add -u'
alias gcm='git commit'
alias gca='git commit --amend'
alias gsu='git submodule update --init --recursive'
alias gsuh='git submodule deinit -f . && gsu'
alias gcmd='git cherry -v master'
alias gcl='git clean -fxd'
alias gbd='git branch -d'
alias gbdall='git branch | grep -v "master" | xargs git branch -D'

gclo () {
    git clone git@github.com:barefootnetworks/$1.git
}
# checkout prev (older) revision
git_prev() {
    git checkout HEAD~
}

# checkout next (newer) commit
git_next() {
    BRANCH=`git show-ref | grep $(git show-ref -s -- HEAD) | sed 's|.*/\(.*\)|\1|' | grep -v HEAD | sort | uniq`
    HASH=`git rev-parse $BRANCH`
    PREV=`git rev-list --topo-order HEAD..$HASH | tail -1`
    git checkout $PREV
}

# Debug aliases

# Misc aliases
alias fj="find . -name 'json_diff.txt' | xargs grep"

# Bash functions
gf () {
    find $1 -name $2 | xargs grep $3 
}

mcd () {
    mkdir -p $1
    cd $1
}

cbcheck () {
    cd $P4CBLD
    make check
    cd -
}

cb () {
    cd $P4CBLD
    mkcc
    cd -
}

gcb () {
    pushd `pwd`
    cdp4c
    #rm -rf $P4CBLD
    #./bootstrap_bfn_env.sh
    ccache -C
    #./bootstrap_bfn_compilers.sh CXXFLAGS="'-g -O0'" CFLAGS="'-g -O0'"
    #export CXXFLAGS="$CXXFLAGS -fno-limit-debug-info"
    #export CFLAGS="$CFLAGS -fno-limit-debug-info"
    ./bootstrap_bfn_compilers.sh -DCMAKE_BUILD_TYPE=Debug 
    cd $P4CBLD
    mkcc
    popd
}

abcheck () {
    cd $TSMBLD
    make tests
    cd -
}

ab () {
    cd $TSMBLD
    mkcc
    cd -
}

gab () {
    pushd `pwd`
    cdasm
    autoreconf -i
    mcd $P4CBLD
    rm -rf $TSMBLD 
    mcd  $TSMBLD
    ccache -C
    $TSM/configure CXXFLAGS='-g -O0' CFLAGS='-g -O0'
    mkcc
    popd
}

TSMTSTS="asm/*.tfa *.p4 mau/*.p4" 
TSMSTFTSTS="stf/*.stf"
# Run all tests with glass
raa () {
    pushd $TSMTST
    $TSMTST/runtests -j8 $@ $TSMTSTS
    $TSMTST/runtests -j8 -b $@ $TSMSTFTSTS
    popd
}

# Run all tests 
ra () {

    raa -f $@
}

# Run single/multiple tests with/without glass
rt () {
    pushd $TSMTST
    $TSMTST/runtests -j8 -v $@
    popd
}

# Find sth 
find_sth () {
    STH="simple_test_harness"
    STHDIR=$MODEL
    if [ -d "$MODEL/debug/" ]; then
        STHDIR="$MODEL/debug/"
    fi
    STH=`find $STHDIR -name $STH -type f -executable -print -quit`
    if [ -z $STH ]; then
        echo "$STH not found"
    else
        echo "Using $STH"
    fi
}

# Find brig 
find_brig () {
    BRIG=""
    if [ -f $BRIGBLD/p4c-tofino ]; then
        BRIG=$BRIGBLD/p4c-tofino
    fi
}

# Find tfas
find_tfas () {
    TFAS=""
    if [ -f $TSMBLD/tfas ]; then
        TFAS=$TSMBLD/tfas
    elif [ -f $TSM/tfas ]; then
        TFAS=$TSM/tfas
    fi
}

# Find tfa
find_tfa () {
    TFA=""
    if [ -f `pwd`/$@.out/brig/out.tfa ]; then
        TFA=`pwd`/$@.out/brig/out.tfa
    elif [ -f `pwd`/$@ ]; then
        TFA=`pwd`/$@
    fi
}

# Find glass 
find_glass () {
    GLASS=""
    if [ -d $P4C/glass ]; then
        GLASS=$P4C/glass
    elif [ -d $WORK/p4c-tofino ]; then
        GLASS=$WORK/p4c-tofino
    fi
    echo "Using $GLASS"
}

# Run single assembly test only
rat () {
    find_tfas
    find_tfa $@
    p="${1%.*}"
    f="${1##*/}"
    fn="${f%.*}"
    $DBG $TFAS -g -vvvvl $fn.tfas.log $TFA
}

# Run asm test invoking gdb
grat () {
    sdm true
    rat $@
    sdm false
}

# Run brig only
rbt () {
    find_brig
    p="${1%.*}"
    o=$p.out
    set -x
    $DBG $BRIG -D__TARGET_TOFINO__ --p4-14 --top4 FrontEndLast $1 -o $p.tfa
    set +x
}

# Run brig test invoking gdb
grbt () {
    sdm true
    rbt $@
    sdm false
}

# Run glass only
rgt () {
    find_glass
    p="${1%.*}"
    o=$p.out
    $GLASS/p4c_tofino/shell.py -o $o --verbose 2 -vl 2 -S -G --gen_json --placement-order ingress_before_egress $1
}

sdm() {
    if [ "$1" = true ]; then
        DBG="gdb -q --args"
        #DBG="lldb -- "
    else
        DBG=""
    fi
}

# Run model only
rmt () {
    find_sth
    p="${1%.*}"
    f="${1##*/}"
    fn="${f%.*}"
    d=$p.out/$fn.out
    if [ -d $d ]; then
        $DBG $STH -l $d $1 
    else
        echo "No $d dir present"
    fi
}

grmt () {
    sdm true
    rmt $@
    sdm false
}

# Check json diffs for regs
# Add reg value line after fixing
jdcheck () {
    fj meter_alu_right_group_delay
    fj meter_alu_group_ecc_error_enable
    fj salu_enable
    fj salu_datasize
    fj salu_op_dual
    fj salu_asrc_memory
    fj salu_pred
    fj salu_asrc_memory_index
    fj default_action
    fj default_only_action
    fj default_action_parameters
    fj mau_immediate_data_miss_value
    fj exact_match_logical_result_delay
    fj po_action_row
    fj dual_width_mode
    fj stateful_alu_width
    fj set_instr | grep -v null
    fj clr_instr | grep -v null
    fj bound_to_stateful_table_handle  | grep -v null
    fj bound_to_selection_table_handle | grep -v null
    fj disallowed_as_default_action_reason
    fj allowed_to_be_default_action
}

viall () {
    p="${1%.*}"
    f="${1##*/}"
    fn="${f%.*}"
    vi -O $@.p4 $@.out/out.tfa $@.out/context/context.json $@.out/$fn.out/tbl-cfg
}

# View p4 and asm file in vsplit mode
viasm () {
    vi -O $@.p4 $@.out/out.tfa
}

# View glass and brig context jsons in vsplit mode 
vicjson () {
    p="${1%.*}"
    f="${1##*/}"
    fn="${f%.*}"
    vi -O $@.out/context/mau.context.json $@.out/$fn.out/tbl-cfg
}

# View glass and brig new context jsons in vsplit mode 
vincjson () {
    p="${1%.*}"
    f="${1##*/}"
    fn="${f%.*}"
    vi -O $@.out/context/context.json $@.out/$fn.out/tbl-cfg
}

# View brig p4, asm and context jsons in vsplit mode 
vibrig () {
    vi -O $@.p4 $@.out/brig/out.tfa $@.out/brig/tbl-cfg
}

# View glass p4, asm and context jsons in vsplit mode 
viglass () {
    vi -O $@.p4 $@.out/glass/out.tfa $@.out/glass/context/context.json
}

# Run test file and gen new context json and proto file
rp4c () {
    t=`realpath $1`
    p=$(dirname "${t}")
    opath="${t%.p4.test}"
    set -x
    $t "--p4runtime-format text --p4runtime-file $opath.out/p4info.proto.txt " -v
    set +x
}

# Run model with test p4_name_lookup  
ptf_model () {
    opath=`find $P4C/build $P4C/p4c -name $1.out -print -quit`
    set -x
    sudo tofino-model -l $opath/p4_name_lookup.json
    set +x
}

# Run drivers with switch profile
ptf_driver () {
    set -x
    sudo bf_switchd --install-dir /usr/local --conf-file $P4CTST/dummy.conf --skip-p4 $*
    set +x
}

# PTF update config command for a test
ptf_update_cfg () {
    opath=`find $P4C/build $P4C/p4c -name $1.out -print -quit`
    set -x
    $P4CTST/ptf_runner.py --testdir $opath --name $1 --update-config-only
    set +x
}

# Run PTF test
ptf_run () {
    name=$1
    shift
    td=`find $P4CTST/ -name $name.ptf`
    opath=`find $P4C/build $P4C/p4c -name $name.out -print -quit`
    set -x
    sudo $P4CTST/ptf_runner.py --testdir $opath --name $name --ptfdir $td --test-only $*
    set +x
}

# Enable/Disable PTF
stf2ptf () {
    pushd `pwd`
    cd $P4CBLD
    set -x
    cmake .. -DENABLE_STF2PTF=$1
    make -j4
    set +x
    popd
}

stf2ptf_on () {
    stf2ptf ON
}

stf2ptf_off () {
    stf2ptf OFF
}

cdtest () {
    t=`find $P4CBLD/p4c/tofino -name $1.p4.test`
    td=$(dirname "${t}")
    cd $td
}

vtfail () {
    vi $P4CTST/TofinoXfail.cmake
}

walle_run () {
    name=$1
    opath=`find $P4C/build $P4C/p4c -name $name.out -print -quit`
    set -x
    walle --schema $SCHEMA -o $opath/tofino.bin $opath/*.cfg.json
    set +x
}

gdb_setup () {
    pushd `pwd`
    cd $P4CBLD/p4c/extensions/bf-p4c
    ln -s ../../p4include
    ln -s ../../p4_14include
    popd
}
