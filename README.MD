![Architecture Diagram](img/architecture.png)

<h1 align="center">Static Web Hosting on AWS Series: Terraform Modules & GitHub Actions</h1>
<h3 align="center"> The Codebase For The 6 Part Youtube Series</h3>

## Tech Stack

- Terraform
- GitHub
- AWS IAM
- Amazon S3
- Amazon DynamoDB
- AWS ACM
- AWS Route 53
- Amazon CloudFront

## The Series (6 Parts)

🔗 [Watch Now!](https://youtube.com/playlist?list=PLfmMgg_VrrlAz4s0UxLCdgZlcw2iCqVrD&si=p3g4-633yGeX12wQ)

## Overivew

Welcome to the comprehensive GitHub repository, the central hub for all Terraform reference files and GitHub Action YAML files needed for this extensive six-part project.

This project involves creating a CI/CD Pipeline using Terraform and GitHub Actions. You'll build 4 Terraform modules:

1. S3 Remote Backend: Set up remote storage for Terraform state files in an S3 bucket.
2. Route 53 and AWS ACM for DNS Settings: Configure DNS settings using AWS Route 53 and obtain an SSL certificate from AWS Certificate Manager for secure HTTPS connections.
3. S3 Website Hosting: Host your website on an S3 bucket.
4. CloudFront Distribution: Distribute your website content globally using CloudFront, Amazon's CDN service.

Your website will be deployed to an S3 bucket, which acts as the origin server. An Origin Access Control (OAC) will be used to restrict direct access to the S3 bucket, ensuring users access the content through CloudFront. You'll connect your domain name to this setup, enabling a user-friendly URL and HTTPS for secure browsing.

Additionally, you'll create a CI/CD pipeline with GitHub Actions, consisting of three main jobs:

1. Terraform Job: Deploys your infrastructure.
2. GitHub Action to Sync Files: Synchronizes your website files to the S3 bucket.
3. GitHub Action to Invalidate CloudFront Cache: Clears the CloudFront cache to ensure updated content is served

![Architecture Diagram](img/pipeline.png)

Every time you push website changes to GitHub, this workflow is triggered automatically. This makes the update process efficient as it removes the need to manually update the S3 bucket and clear the CloudFront cache, ensuring live changes are visible immediately.

The 6 Part Series shows you every step from the beginning. You'll also learn how to write Terraform code, including using variables, outputs, and how to create modules to keep your code clean and organized. This is key for managing your infrastructure efficiently. The CI/CD pipeline part makes website updates automatic and fast.

🔗 **Find the Complete Project**: Visit the GitHub repository [here](https://github.com/digitalden3/Static-Web-Hosting-on-AWS-Terraform-Modules-GitHub-Actions) for the full project and all the necessary code for the 'Static Web Hosting on AWS Series: Terraform Modules & GitHub Actions'.
