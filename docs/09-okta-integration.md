# Planned Okta integration and MFA

**Status: Planned; not configured or validated.** Record tenant features before designating a final implementation. Pilot-only AD agent integration should run on a dedicated domain-joined member server with approved outbound connectivity; keep the DC single-homed.

Preview a scoped import, map the HR employee ID to an approved unique Okta profile attribute, confirm source ownership and native identity IDs, and inspect the imported group's source/type. Define the actual disabled/deactivated-user synchronization behavior explicitly; a directory import alone does not prove deprovisioning. Restrict app assignments to test groups and retain administrator recovery access.

For API Services, use approved read scopes/admin roles and private_key_jwt at the org token endpoint. API connectivity is separate from AD integration, provisioning and complete pagination-aware collection. For MFA, require and demonstrate an actual authenticator challenge, fresh-session access and denial with sanitized provider/app evidence.

Rollback: restore prior scoped import/mapping/policy settings and verified pilot assignments; do not remove administrator access or delete directory identities to compensate for a downstream error. Expected evidence: source/target mapping, import preview/outcome, API status, policy and actual challenge/denial behavior. Observed results: Not executed.

References: [Okta AD integration](https://help.okta.com/oie/en-us/content/topics/directory/ad-agent-main.htm), [service-app OAuth](https://developer.okta.com/docs/guides/implement-oauth-for-okta-serviceapp/). Check current supported UI/features during execution.
