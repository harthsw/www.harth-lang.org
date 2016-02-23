# Useful Makefile scripts.
DEPLOY_PATH = .deploy
PREVIEW_PATH = .preview

deploy:
	hugo-deploy -d $(DEPLOY_PATH)

preview:
	rm -rf $(PREVIEW_PATH)
	hugo server -d $(PREVIEW_PATH) --renderToDisk=true --watch=true
