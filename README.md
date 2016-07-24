qubes-app-macchanger
====
Install this package both in your NetVM and the TemplateVM it's based on.  Then (optionally) configure it to attempt to prevent leaks by putting in the original MAC in `/usr/local/etc/qubes-macchanger/macchanger.conf`.  Then enable the serice in your NetVM: add `qubes-app-macchanger` to its services tab in Qubes Manager.
