IMAGE=dmgnx/nginx-naxsi

NAXSI_VERSION=0.55.3
NGINX_MAINLINE_VERSION=1.13.6
NGINX_STABLE_VERSION=1.12.2

.PHONY:mainline stable

all: mainline stable

mainline: Dockerfile
	mkdir -p $@
	sed \
			-e 's/@NGINX_VERSION@/$(NGINX_MAINLINE_VERSION)/' \
			-e 's/@NAXSI_VERSION@/$(NAXSI_VERSION)/' \
			$< \
		> $@/$<
	cp docker-entrypoint.sh $@
	cp nginx.conf $@
	cp nginx.vh.default.conf $@

stable: Dockerfile
	mkdir -p $@
	sed \
			-e 's/@NGINX_VERSION@/$(NGINX_STABLE_VERSION)/' \
			-e 's/@NAXSI_VERSION@/$(NAXSI_VERSION)/' \
			$< \
		> $@/$<
	cp docker-entrypoint.sh $@
	cp nginx.conf $@
	cp nginx.vh.default.conf $@

update:
	sed -i \
		-e 's/^\(NAXSI_VERSION=\)\([0-9]\+\(\.\|$$\)\)\+/\1$(NAXSI_VERSION)/' \
		-e 's/^\(NGINX_MAINLINE_VERSION=\)\([0-9]\+\(\.\|$$\)\)\+/\1$(NGINX_MAINLINE_VERSION)/' \
		-e 's/^\(NGINX_STABLE_VERSION=\)\([0-9]\+\(\.\|$$\)\)\+/\1$(NGINX_STABLE_VERSION)/' \
	   	Makefile
	sed -i \
		-e "s/\`$(shell grep '`mainline`' README.md | cut -d'`' -f2)\`/\`$(NGINX_MAINLINE_VERSION)\`/" \
		-e "s/\`$(shell grep '`stable`' README.md | cut -d'`' -f2)\`/\`$(NGINX_STABLE_VERSION)\`/" \
		README.md
