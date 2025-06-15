.DEFAULT_GOAL := run

include .env

run:
	@echo "🔧 Running init playbook..."
	@ansible-playbook scripts/init.yml -i inventory.ini

	@echo "🔑 Copying SSH key to deploy user..."
	@ssh-copy-id $(HOST_SERVER)

	@echo "🛡️ Running setup (harden SSH & enable firewall)..."
	@ansible-playbook scripts/setup.yml -i inventory.ini

