# Useful Makefile scripts.
DEPLOY_PATH = .deploy

deploy:
	hugo-deploy -d $(DEPLOY_PATH) -b master
