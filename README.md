Here is a clearer and more structured version of your message:

---

I can explain why you're unable to apply these roles to the service account using the service account itself.

As per the current design, there are two service accounts used by the Terraform workspace to create resources:

1. **`seed-app` service account** – used in the `core`, `sandbox`, and `nonprod` SDLCs.
2. **`seed-prod-app` service account** – used in the `prod` SDLC.

The `seed-app` service account has the **Security Admin** role at the hub networking host project. This is why role assignment operations work successfully in the `nonprod` and `sandbox` environments.

However, in the `prod` environment, the `seed-prod-app` service account does **not** have the Security Admin role. This prevents it from assigning the required roles (e.g., `servicedirectory.networkAttacher` and `servicedirectory.pscAuthorizedService`) to other service accounts.

These are **cross-project role assignments**, and since the `seed-prod-app` lacks the **Service Account Admin** role (which is part of the Security Admin role bundle), the role assignment fails.

---

Regarding your second question — **why this was working earlier but is failing now**:

There was a change in the service account used for the `core` environment. In the latest release, the service account was switched from `seed-prod-app` to `seed-app`, as seen in the pull request. This change was implemented by the **Landing Zone (LZ) team**.

I’ll loop in the LZ team so they can help resolve this.

---

Let me know if you'd like this in email format or if you need a diagram for better understanding.
