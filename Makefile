DESTDIR=
PREFIX=/usr
BINDIR=/bin
MANDIR=/share/man/man1
ZSHCOMPDIR=/share/zsh/site-functions
BASHCOMPDIR=/share/bash/bash-completion/completions
SYSTEMDUNITDIR=/lib/systemd/system

INSTALL=install
RM=rm
SHELLCHECK=shellcheck

.PHONY: test check install uninstall

test check:
	$(SHELLCHECK) pusbctl

install:
	$(INSTALL) -Dm 755 pusbctl -t "${DESTDIR}${PREFIX}${BINDIR}"
	$(INSTALL) -Dm 644 contrib/systemd/deny-new-usb.service -t "${DESTDIR}${PREFIX}${SYSTEMDUNITDIR}"
	$(INSTALL) -Dm 644 contrib/completion/bash/pusbctl -t "${DESTDIR}${PREFIX}${BASHCOMPDIR}"
	$(INSTALL) -Dm 644 contrib/completion/zsh/_pusbctl -t "${DESTDIR}${PREFIX}${ZSHCOMPDIR}"
	$(INSTALL) -Dm 644 doc/pusbctl.1 -t "${DESTDIR}${PREFIX}${MANDIR}"

uninstall:
	$(RM) -f "${DESTDIR}${PREFIX}${BINDIR}/pusbctl"
	$(RM) -f "${DESTDIR}${PREFIX}${SYSTEMDUNITDIR}/deny-new-usb.service"
	$(RM) -f "${DESTDIR}${PREFIX}${BASHCOMPDIR}/pusbctl"
	$(RM) -f "${DESTDIR}${PREFIX}${ZSHCOMPDIR}/_pusbctl"
	$(RM) -f "${DESTDIR}${PREFIX}${MANDIR}/pusbctl.1"
