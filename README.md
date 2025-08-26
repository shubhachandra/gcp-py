Here’s a high-level outline you can follow:

Step 1. Create Network and Subnet
	•	Create a VPC network for consumer (Dialogflow/Integration Connectors).
	•	Create a subnet for PSC endpoints.
	•	Allocate internal IP for PSC.

Step 2. Service Account and Firewall Rules
	•	Create a service account for Integration Connectors runtime.
	•	Add firewall rules to allow HTTPS (443) to PSC target range.

Step 3. OAuth Proxy (if provider not PSC-ready)
	•	Deploy a Cloud Run or backend service acting as OAuth proxy.
	•	Configure it with client ID, secret, and token exchange logic.

Step 4. Internal Load Balancer for Proxy
	•	Create a regional internal HTTPS load balancer with backend (NEG).
	•	Create URL map, target HTTPS proxy, and forwarding rule.
	•	Allocate NAT subnet for PSC producer.

Step 5. Publish Service Attachment
	•	Create google_compute_service_attachment for the proxy or provider endpoint.
	•	Allow automatic or selected consumers.

Step 6. Consumer PSC Endpoint
	•	Create forwarding rule referencing the service attachment.
	•	Map DNS record to PSC endpoint IP.

Step 7. Integration Connectors Endpoint Attachment
	•	Create an endpoint attachment for Application Integration.
	•	Connect it to the PSC endpoint.

Step 8. Integration Connectors Connection
	•	Configure HTTPS connector with endpoint attachment.
	•	Use private DNS hostname for OAuth calls.

Step 9. Dialogflow Flow
	•	Step in Dialogflow triggers Integration Connector task to get token.
	•	Token passed back and used as Bearer token in API call.

Would you like me to make this outline with Terraform resource names for each step?
