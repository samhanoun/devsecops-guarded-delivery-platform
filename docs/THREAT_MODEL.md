# Threat Model (STRIDE-style summary)

## Key Risks
- Credential leakage in CI/CD
- Dependency and container supply-chain compromise
- Privilege escalation in Kubernetes runtime
- Unsigned artifact deployment
- Unsafe infra changes bypassing review

## Controls
- OIDC federation for cloud auth (no static cloud keys)
- Mandatory SAST/secrets/dependency/container scan gates
- SBOM + image signature + provenance checks
- Admission control with Kyverno policies
- Branch protection + required checks + CODEOWNERS

## Residual Risks
- Zero-day in dependencies/tools
- Misconfigured runner hardening
- Policy drift if governance bypassed
