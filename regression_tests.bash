#!/usr/bin/env bash

current_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)

projects=(       
    'freitas-labs/flutter-extended-image-crop-info-callback-spike'
    'FCT-LOLU/smartshoeapp'
    'abdulmoizshaikh/Flutter-project-2-quiz-app'
    'KhongKevin/Carded_Mobile_Application'
    'nimnagunasekera/To-Do-App'
    'Pimbad/echo-store'
    'KhongKevin/Carded_Mobile_Application'
    'BenferhatAymen/Gamify-UI-App'
    'Kashiwara0205/flutter_samples'
    'whosjorge23/formula_one_calendar'
    'codeforany/food_delivery_flutter_3_ui'
    'musamairshad/Expense-Tracker-App'
    'Jinwook-Song/flutter_animations'
    'Jane-Mwangi/askAnything'
    'hrithik-b/schoolwale'
    'ksokolovskyi/airbnb_passport'
    'floranguyen0/mmas-money-tracker'
)

fork_org='flutter-preview'

function trigger_deploy() {
    owner="$1"
    repo="$2"
    fork_org="$3"

    curl -L -X POST   \
    -H "Accept: application/vnd.github+json"   \
    -H "Authorization: Bearer $GITHUB_PAT"  \
    -H "X-GitHub-Api-Version: 2022-11-28"   \
    https://api.github.com/repos/ukoreh/actions/actions/workflows/fork-clone-build-deploy.yaml/dispatches   \
    -d "{\"ref\":\""$current_branch"\",\"inputs\":{\"owner\":\""$owner"\",\"repo\":\""$repo"\",\"fork-org\":\""$fork_org"\",\"run-id\":\"Test1\"}}"
}

declare owner repo

for fields in ${projects[@]}
do
        IFS=$'/' read -r owner repo <<< "$fields"

        echo "Triggering deploy of repo $fields (url: https://$fork_org.github.io/$owner-$repo/index.html)"
        
        trigger_deploy $owner $repo $fork_org
        sleep 5
done