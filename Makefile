CFLAGS = -g -Wall -Wextra -Werror -O2 -std=c99

# See GCC bug #53229 and #64709
CFLAGS += -Wno-missing-braces -Wno-missing-field-initializers

all:

install:
	install -d $(DESTDIR)/usr/local/libexec/qubes
	install -d $(DESTDIR)/usr/local/etc/qubes-macchanger
	install change-mac.sh $(DESTDIR)/usr/local/libexec/qubes/change-mac.sh
	install macchanger.conf $(DESTDIR)/usr/local/etc/qubes-macchanger/macchanger.conf

clean:
