# Planned lifecycle validation matrix

**All V2 observations: Not executed.** Complete at least fifteen applicable cases and all required integrated controls before claiming full acceptance. V1 evidence remains separately recorded in docs/07-testing-and-validation.md. The documentation update does not count as these tests.

## V2-T01 — Valid joiner

**Starting state:** Full feed plus EMP051; no matching account.

**Exact action:** Run step 18 Joiner after -WhatIf; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** One staged account, correct owned role/manager.

**Independent verification:** Read employeeID, OU, roles, manager and Enabled.

**Cleanup/restore:** Disable/retain pilot; remove app assignments after downstream tests; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T01 dated output/sanitized screenshot/readback; none fabricated.

## V2-T02 — Repeated joiner

**Starting state:** Joiner case already verified.

**Exact action:** Repeat identical selected Joiner; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Same native identity; no duplicates.

**Independent verification:** Count by employeeID and username; compare group set.

**Cleanup/restore:** Retain pilot for later isolated tests; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T02 dated output/sanitized screenshot/readback; none fabricated.

## V2-T03 — Duplicate employee ID

**Starting state:** Copy baseline; duplicate EMP050 row.

**Exact action:** Run lifecycle preflight with -WhatIf; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Fail before AD writes.

**Independent verification:** Compare unchanged selected AD before-state.

**Cleanup/restore:** Discard copy; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T03 dated output/sanitized screenshot/readback; none fabricated.

## V2-T04 — Username collision

**Starting state:** Copy feed; assign an existing different username to EMP051.

**Exact action:** Run selected Joiner preflight; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Fail closed; unrelated account not adopted.

**Independent verification:** Read both identity mappings and unchanged state.

**Cleanup/restore:** Discard copy; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T04 dated output/sanitized screenshot/readback; none fabricated.

## V2-T05 — Missing required field

**Starting state:** Copy baseline; blank EMP050 Position.

**Exact action:** Run preflight with -WhatIf; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Reject feed before change.

**Independent verification:** Compare AD before-state.

**Cleanup/restore:** Discard copy; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T05 dated output/sanitized screenshot/readback; none fabricated.

## V2-T06 — Invalid role/department

**Starting state:** Copy baseline; mismatch EMP050 Sales and IT Support Specialist.

**Exact action:** Run preflight with -WhatIf; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Reject inconsistent role/department.

**Independent verification:** Compare AD before-state.

**Cleanup/restore:** Discard copy; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T06 dated output/sanitized screenshot/readback; none fabricated.

## V2-T07 — Manager cycle

**Starting state:** Copy baseline; make selected worker report to self.

**Exact action:** Run preflight with -WhatIf; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Reject hierarchy.

**Independent verification:** Source traversal and unchanged AD.

**Cleanup/restore:** Discard copy; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T07 dated output/sanitized screenshot/readback; none fabricated.

## V2-T08 — Same-department mover

**Starting state:** Copy baseline; EMP050 becomes Systems Administrator in IT.

**Exact action:** Run selected Mover with copied feed; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Old owned role removed, new owned role present.

**Independent verification:** Read role set and attributes; rerun.

**Cleanup/restore:** Restore original feed/state; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T08 dated output/sanitized screenshot/readback; none fabricated.

## V2-T09 — Cross-department mover

**Starting state:** Step 19 copied Sales feed for EMP050.

**Exact action:** Run selected Mover; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Sales OU/role and EMP012 manager; original state retained.

**Independent verification:** Read by GUID and inspect all state.

**Cleanup/restore:** Restore original attributes/OU/role/manager/Enabled; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T09 dated output/sanitized screenshot/readback; none fabricated.

## V2-T10 — Unmanaged-group preservation

**Starting state:** Synthetic pilot has a nonmanaged test group.

**Exact action:** Run selected Mover; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Unmanaged group remains.

**Independent verification:** Compare all pre/post memberships.

**Cleanup/restore:** Restore owned state and remove only added test membership; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T10 dated output/sanitized screenshot/readback; none fabricated.

## V2-T11 — Leaver

**Starting state:** Step 20 copied Terminated feed for EMP050.

**Exact action:** Run selected Leaver; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Disabled, no owned roles, retained in Disabled-Users.

**Independent verification:** Read state and memberships.

**Cleanup/restore:** Restore from original feed and before-state; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T11 dated output/sanitized screenshot/readback; none fabricated.

## V2-T12 — Repeated leaver

