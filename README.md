# 🔐 Acquire & Auto Renew Let's Encrypt Free TLS Certificates with Cloudflare DNS

This project provides a **Docker-based automated solution** to generate and auto-renew **free TLS certificates from Let's Encrypt** using the **Cloudflare DNS challenge**.

It simplifies TLS certificate management by automatically verifying domain ownership through the Cloudflare API and renewing certificates without manual intervention.

---

## 🚀 Features

- Automated Let's Encrypt certificate generation
- Cloudflare DNS-01 challenge support
- Docker-based execution
- Automatic certificate renewal
- Production-ready setup
- Simple configuration

---

## 🏗️ How It Works

1. Certbot runs inside Docker.
2. Cloudflare API creates temporary DNS TXT records.
3. Let's Encrypt validates domain ownership.
4. TLS certificates are issued.
5. Cron automatically renews certificates before expiration.

---

## 📋 Prerequisites

- Docker installed on the server
- Domain managed by Cloudflare
- Cloudflare API Key
- Cloudflare Zone ID

✅ Tested on **AlmaLinux 10.0**

---

## 📦 Installation

Clone the repository:

```bash
cd /root
git clone https://github.com/arindamgb/letsencrypt-cloudflare-automated.git
cd letsencrypt-cloudflare-automated
```

---

## ⚙️ Configuration

### 1. Configure Certificate Information

Edit the file:

```bash
generate-cert.sh
```

Update your email and domain as below in the command:

```bash
--email yourmail@maildomain.com

-d *.yourdomain.com,yourdomain.com
```

---

### 2. Configure Cloudflare Authentication

Edit the following files:

```bash
authenticator.sh
cleanup.sh
```

Insert your Cloudflare credentials:

```bash
API_TOKEN="your-cloudflare-api-key"
ZONE_ID="your-cloudflare-zone-id"
```

---

## 🧾 Generate Certificate (First Time)

Run:

```bash
bash generate-cert.sh
```

---

## 📁 Certificate Location

Certificates will be generated on the host machine:

```
/root/letsencrypt-cloudflare-automated/etc/letsencrypt/live/yourdomain.com/
```

### Generated Files

| File | Description |
|------|-------------|
| `fullchain.pem` | SSL Certificate Chain |
| `privkey.pem` | Private Key |

These certificates can be used with:

- NGINX
- HAProxy
- Apache
- Kubernetes Ingress
- Any TLS-enabled service

---

## 🔄 Setup Automatic Renewal

Open crontab:

```bash
crontab -e
```

Copy the contents from:

```
crontab.txt
```

Paste and save.

✅ Certificates will now renew automatically.

✅ Change the script location if needed.

---

## ✅ Renewal Behavior

- Runs automatically via cron every 10 days.
- Renews certificates only when less than 30 days left to expire.
- No service interruption during renewal
- Fully automated lifecycle management

---

## 🔒 Security Notes

- Never commit API keys to public repositories.
- Use Cloudflare API tokens with Least Privilege when possible.
- Protect server access and credential files.

---

## 🧪 Tested Environment

| Operating System | Status |
|------------------|--------|
| AlmaLinux 10.0   | ✅ Tested |

- Should work on any other Linux Distributions.

---

## 🤝 Contributing

Contributions and improvements are welcome.

Feel free to open an Issue or submit a Pull Request.

---

## 📄 License

This project is licensed under the GPL-3.0 License.

---

## ⭐ Support

If this project helped you, please consider giving it a ⭐ on GitHub.

---

## 📬 Contact

**Arindam Gustavo Biswas**

- 🌐 [Website](https://arindamgb.com)
- 💼 [LinkedIn](https://www.linkedin.com/in/arindamgb)
- 🐙 [GitHub](https://github.com/arindamgb)  

For questions, suggestions, or collaboration opportunities, feel free to connect or open an issue in this repository.
