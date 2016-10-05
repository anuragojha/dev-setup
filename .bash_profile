# global exports

# set java version
if [ "$(uname)" == "Darwin" ]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# setup grid exports
# set HADOOP_HOME
# add oozie to PATH

# beef up the memory available to the hadoop client apps
# like hdfs, hive and pig
export HADOOP_CLIENT_OPTS=" -Xmx2048m $HADOOP_CLIENT_OPTS"

prompt_git_branch() {
    local branchName='';

    # Check if the current directory is in a Git repository.
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

        # Get the short symbolic ref.
        # If HEAD isnâ€™t a symbolic ref, get the short SHA for the latest commit
        # Otherwise, just give up.
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            echo '(unknown)')";

        echo "${branchName}";
    else
        return;
    fi;
}


prompt_git_status() {
    local s='';

    # Check if the current directory is in a Git repository.
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

            # Ensure the index is up to date.
            git update-index --really-refresh -q &>/dev/null;

            # Check for uncommitted changes in the index.
            if ! $(git diff --quiet --ignore-submodules --cached); then
                s+='+';
            fi;

            # Check for unstaged changes.
            if ! $(git diff-files --quiet --ignore-submodules --); then
                s+='!';
            fi;

            # Check for untracked files.
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s+='?';
            fi;

            # Check for stashed files.
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                s+='$';
            fi;

        fi;

        [ -n "${s}" ] && s=" [${s}]";

        echo "${s}";
    else
        return;
    fi;
}



function pretty_prompt {

    # Reset
    Color_Off="\[\033[0m\]"       # Text Reset

    # Regular Colors
    Black="\[\033[0;30m\]"        # Black
    Red="\[\033[0;31m\]"          # Red
    Green="\[\033[0;32m\]"        # Green
    Yellow="\[\033[0;33m\]"       # Yellow
    Blue="\[\033[0;34m\]"         # Blue
    Purple="\[\033[0;35m\]"       # Purple
    Cyan="\[\033[0;36m\]"         # Cyan
    White="\[\033[0;37m\]"        # White

    # Bold
    BBlack="\[\033[1;30m\]"       # Black
    BRed="\[\033[1;31m\]"         # Red
    BGreen="\[\033[1;32m\]"       # Green
    BYellow="\[\033[1;33m\]"      # Yellow
    BBlue="\[\033[1;34m\]"        # Blue
    BPurple="\[\033[1;35m\]"      # Purple
    BCyan="\[\033[1;36m\]"        # Cyan
    BWhite="\[\033[1;37m\]"       # White

    # Underline
    UBlack="\[\033[4;30m\]"       # Black
    URed="\[\033[4;31m\]"         # Red
    UGreen="\[\033[4;32m\]"       # Green
    UYellow="\[\033[4;33m\]"      # Yellow
    UBlue="\[\033[4;34m\]"        # Blue
    UPurple="\[\033[4;35m\]"      # Purple
    UCyan="\[\033[4;36m\]"        # Cyan
    UWhite="\[\033[4;37m\]"       # White

    # Background
    On_Black="\[\033[40m\]"       # Black
    On_Red="\[\033[41m\]"         # Red
    On_Green="\[\033[42m\]"       # Green
    On_Yellow="\[\033[43m\]"      # Yellow
    On_Blue="\[\033[44m\]"        # Blue
    On_Purple="\[\033[45m\]"      # Purple
    On_Cyan="\[\033[46m\]"        # Cyan
    On_White="\[\033[47m\]"       # White

    # High Intensty
    IBlack="\[\033[0;90m\]"       # Black
    IRed="\[\033[0;91m\]"         # Red
    IGreen="\[\033[0;92m\]"       # Green
    IYellow="\[\033[0;93m\]"      # Yellow
    IBlue="\[\033[0;94m\]"        # Blue
    IPurple="\[\033[0;95m\]"      # Purple
    ICyan="\[\033[0;96m\]"        # Cyan
    IWhite="\[\033[0;97m\]"       # White

    # Bold High Intensty
    BIBlack="\[\033[1;90m\]"      # Black
    BIRed="\[\033[1;91m\]"        # Red
    BIGreen="\[\033[1;92m\]"      # Green
    BIYellow="\[\033[1;93m\]"     # Yellow
    BIBlue="\[\033[1;94m\]"       # Blue
    BIPurple="\[\033[1;95m\]"     # Purple
    BICyan="\[\033[1;96m\]"       # Cyan
    BIWhite="\[\033[1;97m\]"      # White

    # High Intensty backgrounds
    On_IBlack="\[\033[0;100m\]"   # Black
    On_IRed="\[\033[0;101m\]"     # Red
    On_IGreen="\[\033[0;102m\]"   # Green
    On_IYellow="\[\033[0;103m\]"  # Yellow
    On_IBlue="\[\033[0;104m\]"    # Blue
    On_IPurple="\[\033[10;95m\]"  # Purple
    On_ICyan="\[\033[0;106m\]"    # Cyan
    On_IWhite="\[\033[0;107m\]"   # White

    local HOST=`hostname`

    # user@host
    # if headless user, set color to red

    USER_COLOR=${Cyan}
    if [ "$LOGNAME" != "`whoami`" ]; then
        USER_COLOR=${BRed}
    fi

    PS1="${USER_COLOR}\u${Color_Off}@${BBlue}${HOST}"

    # :screen_name if within screen session
    if [ "$TERM" == "screen" ]; then
        PS1="$PS1${Color_Off}:${BCyan}screen"
    fi

    # dir
    PS1="$PS1 ${Color_Off}\w"

    # git branch
    # [aojha@Mac ~/dev/project (master [?])
    GIT_BRANCH="$(prompt_git_branch)"
    GIT_STATUS="$(prompt_git_status)"
    if [[ "$GIT_BRANCH" ]]; then
        PS1="$PS1 ${Green}(${GIT_BRANCH}${Red}\${GIT_STATUS}${Green})"
    fi

    # delimiter
    # [aojha@Mac ~/dev/project (master [?])]$
    PS1="$PS1${Color_Off}]\n\$ "
}

