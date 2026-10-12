# Planned audit, reconciliation and exceptions

**Status: Planned.** Use UTC timestamps, correlation IDs, selected synthetic employee IDs, system/operation names, attempts and verified outcomes. Retain before/after state and append-only failure/status events without credentials or raw token-bearing responses.

Reconciliation needs complete, dated, paginated snapshots and reviewed employee/native-ID/role mappings from every claimed system. Report missing/duplicate/orphan accounts, attribute/manager/role/state mismatches and incomplete deprovisioning. Account activation needs explicit policy; active HR alone does not override the staged V1 state. Absent systems/incomplete collection/unsupported attributes remain findings or limitations.

Retry only safe transient reads/desired-value updates, respect 429 timing, bound attempts, and reconcile ambiguous POSTs before retry. Permanent errors require a tracked corrective action. Preserve successful upstream work while downstream work is pending.

Exception events transition Open → In Progress → Resolved/Failed under one ExceptionID; a latest-event projection produces current state. Resolve only after independent target verification. Append-only files are not cryptographically immutable production logs. Planned tests and verification are in the matrix and private guide; no live findings or resolved V2 exceptions were produced by this documentation update.
