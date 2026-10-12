# Environment setup

**Recorded baseline:** Hyper-V, Windows Server 2025 Standard Evaluation, IAM-DC01, iamlab.test, private IAM-LAB switch, single NIC at 10.10.10.10/24. **Future prerequisites:** authorized Okta tenant/features, supported SCIM 2.0 target, secure API keys, separate domain-joined agent host and approved routed outbound connectivity.

Use elevated Windows PowerShell 5.1 with the ActiveDirectory module for directory procedures. Repository folders are not the same as C:\IAM-Lab execution paths; copy reviewed original scripts and synthetic source data to the lab when rebuilding. Future OAuth examples require a separate Python environment with PyJWT[crypto] and requests, installed during that exercise. No dependency was installed or tenant configured for this documentation update.

Keep the original baseline isolated and unchanged while preparing pilots. V1 records one enabled account and forty-nine disabled accounts. Planned JML must not enable the entire feed automatically. For a new rebuild use the exact recorded OUs, group names and Manager schema; for an existing build inspect rather than recreate objects. Verification and recovery procedures are in the private guide.
