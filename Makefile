# Useful Makefile scripts.
DEPLOY_PATH = .deploy
PREVIEW_PATH = .preview

deploy: themes
	git push
	hugo-deploy -d $(DEPLOY_PATH)

preview: themes
	rm -rf $(PREVIEW_PATH)
	hugo server -v -d $(PREVIEW_PATH) --renderToDisk --disableFastRender --watch

themes:
	[[ -d themes/harth-hugo-theme ]] || dep refresh
