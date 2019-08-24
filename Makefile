IMAGE=dmgnx/nginx-naxsi

NAXSI_VERSION=0.56
NAXSI_TAG=untagged-afabfc163946baa8036f
NGINX_MAINLINE_VERSION=1.17.3
NGINX_STABLE_VERSION=1.16.1

.PHONY: mainline stable

dir/mainline: mainline
	
dir/stable: stable

image/mainline: mainline
	docker build \
		-t $(IMAGE):latest \
		-t $(IMAGE):$< \
		-t $(IMAGE):$(NGINX_MAINLINE_VERSION)-$(NAXSI_VERSION) \
		$<

image/stable: stable
	docker build \
		-t $(IMAGE):$< \
		-t $(IMAGE):$(NGINX_STABLE_VERSION)-$(NAXSI_VERSION) \
		$<

mainline:
	mkdir -p $@
	sed \
		-e 's/@NGINX_VERSION@/$(NGINX_MAINLINE_VERSION)/' \
		-e 's/@NAXSI_VERSION@/$(NAXSI_VERSION)/' \
		-e 's/@NAXSI_TAG@/$(NAXSI_TAG)/' \
		Dockerfile \
		> $@/Dockerfile
	cp docker-entrypoint.sh $@
	cp nginx.conf $@
	cp nginx.vh.default.conf $@

stable:
	mkdir -p $@
	sed \
		-e 's/@NGINX_VERSION@/$(NGINX_STABLE_VERSION)/' \
		-e 's/@NAXSI_VERSION@/$(NAXSI_VERSION)/' \
		-e 's/@NAXSI_TAG@/$(NAXSI_TAG)/' \
		Dockerfile \
		> $@/Dockerfile
	cp docker-entrypoint.sh $@
	cp nginx.conf $@
	cp nginx.vh.default.conf $@
