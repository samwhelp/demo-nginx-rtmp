
nginx-install:
	@nginx-install.sh
.PHONY: nginx-install

nginx-remove:
	@nginx-remove.sh
.PHONY: nginx-remove

build-remove:
	@build-remove.sh
.PHONY: build-remove
