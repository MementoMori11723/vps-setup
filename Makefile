.DEFAULT_GOAL := run

include .env

run:
	@ansible-playbook scripts/init.yml -i inventory.ini
	@ssh-copy-id ${HOST_SERVER}
	@ansible-playbook scripts/setup.yml -i inventory.ini
