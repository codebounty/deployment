# Deployment scripts

This repository is for deployment scripts and procedures.

# Front Site

The front site is hosted as an S3 bucket `codebounty` static [website](codebounty.s3-website-us-east-1.amazonaws.com) distributed through the CloudFront CDN.

1. Build and test the site locally with `grunt server:dist`.
2. [Upload](https://console.aws.amazon.com/s3/home?region=us-west-2) the dist folder to a new S3 bucket (ex. `codebounty-site-1`) located in the `US Standard` region.
3. Make everything in the bucket public.
4. Change `styles/main.css` Content-Type to `text/css`.
5. Make the bucket a static website with the Index Document: `index.html` and check the endpoint site works!
6. Switch the [cloudfront](https://console.aws.amazon.com/cloudfront/home?region=us-west-2#distribution-settings:E2J123OQI81SEZ) Origin Domain Name (under Origins) to the new bucket site.
7. Invalidate everything (`/`).