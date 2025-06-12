# subtakeover
# ⚠️ SubTakeCheck

**SubTakeCheck** is a lightweight and efficient subdomain takeover detection tool. It automates the process of finding subdomains, checking if they're live, and identifying potential subdomain takeover vulnerabilities.

---

## 🚀 Features

- 🔍 Finds subdomains using **subfinder**
- 🌐 Checks for live subdomains using **httpx**
- ⚠️ Detects potential subdomain takeover via response fingerprinting
- 📝 Saves vulnerable subdomains in a simple output file

---

## 📦 Requirements

Make sure you have the following tools installed and available in your `$PATH`:

- [`subfinder`](https://github.com/projectdiscovery/subfinder)
- [`httpx`](https://github.com/projectdiscovery/httpx)
- `curl`

Install them using:

```bash
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
