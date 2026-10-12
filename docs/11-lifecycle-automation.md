# Planned Joiner, Mover and Leaver automation

**Status: Designed/documented, not implemented or validated by this task.** The three original V1 scripts provision/assign/validate the fixed baseline; they are not evidence of automated lifecycle transitions.

The private guide contains canonical proposed lifecycle code to save during implementation. It uses the original twelve group names, Manager CSV field, explicit pilot selection, full-feed validation, -WhatIf, username ownership, OU boundaries, before/after evidence and independent readback. It does not require Exchange extension attributes.

Joiner: create once, stage disabled, establish managed role/manager, explicitly activate only an approved password-initialized new pilot. Mover: reconcile owned role/attributes/OU/manager while retaining unrelated access and existing state. Leaver: require Terminated HR status, disable, remove owned roles, retain in Disabled-Users, then verify all applicable downstream targets separately.

Use copied complete feeds and record restoration of the original state. Never infer termination from an incomplete feed or automatically delete accounts after a partial failure. Tests cover duplicates, malformed input, transfers, repeated operations, manager changes, unrelated-group preservation and cleanup. Expected results are documented in the matrix; observed V2 results remain Not executed.
