IMAGE=dmgnx/nginx-naxsi

all: mainline stable

NAXSI_VERSION=$(shell \
	grep 'NAXSI_VERSION=' Dockerfile \
	| cut -d= -f2 \
	| awk '{print $$1}' \
	)


NGINX_MAINLINE_VERSION=$(shell \
	grep 'MAINLINE_VERSION=' Dockerfile \
	| cut -d= -f2 \
	| awk '{print $$1}' \
	)

NGINX_STABLE_VERSION=$(shell \
	grep 'STABLE_VERSION=' Dockerfile \
	| cut -d= -f2 \
	| awk '{print $$1}' \
	)

mainline:
	docker build \
		--build-arg=branch=mainline \
		-t $(IMAGE):latest \
		-t $(IMAGE):mainline \
		-t $(IMAGE):$(NGINX_MAINLINE_VERSION) \
		. \
	;

stable:
	docker build \
		--build-arg=branch=stable \
		-t $(IMAGE):stable \
		-t $(IMAGE):$(NGINX_STABLE_VERSION) \
		. \
	;

update:
	sed -i \
		-e 's/\(NAXSI_VERSION=\).* \\/\1$(NAXSI_VERSION) \\/' \
		-e 's/\(NGINX_MAINLINE_VERSION=\).* \\/\1$(NGINX_MAINLINE_VERSION) \\/' \
		-e 's/\(NGINX_STABLE_VERSION=\).*/\1$(NGINX_STABLE_VERSION)/' \
		Dockerfile
		
