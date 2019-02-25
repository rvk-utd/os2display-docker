# Building images to get ready for a release

## Tag the release
When developing for the site, most code is changed in the `development/admin` folder, where the [os2display-admin](https://github.com/kkos2/os2display-admin) repo is checked out. When you are done working on a feature there and it is merged to the `kk-develop` branch you need to tag it and build a release.

Assuming that you are in the `development/admin` folder:

1. Find out what the next tag should be by upping the number on the current tag: `git describe --tags`. We'll refer to it as `MYTAG` here.
2. `git tag MYTAG`
3. `git push origin --tags`

## Build and push the release
Now `cd` to the root of this repo and:

1. Edit `_variables.source` and bump `ADMIN_RELEASE_TAG`
2. `make build-release`
3. If you feel like it you can now test the release by running `make reset-release` from the root of the project
4. `make push-release`

You are now ready to deploy your release. Go to the [hosting environment](https://github.com/kkos2/os2display-hosting-environments/documentation/deploying.md) repo to see docs for deployment.
