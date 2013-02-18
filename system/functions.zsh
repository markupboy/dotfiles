function glog () {
	(echo "$1:`pwd`";grep -v "`pwd`$" ~/.gitlogger) | sort > ~/.gitlogger.tmp
	mv ~/.gitlogger.tmp ~/.gitlogger
}