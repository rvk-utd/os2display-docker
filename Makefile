#
# OS2display infrastructure makefile.

# =============================================================================
# MAIN COMMAND TARGETS
# =============================================================================
.DEFAULT_GOAL := help

help: ## Display a list of the public targets
# Find lines that starts with a word-character, contains a colon and then a
# doublehash (underscores are not word-characters, so this excludes private
# targets), then strip the hash and print.
	@grep -E -h "^\w.*:.*##" $(MAKEFILE_LIST) | sed -e 's/\(.*\):.*##\(.*\)/\1	\2/'

reset: _reset-container-state ## Stop all containers, reset their state and start up again.

up:  ## Take the whole environment up without altering the existing state of the containers.
	docker-compose up -d --remove-orphans

stop: ## Stop all containers without altering anything else.
	docker-compose stop

logs: ## Follow docker logs from the containers
	docker-compose logs -f --tail=50

# Use the current list of plantuml files to define a list of required pngs.
diagrams = $(patsubst %.plantuml,%.png,$(wildcard documentation/diagrams/*.plantuml))

# The default docs target depends on all png-files
docs: $(diagrams) ## Build plantuml-diagrams for the documentation

# Static pattern that maps between diagram pngs and plantuml-files.
$(diagrams): documentation/diagrams/%.png : documentation/diagrams/%.plantuml
	@echo '$< -> $@'
	rm -f $@
	cat $< | docker run --rm -i think/plantuml -tpng > $@

build-images: ## Build docker-images.
	images/build.sh

build-release: ## Build a release and tag it by TAG
	images/build-release.sh $(TAG)

push-release: ## Push a release specified by TAG
	images/push-release.sh $(TAG)

push-images: ## Push docker-images.
	images/push.sh

clone-admin: ## Do an initial clone of the admin repo.
	git clone --branch=bbs-develop git@github.com:rvk-utd/os2display-admin.git development/admin

ifeq (,$(wildcard ./docker-compose.override.yml))
    dc_override =
else
    dc_override = -f docker-compose.override.yml
endif
run-cron: ## Run Cron
# Differentiate how to run composer depending on whether we have an override.
	docker-compose -f docker-compose.yml $(dc_override) run --rm admin-cron run_os2display_cron.sh

load-templates: ## Reload templates
	docker-compose exec admin-php app/console os2display:core:templates:load
	docker-compose exec admin-php chown -R www-data:www-data app/cache

cc: ## Clear the admin cache
	docker-compose exec admin-php app/console cache:clear
	docker-compose exec admin-php chown -R www-data:www-data app/cache

xdebug: ## Start xdebug for the admin-php container.
	docker-compose exec admin-php xdebug-start

# =============================================================================
# HELPERS
# =============================================================================
# These targets are usually not run manually.

# Fetch and replace updated containers and db-dump images and run composer install.
_reset-container-state:
	docker-compose down -v --remove-orphans
	docker-compose up -d
	sleep 10
	docker-compose exec admin-php /opt/development/scripts/_docker-init-environment.sh

.PHONY: default help reset up stop logs status docs _reset-container-state build-images

