build:
	perl -i -p -e 's#Version \d+\.\d+.*#Version VERSION#' streambox-templates-app/index.html
	bump2version minor --allow-dirty
	cd streambox-templates-app && npm install . && npm run build
	rm -f *.deb *.rpm
	docker compose down --remove-orphans
	docker compose run --rm debbuilder

tar:
	bash -x tar.sh

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
	rm -rf React-[0-9][0-9]*-[0-9][0-9]*-[0-9][0-9]*
	rm -f *.deb *.rpm
	rm -f manifest-rpm.txt
	rm -f manifest-deb.txt
	docker compose down --remove-orphans

verycleanbuild:
	docker compose down --remove-orphans
	docker compose up
	du -sh *.deb *.rpm
