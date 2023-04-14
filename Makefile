
.DEFAULT_GOAL := help
.PHONY: $(.DEFAULT_GOAL)

help:	## Display this help screen.
	@grep -hE '^[A-Za-z0-9_ \-]*?:.*##.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

serve:	## Serve up a local preview of the website, with drafts and live reload.
	bundle exec jekyll serve --livereload  --drafts

build:	## Build the website for deployment.
	bundle exec jekyll build
