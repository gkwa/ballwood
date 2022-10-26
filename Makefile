build:
	perl -i -p -e 's#Version \d+\.\d+.*#Version VERSION#' streambox-templates-app/index.html
	cd streambox-templates-app && npm install . && npm run build
	bump2version minor --allow-dirty
	rm -f *.deb *.rpm
	docker compose down --remove-orphans
	docker compose run --rm debbuilder

deb:
	rm -f *.deb
	docker compose down --remove-orphans
	docker compose run debbuilder
	du -sh *.deb *.rpm

rpm:
	rm -f *.deb *.rpm
	docker compose down --remove-orphans
	docker compose run rpmbuilder
	du -sh *.rpm

reset:
	git submodule deinit -f .
	git submodule update --init

update:
	git submodule update --init --recursive
	git submodule update --remote

diff:
	 git diff --submodule=diff

clean:
	rm -f *.deb *.rpm
	rm -f manifest-rpm.txt
	rm -f manifest-deb.txt
	docker compose down --remove-orphans

verycleanbuild:
	docker compose down --remove-orphans
	docker compose up
	du -sh *.deb *.rpm
