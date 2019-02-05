# Infrastructure for Os2Display

The repository contains a Docker setup for running locally and images for running on production.

To get started you need the following installed
- Docker
- Docker compose
- Dory, dnsmasq, or another project that can provide access to the containers 
  via the `VIRTUAL_HOST` environments-specified in docker-compose.

If you want to develop OS2Display you'll need git as well (and any additional development tools).


## Preparing for development
```bash
make clone
make reset-dev
```

After reset the site will be available at https://admin.kff-os2display.docker

## Testing a release
```bash
make reset-release
```

## Other
See Makefile and the [documentation](documentation) for more details or feel
free to contact the authors for more details.
