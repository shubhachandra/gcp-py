Here’s a clearer and more grammatically correct version of your sentence:

---

> To my understanding, there is one possible issue: currently, we are using a seed service account to create resources in the prod SDLC. While using the Dialogflow service, we need to assign the `roles/dialogflow.pscAuthorizedService` and `roles/networkconnectivity.networkAttacher` roles to the **service agents** of the prod SDLC in the **core project**. However, the seed service account does **not** have the **Service Account Admin** role, as you can see in the attached screenshot.
>
> In the `project-factory` module, the `networking.tf` file passes the networking hub host project on **line 99**, and also on **line 20**.

---

Let me know if you’re preparing this for a code review comment, documentation, or a support case—I can tailor it more precisely.
