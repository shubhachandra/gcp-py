# bluecat_simple.py
import requests
import yaml
import sys

# Load config (see example config.yml below)
with open("config.yml") as f:
    cfg = yaml.safe_load(f)

GATEWAY = cfg['gateway']           # e.g. "https://10.0.0.5"
USERNAME = cfg['username']
PASSWORD = cfg['password']
VERIFY_TLS = cfg.get('verify', True)  # set False for self-signed certs (not recommended)

def login():
    url = f"{GATEWAY.rstrip('/')}/rest_login"
    payload = {"username": USERNAME, "password": PASSWORD}
    try:
        r = requests.post(url, json=payload, verify=VERIFY_TLS, timeout=15)
        r.raise_for_status()
    except Exception as e:
        print("Login failed:", e)
        sys.exit(1)
    data = r.json()
    token = data.get("access_token")
    if not token:
        print("No access_token in response:", data)
        sys.exit(1)
    return token

def get_something(token, path="/rest/endpoint/example"):
    # example call — replace path with a real API path (see BAM REST docs)
    url = f"{GATEWAY.rstrip('/')}{path}"
    headers = {"auth": f"Basic {token}"}
    r = requests.get(url, headers=headers, verify=VERIFY_TLS, timeout=15)
    r.raise_for_status()
    return r.json()

if __name__ == "__main__":
    t = login()
    # Example: fetch BAM configurations or other REST endpoints as required
    try:
        result = get_something(t, "/rest/v1/configuration")   # adjust endpoint to your BAM version
        print("Result:", result)
    except Exception as e:
        print("Request failed:", e)


