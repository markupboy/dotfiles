#advanced git
getBranch() {
	if [[ -n "$1" ]]; then
		branch=$1
	else 
		st="$(git status 2>/dev/null)"
		arr=(${(f)st})
		__CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
		branch=$__CURRENT_GIT_BRANCH
	fi
	echo $branch
}

remaster () { 
	branch=`getBranch $1`
	git checkout master; pull; checkout $branch; rebase master; 
}
mergepush () { 
	branch=`getBranch $1`
	git checkout master; merge $branch; push; checkout $branch; 
}