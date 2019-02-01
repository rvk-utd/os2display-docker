# OS2Display repo todo
When the repo moves to the offical os2display repo these should be replaced by
issues or jira-tickets.s

* Split the repo up into development/manifests/images to better allow the various
  roles that interacts with the project to focus on their work. (Eg. a 
  "developer" eventually don't have to care about kubernetes manifets).

* Improve documentation on how to get started as a developer.

## Docker
* Switch to a offical Redis image with persistence.
* Reconfigure php to use a persisted session-store (a volume) to let sessions 
  survive a release.
* Store secrets in Secrets and use the configmaps as templates, this way we 
  could avoid having to do any changes to our configmaps during environment-
  setup
* Have Nginx and related containers log the remote client-ip if possible
* Replace the custom redis image with an official.
* Have redis persist state to disk to survive releases. 
