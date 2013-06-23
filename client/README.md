# Client side scripts

## Configuration

Change configuration accordingly in `config.sh`.

## Commands

* cb-settings-update: Update settings.json file on server side
* cb-repo-list: List all available meteor bundles
* cb-repo-deploy: Deploy a specific bundle

## Generate new bundle

1. In the working directory, `git remote add ec2 codebounty@app.codebounty.co:~/codebounty.git`
2. `git push ec2 master`
3. A new bundle of `refs/heads/master` will be automatically generated. (**NOTICE**: only changes to master branch will trigger generation and only one generation per push)