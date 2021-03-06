#
# OS2display infrastructure makefile.

# =============================================================================
# MAIN COMMAND TARGETS
# =============================================================================
.DEFAULT_GOAL := help
# Include environment variables and re-export them.
include _variables.source
export

# Mount database-dump if present.
ifeq (,$(wildcard development/state-import/admin.sql.gz))
DB_DUMP = ./docker-compose.yml:/tmp/ignore-me:ro
else
DB_DUMP = ./development/state-import/admin.sql.gz:/docker-entrypoint-initdb.d/admin.sql.gz:ro
endif

help: ## Display a list of the public targets
# Find lines that starts with a word-character, contains a colon and then a
# doublehash (underscores are not word-characters, so this excludes private
# targets), then strip the hash and print.
	@grep -E -h "^\w.*:.*##" $(MAKEFILE_LIST) | sed -e 's/\(.*\):.*##\(.*\)/\1	\2/'

reset-dev: _dc_compile_dev _reset-container-state _show_notes ## Development-mode: stop all containers, reset their state and start up again.

reset-dev-nfs: _dc_compile_dev_nfs _reset-container-state _show_notes ## Development-mode with NFS: stop all containers, reset their state and start up again.

reset-release: _dc_compile_release _reset-container-state _show_notes ## Release-test mode: stop all containers, reset their state and start up again.

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

clone-admin: ## Do an initial clone of the admin repo.
	git clone --branch=$(ADMIN_REPOSITORY_BRANCH) $(ADMIN_REPOSITORY) development/admin

# Add this make-target if you have a custom bundle you want to run gulp against.
# run-gulp:
#	docker run \
#		-ti \
#		-v $(PWD)/development/admin/:/app \
#		-w /app/src/my-custom-bundle/ \
#		node:8.16.0-slim \
#		sh -c "yarn && yarn run gulp"

run-gulp: ## Generate assets for the custom bundle
	docker run \
		-v $(PWD)/development/admin/:/app \
		-w /app/src/rvk-custom-os2display/ \
		node:8.16.0-slim \
		sh -c "yarn && yarn run gulp"

ifeq (,$(wildcard ./docker-compose.override.yml))
    dc_override =
else
    dc_override = -f docker-compose.override.yml
endif

run-cron: ## Run Cron
# Differentiate how to run composer depending on whether we have an override.
	docker-compose -f docker-compose.yml $(dc_override) run --rm admin-cron run_os2display_cron.sh

load-templates: ## Reload templates
	docker-compose exec admin-php bin/console os2display:core:templates:load
	docker-compose exec admin-php chown -R www-data:www-data app/cache

cc: ## Clear the admin cache
	docker-compose exec admin-php bin/console cache:clear
	docker-compose exec admin-php chown -R www-data:www-data app/cache

xdebug: ## Start xdebug for the admin-php container.
	docker-compose exec admin-php xdebug-start

update-composer-lock: ## Update composer.lock, eg. after a patch has been added.
	docker-compose run -e COMPOSER_MEMORY_LIMIT=-1 admin-php composer update --lock --no-scripts

fetch-state: ## Fetch state from a live environment specified via STATE_FETCH_NAMESPACE
	kubectl config current-context
	@echo "Is the context above correct? [y/N] " && read ans && [ $${ans:-N} == y ]
	kubectl -n ${STATE_FETCH_NAMESPACE} exec $(shell kubectl get pods -l app=admin-db -o jsonpath="{.items[0].metadata.name}") -- sh -c "mysqldump -u root -proot os2display | gzip" > development/state-import/admin.sql.gz
	kubectl -n ${STATE_FETCH_NAMESPACE} cp -c admin-php $(shell kubectl get pods -l app=admin -o jsonpath="{.items[0].metadata.name}"):/var/www/admin/web/uploads development/state-import/uploads
	tar -vC development/state-import -czf development/state-import/uploads.tar.gz uploads
	rm -fr development/state-import/uploads

# =============================================================================
# HELPERS
# =============================================================================
# These targets are usually not run manually.

# Fetch and replace updated containers and db-dump images and run composer install.
_reset-container-state:
# docker-compose has a nasty tendency to leave containers hanging around
# just at bit to long which results in an error as a volume that is still
# in use is attempted deleted. To compensate for this we run docker-compose
# down twice and only exit if the second attempt fails.
# This will result in some warnings the second time around that can safely
# be ignored.
	docker-compose down -v --remove-orphans || true
	docker-compose down -v --remove-orphans
	docker-compose up -d
# TODO - when resetting a release we should wait for admin_php to copy its files
#        before invoking _docker-init-environment. Until then we leave a sleep
#        here
	sleep 5
	docker-compose exec admin-php bash -c "wait-for-it -t 60 admin-db:3306 && wait-for-it -t 60 elasticsearch:9200 && /opt/development/scripts/_docker-init-environment.sh"

_dc_compile_release:
	docker-compose -f docker-compose.common.yml -f docker-compose.release.yml config > docker-compose.yml

_dc_compile_dev:
	docker-compose -f docker-compose.common.yml -f docker-compose.development.yml config > docker-compose.yml

_dc_compile_dev_nfs:
	docker-compose -f docker-compose.common.yml -f docker-compose.development.yml -f docker-compose.development.nfs.yml $(dc_override) config > docker-compose.yml

_show_notes:
	$(info OS2display now is available via the URLs below)
	$(info )
	$(info NOTICE: You should visit each url at least once and accept the self-signed https certificate)
	$(info - Admin: https://admin.$(DOCKER_BASE_DOMAIN))
	$(info - Screen: https://screen.$(DOCKER_BASE_DOMAIN))
	$(info - Search: https://search.$(DOCKER_BASE_DOMAIN))

.PHONY: help reset-dev reset-dev-nfs reset-release up stop logs clone-admin run-cron load-templates cc xdebug configure-kubectl _reset-container-state _dc_compile_release _dc_compile_dev _show_notes

