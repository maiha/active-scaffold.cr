SHELL=/bin/bash

VERSION=
CURRENT_VERSION=$(shell git tag -l | sort -V | tail -1)
GUESSED_VERSION=$(shell git tag -l | sort -V | tail -1 | awk 'BEGIN { FS="." } { $$3++; } { printf "%d.%d.%d", $$1, $$2, $$3 }')
GIT_REV_ID=`(git describe --tags 2>|/dev/null) || (LC_ALL=C date +"%F-%X")`

.PHONY : test
test: check_version_mismatch spec

.PHONY : spec
spec:
	crystal spec -v --fail-fast

.PHONY : assets
assets: 
	cp src/active_scaffold/assets/stylesheets/active_scaffold_layout.css src/active_scaffold/assets/stylesheets/active_scaffold.css
	pyscss src/active_scaffold/assets/stylesheets/active_scaffold_colors.scss >> src/active_scaffold/assets/stylesheets/active_scaffold.css
	cat src/active_scaffold/assets/stylesheets/active_scaffold_custom.css >> src/active_scaffold/assets/stylesheets/active_scaffold.css

.PHONY : backup
backup:
	@test -d backup
	tar zcf backup/active_scaffold.cr-$(GIT_REV_ID).tar.gz .git

.PHONY : check_version_mismatch
check_version_mismatch: shard.yml README.md
	diff -w -c <(grep version: README.md) <(grep ^version: shard.yml)

.PHONY : version
version:
	@if [ "$(VERSION)" = "" ]; then \
	  echo "ERROR: specify VERSION as bellow. (current: $(CURRENT_VERSION))";\
	  echo "  make version VERSION=$(GUESSED_VERSION)";\
	else \
	  sed -i -e 's/^version: .*/version: $(VERSION)/' shard.yml ;\
	  sed -i -e 's/^    version: [0-9]\+\.[0-9]\+\.[0-9]\+/    version: $(VERSION)/' README.md ;\
	  echo git commit -a -m "'$(COMMIT_MESSAGE)'" ;\
	  git commit -a -m 'version: $(VERSION)' ;\
	  git tag "v$(VERSION)" ;\
	fi

.PHONY : bump
bump:
	make version VERSION=$(GUESSED_VERSION) -s