**Starting state:** Leaver test state is verified.

**Exact action:** Repeat same selected Leaver; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Remains disabled with no owned roles.

**Independent verification:** Read state and compare.

**Cleanup/restore:** Restore baseline; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T12 dated output/sanitized screenshot/readback; none fabricated.

## V2-T13 — Manager reassignment

**Starting state:** Copy baseline; EMP050 Manager becomes EMP002.

**Exact action:** Run selected Mover; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Manager points to intended AD identity.

**Independent verification:** Resolve manager DN independently.

**Cleanup/restore:** Restore EMP043 reference and baseline state; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T13 dated output/sanitized screenshot/readback; none fabricated.

## V2-T14 — AD-to-Okta import

**Starting state:** Approved pilot agent/scope/mapping.

**Exact action:** Preview/confirm scoped import; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** One correctly mapped pilot and owned group context.

**Independent verification:** Compare employee/native IDs and group source.

**Cleanup/restore:** Restore scoped settings if test changed them; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T14 dated output/sanitized screenshot/readback; none fabricated.

## V2-T15 — MFA enforcement

**Starting state:** Enrolled synthetic pilot and app policy.

**Exact action:** Fresh-session challenge plus denial case; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Approved factor permits app; denial blocks app.

**Independent verification:** Provider event and app access checks.

**Cleanup/restore:** Restore approved pilot policy/enrollment; retain admin recovery; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T15 dated output/sanitized screenshot/readback; none fabricated.

## V2-T16 — Direct SCIM create/conflict

**Starting state:** Empty owned pilot namespace.

**Exact action:** Appendix lookup/create; deliberate duplicate only in approved test; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** One mapped resource; duplicate conflict.

**Independent verification:** Read server ID, externalId and userName.

**Cleanup/restore:** Deactivate/retain pilot; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T16 dated output/sanitized screenshot/readback; none fabricated.

## V2-T17 — SCIM update/deactivation

**Starting state:** Owned pilot resource exists.

**Exact action:** Desired-value PATCH name then active false; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Updated attribute and inactive account.

**Independent verification:** Independent GET and app access check.

**Cleanup/restore:** Restore approved pilot state if needed; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T17 dated output/sanitized screenshot/readback; none fabricated.

## V2-T18 — Okta-to-SCIM provisioning

**Starting state:** Supported tenant integration and assigned pilot group.

**Exact action:** Assignment, source update, unassignment/deactivation; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Actual downstream create/update/inactive state.

**Independent verification:** Correlate provider event and target resource/access.

**Cleanup/restore:** Restore test app assignment and source state; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T18 dated output/sanitized screenshot/readback; none fabricated.

## V2-T19 — Selective retry

**Starting state:** Controlled endpoint with deterministic 429/503/400/401.

**Exact action:** Run proposed REST helper against each response class; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Transient safe requests retry; permanent errors do not.

**Independent verification:** Attempts/delays and target readback.

**Cleanup/restore:** Stop controlled endpoint and restore client settings; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T19 dated output/sanitized screenshot/readback; none fabricated.

## V2-T20 — Ambiguous create reconciliation

**Starting state:** Controlled timeout after server-side create.

**Exact action:** Lookup before repeating POST; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Existing owned resource adopted only after matching IDs.

**Independent verification:** Count resources and verify ownership.

**Cleanup/restore:** Deactivate/retain test resource; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T20 dated output/sanitized screenshot/readback; none fabricated.

## V2-T21 — Cross-system drift/orphan

**Starting state:** Complete normalized snapshots plus one intentional mismatch.

**Exact action:** Run proposed reconciliation script; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Correct system-specific finding; incomplete sources explicitly flagged.

**Independent verification:** Inspect expected/observed/native mappings.

**Cleanup/restore:** Restore drift and remove only the intentional orphan per policy; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T21 dated output/sanitized screenshot/readback; none fabricated.

## V2-T22 — Exception resolution

**Starting state:** One intentional unresolved downstream failure.

**Exact action:** Append In Progress then verified Resolved; project latest state; use the corresponding numbered lab step and canonical appendix for commands.

**Expected result:** Historical failure retained; current state resolved with evidence.

**Independent verification:** Compare JSONL events and current CSV.

**Cleanup/restore:** Restore target and preserve original events; confirm restored state independently.

**Observed result:** Not executed.

**Outcome:** Not run.

**Evidence:** Future V2-T22 dated output/sanitized screenshot/readback; none fabricated.
