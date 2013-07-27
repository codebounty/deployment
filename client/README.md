# Client side scripts

## Configuration

Change configuration accordingly in `config.sh`.

## Commands

* cb-settings-update: Update settings.json file on server side
* cb-repo-list: List all available meteor bundles
* cb-repo-deploy: Deploy a specific bundle

## Generate new bundle

1. In the working directory, `git remote add ec2 deploymentuser@app.codebounty.co:codebounty.git`
2. `git remote add ec2-test deploymentuser@x.codebounty.co:codebounty.git`
3. `git push ec2 master`
4. A new bundle of `refs/heads/master` will be automatically generated. (NOTICE: only changes to master branch will trigger generation and only one generation per push)
5. New bundle will only automatically be deployed to testing server (when you push to ec2-test)
