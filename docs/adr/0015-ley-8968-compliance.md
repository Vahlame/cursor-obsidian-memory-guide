# ADR-0015: Document Ley 8968 (Costa Rica) compliance posture for education-adjacent deployments

- **Status:** Accepted
- **Date:** 2026-05-13
- **Deciders:** maintainer

## Context

Downstream case studies (for example MEP-CR style deployments) may process **personal data of students or teachers**. Costa Rica’s **Ley 8968** and its regulations impose duties on controllers and processors: purpose limitation, minimization, retention, security measures, and documentation.

## Decision

Document a **baseline compliance narrative** in repository docs: data inventory for vault fields, RLS patterns for shared Postgres, encryption options (`age` for sensitive vault material), observability redaction, and **DPIA-oriented checklists** referencing where telemetry (OpenTelemetry, Langfuse) may capture prompts. This repo does **not** provide legal advice; it provides **engineering controls and references** that teams map to their DPIA with counsel.

## Consequences

- **Positive:** Makes enterprise/education pilots auditable; aligns observability docs with `gen_ai.*` attributes.
- **Negative:** Compliance text must be reviewed periodically as law and regulator guidance evolve.
- **Neutral:** Default home-user install may ignore sections marked “organization policy required.”

## Alternatives considered

- **Omit local law specifics:** Rejected for stated user need — education sector CR pilots.
- **Claim certification:** Rejected — out of scope for an open-source guide repo.

## References

- `docs/case-study-mep-cr.md`
- `docs/security/` (telemetry and secrets handling)
