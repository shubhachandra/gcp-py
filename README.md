Got it 👍. The error Permission denied (publickey) means the server is not accepting password-based SSH at all — it’s only allowing key-based authentication.

Here are a few ways you can handle it:

⸻

1. Try forcing password authentication

Run with the -o PreferredAuthentications=password flag:

ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no shubh@100.23.34.56

You should then be prompted for the password shubh122.

⸻

2. Check if the server allows password login
	•	Log in to the server console (cloud provider / hosting panel).
	•	Open /etc/ssh/sshd_config and make sure:

PasswordAuthentication yes
PubkeyAuthentication yes


	•	Then restart SSH:

sudo systemctl restart sshd



If it’s set to no, your password will never work.

⸻

3. If only key-based login is allowed

You’ll need to:
	1.	Generate a key on your local machine:

ssh-keygen -t rsa -b 4096 -C "shubh"


	2.	Copy the public key to the server:

ssh-copy-id shubh@100.23.34.56

(or manually add it to ~/.ssh/authorized_keys on the server).

After that you can log in with just:

ssh shubh@100.23.34.56


⸻

👉 Do you have console access to that server (via cloud portal or direct login), or only SSH? That decides whether we can enable password authentication or must set up SSH keys.

Observability
	1.	Quota Alerts
	•	Raised with Louis to set up actionable alerts when quota usage hits 90%, instead of reacting after failures (as happened in sandbox).
	2.	Metrics Identification
	•	Sai & Hemalatha are working on listing and filtering important networking metrics to be captured for dashboards.

⸻

Do you want me to also merge this with the longer “Shubh’s update” you gave earlier today, so the weekly report covers both streams (Shubhachandra + Shubh) together in one consolidated format?