PROMPT_COMMAND=pretty_prompt

# download and install the latest .bash_profile
function bpupdate() {
    curl -fsSL https://raw.githubusercontent.com/anuragojha/dev-setup/master/.bash_profile -o $HOME/.bash_profile
    source ~/.bash_profile
}

# Generic Aliases
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    alias ll='ls -laG'                                       # List all file in long list format
    alias ls='ls -G'
else
    alias ll='ls -la --color=auto'                           # List all file in long list format
    alias ls='ls --color=auto'
fi

alias h='hostname'                                           # list hostname
alias hp='echo "`hostname`:`pwd`"'                           # list hostname with path to currect directory
alias ..='cd ..'                                             # Go up one directory
alias ...='cd ../..'                                         # Go up two directories
alias ....='cd ../../..'                                     # Go up three directories
alias -- -='cd -'                                            # Go back
alias c='clear'                                              # Clear Screen
alias k='clear'                                              # Clear Screen
alias cls='clear'                                            # Clear Screen
alias _="sudo"                                               # Execute with sudo
alias q='exit'                                               # Logout
alias vi='vim'                                               # launch vim


function disable() {
    case "$1" in
        "indexing")    
            sudo mdutil -a -i off
            ;;
            
    esac
}

function enable() {
    case "$1" in
        "indexing")    
            sudo mdutil -a -i on
            ;;
            
    esac
}


# screen
alias scl='screen -ls'

function scr() {
   if [ $@ ]; then
      screen -r $@
   else
      screen -r
   fi
}

function scd() {
  if [ $@ ]; then
     screen -d $@
  else
     screen -d
  fi
}


# decompress/ decode/ prettyfy
alias deflate="perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'"   # decompress/ deflate
alias escape="perl -p -MURI::Escape -e 'y/+/ /;$_=uri_escape$_'"            # url escape
alias unescape="perl -p -MURI::Escape -e 'y/+/ /;$_=uri_unescape$_'"        # url unescape
alias prettyxml="xmllint --format -"                                        # xml lint
alias prettyjson="python -mjson.tool"                                       # json lint


# email
# SET alias mailme=?



# git aliases
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias go='git checkout'
alias gp='git pull'

function gbgo() {
    git branch $@
    git checkout $@
}

alias gbo='gbgo'



# hdfs
alias d="hdfs dfs"                                         # Base Hadoop fs command
alias dcat="d -cat"                                        # Output a file to standard out
alias dtext="d -text"                                      # Decompress zip, deflate and TextRecordInputStream
alias dchgrp="d -chgrp"                                    # Change group association of files
alias dchmod="d -chmod"                                    # Change permissions
alias dchown="d -chown"                                    # Change ownership
alias dcfl="d -copyFromLocal"                              # Copy a local file reference to HDFS
alias dctl="d -copyToLocal"                                # Copy a HDFS file reference to local
alias dcount="d -count"
alias dcp="d -cp"                                          # Copy files from source to destination
alias ddu="d -du"                                          # Display aggregate length of files
alias ddus="d -dus"                                        # Display a summary of file lengths
alias dext="d -expunge"                                    # Remove/Empty the trash
alias dget="d -get"                                        # Get a file from hadoop to local
alias dgetm="d -getmerge"                                  # Get files from hadoop to a local file
alias dls="d -ls"                                          # List files
alias dll="d -lsr"                                         # List files recursivly
alias dmkdir="d -mkdir"                                    # Make a directory
alias dmfl="d -moveFromLocal"                              # Move a local file reference to HDFS
alias dmtl="d -moveToLocal"                                # Move a HDFS file reference to local
alias dmv="d -mv"                                          # Move a file
alias dput="d -put"                                        # Put a file from local to hadoop
alias drm="d -rm"                                          # Remove a file
alias drmr="d -rmr"                                        # Remove a file recursively
alias dsr="d -setrep"                                      # Set the replication factor of a file
alias dstat="d -stat"                                      # Returns the stat information on the path
alias dtail="d -tail"                                      # Tail a file
alias dtest="d -test"                                      # Run a series of file tests. See options
alias dtest="d -stat"
alias dtouchz="d -touchz"                                  # Create a file of zero length

