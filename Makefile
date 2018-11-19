# Useful Makefile scripts.
DEPLOY_PATH = .deploy
PREVIEW_PATH = .preview

deploy: themes
	git push
	hugo-deploy -d $(DEPLOY_PATH)

preview: themes
	rm -rf $(PREVIEW_PATH)
	hugo server -d $(PREVIEW_PATH) --renderToDisk=true --watch=true

themes:
	[[ -d themes/harth-hugo-theme ]] || dep refresh
