function grm --description 'git rm every file git reports as deleted'
    git status | grep deleted | awk '{print $3}' | xargs git rm
end
