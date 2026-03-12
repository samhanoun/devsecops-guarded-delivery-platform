# Implementation Guide

## 1) Set repository protections
- Require PR reviews
- Require status checks from all security workflows
- Block force-push to main

## 2) Configure OIDC cloud trust
- Use Terraform under `terraform/aws/oidc`
- Bind GitHub repo/environment claims to IAM role trust policy

## 3) Enable security workflows
- `security-ci.yml` on PR
- `release-secure.yml` on main/release tags

## 4) Enforce admission policy
- Apply Kyverno policies in `policies/kyverno`
- Reject unsigned images / privileged pods / latest tags

## 5) Runbook
- On failed gate: classify (critical/high/medium)
- Remediate by source type (code/deps/container/iac)
- Re-run pipeline, then promote
