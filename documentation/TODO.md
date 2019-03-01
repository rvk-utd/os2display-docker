# Containerized OS2Display TODO
When the repo moves to the offical os2display repo these should be replaced by
issues or jira-tickets.

* Split the os2display-infrastructure up into role-specific repositories.
  * "development" - optimized for developing in particular admin.
  * "hosting" - for operators to handle provisioning and maintenance of the
    installation as a whole.
  * "environments" - for handling releases and updates of environments
    roles that interacts with the project to focus on their work. (Eg. a 
    "developer" eventually don't have to care about kubernetes manifets).
    At this point.
* Improve documentation on how to get started as a developer.
* Verify that all containers logs to standard out and prefereable in a a
  structured format.
* Verify that logs are stored and consider whether retension is sufficient
  (this is cloud-provider specific).
* Store secrets in Secrets to be more safe in a multi-tenancy situation. The
  current os2display-hosting-environments repository handles "secrets" mostly
  by letting Helm administer them as a config-map, but anyone with access to
  Tiller can retrive all configmaps.
* Have Nginx and related containers log the remote client-ip.
* Consider official images for Elasticsearch (requires some work to have admin store
  data with an updated mapping) and Redis (should be easy).
* Clean up the entire setup for upstreaming.
* Handle outbound mails, for GCP Symfony seems to have sufficient support via
  mailgun etc.
* Consider how to initialize an environment with standard data.
* Update all images to avoid running anything as root / privileged.
* Build a release-pipeline for automated build and deployment.

