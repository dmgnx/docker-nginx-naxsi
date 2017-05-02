IMAGE=dmgnx/nginx-naxsi

all: mainline stable

NAXSI_VERSION=$(shell \
	grep 'NAXSI_VERSION=' Dockerfile \
	| cut -d= -f2 \
	| awk '{print $$1}' \
	)

NGINX_MAINLINE_VERSION=$(shell \
	grep 'NGINX_VERSION=' mainline/Dockerfile \
	| cut -d= -f2 \
	| awk '{print $$1}' \
	)

NGINX_STABLE_VERSION=$(shell \
	grep 'NGINX_VERSION=' stable/Dockerfile \
	| cut -d= -f2 \
	| awk '{print $$1}' \
	)

.PHONY:mainline stable

mainline: Dockerfile
	sed \
			's/@NGINX_VERSION@/$(NGINX_MAINLINE_VERSION)/' \
			$< \
		> $@/$<
	cp docker-entrypoint.sh $@
	cp nginx.conf $@
	cp nginx.vh.default.conf $@

stable: Dockerfile
	sed \
			's/@NGINX_VERSION@/$(NGINX_STABLE_VERSION)/' \
			$< \
		> $@/$<
	cp docker-entrypoint.sh $@
	cp nginx.conf $@
	cp nginx.vh.default.conf $@

update-naxsi:
	sed -i \
		's/\(NAXSI_VERSION=\).* \\/\1$(NAXSI_VERSION) \\/' \
	   	Dockerfile
