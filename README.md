# actions

Workflows to get your Flutter project as a web app with GitHub Pages.


## Steps

![Workflow steps](./docs/action-steps.drawio.svg)


## Feature Flags

The following flags are used to enable/disable features in the workflow

| Flag Name | Flag Description |
| :--: | :-- |
| `FF_STEP_CREATE_ISSUE` | Repository variable used to enable/disable the step '_Create issue in the forked repository_' |

## GitHub Action Workflow Inputs

The following inputs must be passed to the workflow

| Input Name | Input Description |
| :--: | :-- |
| `owner` | Owner of the repository to be forked |
| `repo` | Name of the repository to be forked |
| `fork-org` | Organization to where the repository must be forked |
| `run-id` | Identifier of the workflow run |


## Trigger GitHub Action Workflow
To manually trigger the GitHub Action workflow, we just need to run the following cURL command:


```bash
curl -L \
-X POST \
-H "Accept: application/vnd.github+json" \
-H "Authorization: Bearer <YOUR-TOKEN>"\
-H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/ukoreh/actions/actions/workflows/fork-clone-build-deploy.yaml/dispatches \
-d '{"ref":"<BRANCH-OR-TAG>","inputs":{"owner":"<OWNER>","repo":"<REPO> ","fork-org":"<FORK-ORG>","run-id":"<RUN-ID>"}}'\
 
```

Where the following values must be defined:

- `<YOUR-TOKEN>`: The GitHub user token.
- `<BRANCH-OR-TAG>`: The git reference for the workflow. The reference can be a branch or tag name.
- `<OWNER>`: The account owner of the repository to be forked.
- `<REPO>`: The name of the repository to be forked
- `<FORK-ORG>`: Organization to where the repository must be forked
- `<RUN-ID>`: Identifier of the workflow run