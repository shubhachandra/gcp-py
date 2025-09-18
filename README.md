Perfect 👍 — if you have **Client ID, Activation Key, and Expiration Date**, that means you don’t yet have the **actual license file** (`.lic`).

Here’s what you need to do:

---

## 🔹 How to Get the License File

1. Go to **BlueCat Customer Care Portal**:
   [https://care.bluecatnetworks.com](https://care.bluecatnetworks.com)

2. Log in with your BlueCat support account.

3. Navigate to:
   **Downloads → License Management** (sometimes called *Manage Licenses*).

4. Enter your:

   * **Client ID**
   * **Activation Key**

5. The portal will generate and let you download the **license file** (`.lic`).

6. Save the file (e.g., `bam.lic`) to your computer.

---

## 🔹 Activate on Proteus

* **Web UI (easiest)**

  1. Open: `https://<proteus-ip>`
  2. Login as `admin`
  3. Go to **Administration → System → License Information**
  4. Upload the `.lic` file

* **CLI (interactive)**

  1. SSH into your VM
  2. Run:

     ```
     > configure
     (configure)> license
     (configure:license)> update
     ```
  3. Paste the entire license content (from `-----BEGIN LICENSE-----` to `-----END LICENSE-----`).
  4. Save → reboot.

---

⚠️ Without downloading the `.lic` from BlueCat Care, you **cannot activate** with just Client ID + Activation Key in the CLI — those two are only used to **request/generate** the file.

---

👉 Do you want me to walk you through **how to use your Client ID + Activation Key in the Care Portal** (step by step with screenshots navigation paths)?
