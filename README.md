Yes — you can use a self-signed certificate for BlueCat BAM and still connect Terraform over HTTPS, but there are some important caveats. Here’s how it works:

⸻

1️⃣ Create a self-signed certificate

You can generate it on the BlueCat server or your local machine:

# Generate private key
openssl genrsa -out server.key 2048

# Generate self-signed certificate
openssl req -new -x509 -key server.key -out server.crt -days 365 \
  -subj "/C=IN/ST=Karnataka/L=Bengaluru/O=YourOrg/OU=IT/CN=100.120.34.96"

	•	CN must match the IP address or hostname of your BlueCat instance.
	•	This creates server.crt (public certificate) and server.key (private key).

⸻

2️⃣ Upload to BlueCat
	•	GUI: Admin → Server Administration → Manage HTTPS Certificates → Upload cert + private key.
	•	CLI/SSH: Copy server.crt and server.key to /data/bam/certs/ and restart BAM:

service bam restart


⸻

3️⃣ Configure Terraform with self-signed cert

Since it’s self-signed, Terraform will reject it unless you explicitly trust it:

provider "bluecat" {
  server      = "100.120.34.96"
  port        = 443
  transport   = "https"
  username    = "admin"
  password    = "your-password"
  cacert_file = "/path/to/server.crt" # Trust the self-signed cert
  insecure    = false                 # Keep false for security
}

	•	cacert_file points to your self-signed cert so Terraform can trust it.
	•	insecure = true is a workaround if you don’t want to use cacert_file, but it’s not recommended for production.

⸻

✅ Notes / Caveats
	1.	Self-signed certificates are fine for sandbox, lab, or testing environments.
	2.	For production, it’s recommended to use a certificate signed by a trusted CA.
	3.	Make sure the IP/hostname in the certificate matches what you use in Terraform; otherwise, you’ll get x509 errors.

⸻

If you want, I can write a step-by-step command sequence to generate a self-signed cert specifically for your BAM IP 100.120.34.96 and configure Terraform with it — ready to use.

Do you want me to do that
?
