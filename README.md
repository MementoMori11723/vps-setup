# 🔧 Ansible VPS Bootstrap

**Automate the setup and security hardening of a fresh Ubuntu VPS** with a single Ansible-based workflow. This project prepares your server for production by installing Docker, configuring a firewall, creating a non-root user with sudo permissions, and securing SSH.

---

## 📦 Features

* 🛠️ System update and package installation
* 🐳 Docker & Docker Compose setup
* 👤 User creation with sudo and Docker group access
* 🔐 SSH hardening (disables root login and password authentication)
* 🔥 UFW firewall configuration (only SSH, HTTP, HTTPS allowed)

---

## 📁 Project Structure

```bash
.
├── .env                 # Environment variables (optional)
├── inventory.ini        # Ansible inventory file
├── Makefile             # Simplifies playbook execution
├── scripts/
│   ├── init.yml         # Initial setup: system update, package install, user creation
│   └── setup.yml        # SSH hardening, firewall setup
```

---

## 🧰 Prerequisites

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed on your local machine
* A freshly provisioned **Ubuntu VPS**
* SSH access to the VPS (as `root`)
* SSH key pair (your public key will be added to the server)
* `passlib` for password hashing if required (`pip install passlib`)

---

## ⚙️ Usage

### 🔹 Step 1: Configure Inventory

Edit `inventory.ini`:

```ini
[vps_root]
your.server.ip

[vps_root:vars]
ansible_ssh_user=root

[vps_deploy]
your.server.ip

[vps_deploy:vars]
ansible_ssh_user=deploy
deploy_passwd=your-hashed-password
```

Replace `your.server.ip` with your actual VPS IP address.
Update `deploy_passwd` with a secure password hash (see [Passlib Docs](https://passlib.readthedocs.io/en/stable/) for hashing).

---

### 🔹 Step 2: Bootstrap the Server

Run the following:

```bash
make run
```

Or simply:

```bash
make
```

This will:

1. Update and upgrade the system
2. Install required packages (Docker, Docker Compose, UFW)
3. Create a new user (default: `deploy`) with:

   * sudo access
   * Docker group membership
4. Copy your SSH public key to the new user
5. Harden SSH and apply UFW firewall rules

---

### 🔹 Step 3: SSH into Your Server

```bash
ssh deploy@your.server.ip
```

You should now be able to SSH using your key.
Root login and password-based authentication are disabled for security.

---

## 🛡️ Security Overview

| Feature           | Description                                        |
| ----------------- | -------------------------------------------------- |
| 🔒 SSH Root Login | Disabled                                           |
| 🔐 Password Auth  | Disabled (uses SSH keys only)                      |
| 🔥 UFW Rules      | Only allows ports 22 (SSH), 80 (HTTP), 443 (HTTPS) |
| 🐳 Docker Access  | `deploy` added to Docker group                     |

---

## ♻️ Reinitialization

To reset and re-run everything:

1. Recreate your VPS (fresh Ubuntu image)
2. Ensure your SSH key is updated
3. Run `make run` again

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

```text
MIT License

Copyright (c) 2025 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction...

[Full license text here if not using LICENSE file directly]
```

---

## 🤝 Contributing

Pull requests and issue reports are welcome!
If you want to contribute additional roles (e.g., auto-deploy apps, setup monitoring), feel free to fork or open a discussion.

---

Let me know if you want:

* A `LICENSE` file generated separately
* Additional playbooks (e.g., automatic Docker app deployment)
* A full CI/CD workflow integrated with GitHub Actions
* Template for `deploy_passwd` generation using Ansible vault or Jinja

Would you like this packaged into a GitHub repo template format too?

