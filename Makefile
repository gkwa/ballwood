build:
	rm -f *.deb *.rpm
	$(MAKE) update
	docker compose down --remove-orphans
	docker compose up
	du -sh *.deb *.rpm

update:
	git submodule update --init --recursive
	git submodule update --remote
	git submodule foreach --recursive git status
	git submodule foreach --recursive git diff --name-status

clean:
	rm -f *.deb *.rpm
	rm -f manifest-rpm.txt
	rm -f manifest-deb.txt
	docker compose down --remove-orphans

verycleanbuild:
	docker compose down --remove-orphans
	docker compose up
	du -sh *.deb *.rpm
