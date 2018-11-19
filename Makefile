# Useful Makefile scripts.
DEPLOY_PATH = .deploy
PREVIEW_PATH = .preview
THEME = harth-hugo-theme

deploy: themes
	dep push
	hugo-deploy -d $(DEPLOY_PATH)

preview: themes
	rm -rf $(PREVIEW_PATH)
	hugo server -v -d $(PREVIEW_PATH) --renderToDisk --disableFastRender --watch

themes:
	[[ -d themes/$(THEME) ]] || dep refresh
