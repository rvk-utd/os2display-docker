# Infrastructure for Os2Display

The repository contains a Docker setup for running locally and images for running on production.

## Development

To get started you need the following:
1. Install [Docker](https://docs.docker.com/install/)
2. Install [Docker Compose](https://docs.docker.com/compose/install/)
3. Install [Dory](https://github.com/FreedomBen/dory). - Something similiar will do. dnsmasq, or another project that can provide access to the containers via the `VIRTUAL_HOST` environments-specified in docker-compose.
4. `dory up`
5. `make clone-admin`
6. `make reset-dev`
7. `make run-gulp`

When you have made changes to slides or screens you might want to run `make run-gulp`
again.

After reset the site will be available at https://admin.kff-os2display.docker

## Testing a release
```bash
make reset-release
```

## Other
See Makefile and the [documentation](documentation) for more details or feel
free to contact the authors for more details.
