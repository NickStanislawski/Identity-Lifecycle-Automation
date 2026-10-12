# Enterprise Identity Lifecycle Automation Lab

## 1. Project Overview

An IAM portfolio lab using synthetic HR identities, PowerShell and Active Directory, with a fully documented V2 plan for Okta, MFA, SCIM and lifecycle operations. Recorded V1 is validated; V2 is not implemented by this documentation update.

## 2. Objectives

Maintain at least 50 identities, five departments and ten role profiles; demonstrate RBAC, JML, downstream provisioning/deactivation, MFA, safe automation and evidence-backed validation. See [acceptance tracker](PROJECT-STATUS.md).

## 3. Architecture

Implemented: HR CSV → PowerShell → Active Directory. Planned: AD → scoped Okta integration/MFA → SCIM target, with audit, reconciliation and exceptions. See [architecture](docs/01-architecture.md).

## 4. Technologies Used

Recorded: Hyper-V, Windows Server 2025 Standard Evaluation, AD DS/DNS and PowerShell. Planned: supported Okta features, REST/OAuth service app, SCIM 2.0 target and Python/PyJWT/requests for the documented OAuth exercise; versions/features must be recorded during implementation.

## 5. Key Features

Implemented and validated in V1: 50 synthetic directory users, departmental OUs, twelve Global Security role groups, role/manager assignment and independent checks. Planned V2: JML, real MFA, SCIM, audit, exception handling and cross-system reconciliation.

## 6. Implementation Summary

Original scripts are [New-IAMLabUsers.ps1](scripts/New-IAMLabUsers.ps1), [Set-IAMLabAccess.ps1](scripts/Set-IAMLabAccess.ps1), and [Test-IAMLabV1.ps1](scripts/Test-IAMLabV1.ps1). New V2 documents provide proposed procedures rather than claiming additional scripts were deployed.

## 7. Security Considerations

Synthetic data, isolated single-NIC DC, controlled role mappings and independent validation. V1 keeps EMP001 enabled and the other 49 staged disabled; planned V2 must preserve that baseline unless an explicit activation is approved. See [controls](docs/06-security-controls.md).

## 8. Testing and Validation

The supplied consolidated V1 result is PASS: 50 fully validated employees and zero failures. [Recorded evidence](docs/07-testing-and-validation.md) and the [planned 22-case lifecycle matrix](tests/TEST-MATRIX.md) distinguish actual V1 results from unexecuted V2 tests.

## 9. Results

Recorded: 50 identities, 5 departments, 12 role groups, 50 role assignments and 49 manager relationships. No V2 results or live rerun were produced by this documentation task.

## 10. Challenges and Lessons Learned

The recorded multihomed-DC issue was resolved by removing the unnecessary second NIC and revalidating DNS. The documentation now uses one consistent schema, role map and account-state policy. See [troubleshooting](docs/08-troubleshooting.md).

## 11. Project Limitations

No completed Okta, SCIM, MFA, full JML, selective retry, audit/exception or cross-system implementation is claimed. Tenant capabilities, supported target API behavior, permissions and live execution remain future prerequisites.

## 12. Future Improvements

Implement and execute the documented V2 steps, collect actual evidence, satisfy applicable acceptance gates and review publication/history. Do not promote planned instructions to completed portfolio achievements.

## 13. Documentation and Evidence

- [Architecture](docs/01-architecture.md)
- [Environment setup](docs/02-environment-setup.md)
- [Active Directory foundation](docs/03-active-directory.md)
- [Identity provisioning](docs/04-identity-provisioning.md)
- [RBAC and access management](docs/05-rbac-and-access-management.md)
- [Security controls](docs/06-security-controls.md)
- [Testing and validation](docs/07-testing-and-validation.md)
- [Troubleshooting](docs/08-troubleshooting.md)
- [Results and lessons](docs/13-results-and-lessons.md)
- [Planned Okta integration](docs/09-okta-integration.md)
- [Planned SCIM provisioning](docs/10-scim-provisioning.md)
- [Planned lifecycle automation](docs/11-lifecycle-automation.md)
- [Planned audit/reconciliation](docs/12-audit-and-reconciliation.md)
- [Seven-chapter coverage crosswalk](docs/DOCUMENTATION-CROSSWALK.md)
- [Original screenshots](screenshots/)
