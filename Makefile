PREFIX = /usr/local

.PHONY: install
install:

	mkdir -p $(PREFIX)/bin
    cp ruby_jenkins $(PREFIX)/bin/ruby_jenkins

.PHONY: uninstall
uninstall:
    rm -f $(PREFIX)/bin/ruby_jenkins
