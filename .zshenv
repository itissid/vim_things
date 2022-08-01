# for non interactive shells only
export PATH=~/bin:$PATH

# For pyenv
#export PATH="/home/sid/.pyenv/bin:$PATH"
#eval "$(pyenv init -)" || echo ""
#eval "$(pyenv virtualenv-init -)" || echo ""

#(FIXME: Make his for mac only) For java home in my mac osx
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH=$(/usr/libexec/java_home -v 1.8)/bin:$PATH
# For maven
if [ -f "/usr/local/apache-maven/bin/mvn" ]; then
    export PATH=$PATH:/usr/local/apache-maven/bin/
fi

# Temporary
export iview_2017=~/Dropbox/workspace/iview_2017/python/interactive-coding-challenges/

# For solr
export SOLR_HOME="${HOME}/opt/solr-4.7.0"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH
