# Security controls and planned extensions

Recorded V1 demonstrates synthetic identities, an isolated AD domain, role-based group assignment and independent attribute/membership/state validation. Group membership is not proof that a downstream application grants a particular permission.

Planned V2 uses immutable employee IDs, username-ownership checks, full-feed validation, explicit managed-group allowlists, staged account activation, before/after evidence and -WhatIf preflight. Movers remove only obsolete managed access; leavers disable and retain accounts. Other memberships require their own approved control, and target sessions/credentials must be checked before claiming complete access revocation.

Keep AD authoritative for imported AD groups and do not establish competing writers in Okta. Planned MFA needs an actual policy/challenge/denial test; planned SCIM requires trusted HTTPS, secure authentication and independent target readback. API clients must use least privilege, bounded selective retry, read-after-ambiguous-write reconciliation and sanitized logs. Local append-only files are auditable lab records, not tamper-proof storage.

Private keys, tokens, passwords, raw logs and review/ remain outside public Git. Publication review must inspect tracked files and history in addition to .gitignore. No V2 control has been executed by this documentation update.
