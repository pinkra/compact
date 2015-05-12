
PACKAGE_NAME=compact
PACKAGE_VERSION=1.0.3

install:
	install -d $(DESTDIR)/usr/bin
	install -d $(DESTDIR)/usr/share/perl5/CSS
	install -d $(DESTDIR)/usr/share/perl5/JavaScript
	install -d $(DESTDIR)/usr/share/docs/$(PACKAGE_NAME)-$(PACKAGE_VERSION)
	install compact.pl $(DESTDIR)/usr/bin
	install CSS/* $(DESTDIR)/usr/share/perl5/CSS
	install JavaScript/* $(DESTDIR)/usr/share/perl5/JavaScript
	install config.compact.sample $(DESTDIR)/usr/share/docs/$(PACKAGE_NAME)-$(PACKAGE_VERSION)
