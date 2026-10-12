# Changelog

## 2026-10-12 — Documentation layout cleanup

- Assigned unique sequential numbers 01–13 to technical documents and updated maintained references.
- Consolidated proposed lifecycle/API/SCIM code appendices into PROJECT-LAB-MANUAL.md.
- Reduced review/ to PROJECT-LAB-MANUAL.md and PROJECT-INTERVIEW-STUDY.md; historical/shortcut files backed up outside the project.
- Preserved implementation status, scripts, dataset and screenshots.


## 2026-10-12 — Complete V1/V2 documentation package

- Added one authoritative 35-step lab guide with prerequisites, exact future instructions, explanations, verification, checkpoints, recovery and evidence.
- Updated the interview reference to matching 35 steps with one- or two-sentence explanations; retained the prior V1-only reference privately.
- Added proposed lifecycle/API/SCIM/retry/reconciliation/exception code references inside private Markdown appendices, without deploying or executing them.
- Corrected group names, Manager schema, root EMP043, staged-account policy, scope ownership and lifecycle status boundaries.
- Expanded the 13-section README, seven-chapter coverage, V2 writeups and 22-case unexecuted test matrix.
- Preserved original V1 scripts, employee CSV, screenshot bytes and historical review references. No lab or tenant changes were made.


## 2026-10-12 — Private interview study reference

- Added review/PROJECT-INTERVIEW-STUDY.md with 31 numbered steps across seven phases.
- Each step has a one- or two-sentence explanation distinguishing recorded V1 work from planned V2 capabilities.
- Preserved existing lab manual, review references, tested scripts, dataset, and 56 screenshots; no lab commands were executed.


## Active Directory foundation — completed

- Configured Windows Server 2025 domain controller `IAM-DC01` and `iamlab.test`.
- Validated AD DS and DNS services on a single private-network interface.
- Created five department OUs and twelve role-based Global Security groups.
- Generated fifty synthetic employee identities and provisioned them into AD.
- Assigned fifty role memberships and forty-nine manager relationships.
- Ran consolidated validation: fifty fully validated employees, zero failures, PASS.

## Planned enhancements

- Okta integration, REST APIs, SCIM, MFA, and full Joiner/Mover/Leaver automation.
- Additional automated audit evidence and at least fifteen lifecycle test scenarios.
