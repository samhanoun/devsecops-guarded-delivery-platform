# DevSecOps Guarded Delivery Platform

A production-minded DevSecOps portfolio project demonstrating secure software delivery with:

- CI/CD security gates (SAST, secrets, deps, containers)
- Policy-as-code enforcement (Kyverno + OPA)
- SBOM generation + image signing + attestation (cosign)
- OIDC-based cloud auth (no long-lived cloud keys)
- Release controls with auditable promotion rules
- Kubernetes baseline hardening and admission policies

## Architecture

1. Developer push/PR
2. Security pipeline executes in GitHub Actions
3. Policy checks block non-compliant artifacts
4. Signed image + provenance required before deploy
5. Kubernetes admission enforces runtime controls

## Included Modules

- `app/sample-service`: minimal service used as pipeline target
- `.github/workflows`: gated CI/CD workflow set
- `policies/kyverno`: admission & runtime security policies
- `policies/opa`: Conftest policies for IaC/manifests
- `terraform/aws`: OIDC trust and baseline security infra
- `k8s/base`: hardened deployment manifests
- `docs`: threat model, control map, and runbook

## Security Controls Demonstrated

- No privileged pods / no hostPath / no latest tags
- Required CPU/memory requests+limits
- Trivy + Grype + Gitleaks + Semgrep gates
- SBOM (Syft), signing (Cosign), provenance attestation
- Protected promotion only on passing controls

## Usage (high level)

1. Open PR -> run `security-ci.yml`
2. Fix findings until gates pass
3. Merge -> run `release-secure.yml`
4. Deploy only signed, attested image with policy compliance

See `docs/IMPLEMENTATION_GUIDE.md` for step-by-step.