# additional aliases/functions
alias hct='hdfs dfs -cat'
alias dcat='hdfs dfs -cat'
alias hfs='hdfs dfs'
alias hls='hdfs dfs -ls'

function ddub() {                                           # Display aggregate size of files descending
   hdfs dfs -du "$@" | sort -k 1 -n -r
}

function dbzcat() {                                          # hdfs cat and decompress using bzcat
   hdfs dfs -cat "$@" | bzcat
}

function dzcat() {                                           # hdfs cat and decompress using bzcat
   hdfs dfs -cat "$@" | zcat
}

function ddeflate() {                                        # hdfs cat and decompress using deflate
   echo "Use dtext command instead."
   hdfs dfs -cat "$@" | perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'
}



# hadoop/mapreduce
alias mj="mapred job"                                        # Base Hadoop job command
alias mjstat="mj -status"                                    # Print completion percentage and all job counters
alias mjkill="mj -kill"                                      # Kills the job
alias mjhist="mj -history"                                   # Prints job details, failed and killed tip details
alias mjlist="mj -list"                                      # List jobs

alias mq="mapred queue"                                      # Base Hadoop job command
alias mqacl="mq -showacls"                                   # Displays list of queue user can submit jobs

# yarn
alias ya="yarn application"                                  # Base yarn application command
alias yal="ya -list"                                         # Lists applications from the RM.
alias yas="ya -status"                                       # Prints the status of the application.
alias yak="ya -kill"                                         # Kills the application.

# oozie
# set OOZIE_CLIENT_HOME
# set OZSRVR

alias oj="$OOZIE_CLIENT_HOME/bin/oozie job -oozie ${OZSRVR} -auth KERBEROS -len 10000"         # Base oj command
alias ojs="$OOZIE_CLIENT_HOME/bin/oozie jobs -oozie ${OZSRVR} -auth KERBEROS -len 10000"       # Base ojs command
alias owv="$OOZIE_CLIENT_HOME/bin/oozie validate"                                   # Validate a workflow xml
alias ojrun="oj -run"                                        # Run a job
alias ojresume="oj -resume"                                  # Resume a job
alias ojrerun="oj -rerun"                                    # Rerun a job
alias ojsuspend="oj -suspend"                                # Suspend a job
alias ojkill="oj -kill"                                      # Kill a job
alias ojinfo="oj -info"                                      # Display current info on a job
alias oji="ojinfo"
alias ojlist="ojs -localtime"                                # Display a list of jobs
alias ojlistr="ojs -localtime -filter status=RUNNING"        # Display a list of running jobs
alias ojwf='ojs'                                             # Display list of running workflows
alias ojcoord='ojs -jobtype coordinator '                    # Display list of coordinators
alias ojco='ojcoord'
alias ojbu='ojs -jobtype bundle'                             # Display list of bundles


# hive
HIVE_CMD="hive \
        -hiveconf mapreduce.job.acl-modify-job=* \
        -hiveconf mapreduce.job.acl-view-job=* \
        -hiveconf hive.cli.print.current.db=true \
        -hiveconf hive.cli.print.header=true \
        -hiveconf hive.exec.dynamic.partition.mode=nonstrict"
alias hivecli='$HIVE_CMD'


# pig alias
# set PIG_HOME
PIG_VER=0.14

PIG_CMD="$PIG_HOME/bin/pig \
        -useHCatalog \
        -param PIG_HOME=$PIG_HOME \
        -Dmapreduce.job.acl-view-job=* \
        -Dfs.permissions.umask-mode=002 \
        -Dmapreduce.map.speculative=true \
        -Dmapreduce.output.fileoutputformat.compress=true \
        -Dmapreduce.output.fileoutputformat.compress.codec=org.apache.hadoop.io.compress.BZip2Codec \
        -Dmapreduce.fileoutputcommitter.marksuccessfuljobs=true "

PIG_CMD_BIG="$PIG_CMD \
        -Dpig.maxCombinedSplitSize=2147483648 \
        -Dmapreduce.job.split.metainfo.maxsize=20000000 \
        -Dmapreduce.reduce.memory.mb=3072 \
        -Dmapreduce.map.memory.mb=3072 \
        -Dmapreduce.map.java.opts=\"-Xmx2560M\" "


alias pigcli='$PIG_CMD'
alias pigcli_big='$PIG_CMD_BIG'


# hbase
function hbc()
{
    echo "create '$1', {NAME => '$2', COMPRESSION => 'GZ', BLOCKSIZE => '1048576'};" \
         "grant '$USER', 'RWXCA', '$1';"    \
         "grant '`whoami`', 'RWXCA', '$1';" | hbase shell
}

function hbd()
{
    echo "disable '$@';" \
         "drop '$@';"    | hbase shell
}
