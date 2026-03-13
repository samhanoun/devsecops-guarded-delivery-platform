# Detailed Technical Explanation — Project 1

## Project
**DevSecOps Guarded Delivery Platform**

This document explains exactly what was implemented, why each control exists, and how to run/extend it.

---

## 1) Security CI Gates (`.github/workflows/security-ci.yml`)

### What it does
On PR/workflow dispatch, the pipeline executes:
1. checkout
2. Node setup
3. dependency install
4. secret scan (Gitleaks)
5. SAST scan (Semgrep)
6. dependency vulnerability gate (`npm audit --audit-level=high`)
7. policy-as-code check via Conftest against `policies/opa`

### Why it matters
This enforces **shift-left** security. Risky changes are blocked before merge.

### How to use
- Open a PR with an intentional issue (secret-like string, vulnerable dep, insecure manifest)
- Confirm the relevant gate fails
- Fix, push, confirm green pipeline

---

## 2) Release Security Workflow (`.github/workflows/release-secure.yml`)

### What is implemented
A secure release workflow scaffold with placeholders for:
- image build
- SBOM generation
- image signing
- provenance attestation

### Why placeholders were used
This keeps the architecture real while avoiding false assumptions about your final registry/provider setup.

### How to operationalize
Replace placeholders with concrete commands:
- `syft` for SBOM
- `cosign sign` for signing
- `cosign attest` for provenance
- enforce deploy only from signed/attested artifacts

---

## 3) Kyverno Admission Policies (`policies/kyverno`)

### `require-resources.yaml`
Enforces CPU/memory requests and limits on pods.

### `disallow-latest.yaml`
Blocks image references using `:latest`.

### Why
- resource rules prevent noisy-neighbor instability and unschedulable workloads
- no latest tag ensures reproducibility and rollback safety

---

## 4) OPA/Conftest Policy (`policies/opa/k8s.rego`)

### Rules included
- Deployments must run containers with `runAsNonRoot=true`
- Disallow `:latest` image tags

### Why
CI-level policy checks catch noncompliant manifests before cluster admission.

---

## 5) Hardened Kubernetes Deployment (`k8s/base/deployment.yaml`)

### Security settings implemented
- `runAsNonRoot: true`
- `allowPrivilegeEscalation: false`
- `readOnlyRootFilesystem: true`
- explicit resources (requests/limits)

### Why
These settings provide practical pod hardening and runtime stability.

---

## 6) Documentation and Threat Model

### Files
- `docs/THREAT_MODEL.md`
- `docs/IMPLEMENTATION_GUIDE.md`
- `README.md`

### Role
- Threat model describes realistic attack surfaces and controls
- Implementation guide gives deployment sequence
- README provides technical + recruiter-facing narrative

---

## 7) Suggested Next Hardening Steps

1. Add Trivy/Grype container scanning in CI
2. Upload Semgrep/Gitleaks findings as SARIF
3. Wire keyless signing via OIDC
4. Add admission policy for signed images only
5. Add environment promotion controls (dev→staging→prod)

---

## 8) Interview-ready summary

> I implemented a guarded software delivery pipeline where changes must pass secret scanning, SAST, dependency checks, and policy-as-code gates. I also added Kubernetes admission policies and hardened deployment defaults so insecure artifacts/configurations are blocked before production.
