# Static Web Hosting on AWS Series: Terraform Modules & GitHub Actions

![Architecture Diagram](img/architecture.png)

## Overview

This project demonstrates how to deploy a static website on AWS using Terraform and GitHub Actions. The infrastructure includes:

- S3 bucket for website hosting
- CloudFront distribution for content delivery
- Route 53 for DNS management
- AWS Certificate Manager for SSL/TLS certificates
- GitHub Actions for CI/CD pipeline

## Architecture

The architecture follows AWS best practices for hosting static websites:

1. **S3 Remote Backend**: Stores Terraform state securely
2. **Route 53 & AWS ACM**: Manages DNS and SSL certificates
3. **S3 Website Hosting**: Stores the static website files
4. **CloudFront Distribution**: Delivers content globally with low latency

## CI/CD Pipeline

The GitHub Actions workflow automates the deployment process:

1. **Terraform**: Deploys the infrastructure
2. **S3 Sync**: Uploads website files to the S3 bucket
3. **CloudFront Invalidation**: Ensures the latest content is served

## Configuration

The project uses the following AWS resources:

- Domain: static-website-cicd.dev.cloudza.tech
- S3 Bucket: static-website-test-cz1
- CloudFront Distribution: E1ZN3HIGD83NPO
- Route 53 Hosted Zone: Z10183843D76HHT0RJ5MI
- IAM Role: arn:aws:iam::459573696753:role/OIDC-cicd-static-provider

## Getting Started

1. Clone this repository
2. Configure AWS credentials
3. Update terraform.tfvars with your values
4. Push to GitHub to trigger the deployment pipeline

## Tech Stack

- Terraform
- GitHub Actions
- AWS IAM
- Amazon S3
- Amazon DynamoDB
- AWS ACM
- AWS Route 53
- Amazon CloudFront