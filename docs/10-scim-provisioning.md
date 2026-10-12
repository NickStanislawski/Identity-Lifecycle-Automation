# Planned SCIM downstream provisioning

**Status: Planned; no SCIM target or Okta provisioning integration was executed.** Choose an actual supported persistent SCIM 2.0 server/product and record HTTPS base URL, authentication method and supported user operations. Direct authenticated lookup/create/update/deactivate tests precede a separate Okta-to-application provisioning test.

Use immutable HR employee ID, canonical app userName and server resource ID as separate values. For this lab, core externalId carries the HR ID, while an Okta application external ID may represent the SCIM server's resource ID. Confirm the actual target mappings rather than assuming labels are equivalent.

Read before creating; ambiguous or conflicting identity ownership must fail. Use supported desired-value PATCH or documented complete PUT updates, then read back. Deactivate with active:false and verify app access/session effects; retain the identity instead of deleting automatically. Tenant app assignment, profile change and deactivation each require their own end-to-end evidence.

Recovery: retain successful upstream state, enqueue downstream work, restore only the pilot's approved state and independently recheck. Unsupported provisioning is a blocker, not a passing fallback. Expected evidence: lookup/native IDs, create/update/deactivate outcomes, target readback and Okta provisioning events. Observed: Not executed.

References: [RFC 7644](https://www.rfc-editor.org/rfc/rfc7644.html), [Okta SCIM 2.0](https://developer.okta.com/docs/api/openapi/okta-scim/guides/scim-20).
