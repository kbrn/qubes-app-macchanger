%global _enable_debug_package 0
%global debug_package %{nil}
%global __os_install_post /usr/lib/rpm/brp-compress %{nil}

%define version %(cat version)
%if 0%{?qubes_builder}
%define _builddir %(pwd)
%endif
    
Name:		qubes-app-macchanger
Version:	%{version}
Release:	1%{?dist}
Summary:	Randomizes the WiFi MAC address

Group:		System Environment/Daemons
License:	GPLv2
URL:		https://www.qubes-os.org/

BuildRequires:  systemd
Requires:   macchanger

%description
A hacky app to randomize WiFi MAC addresses.  Works for iwlwifi.

%prep
# we operate on the current directory, so no need to unpack anything
# symlink is to generate useful debuginfo packages
rm -f %{name}-%{version}
ln -sf . %{name}-%{version}
%setup -T -D

%build
make %{?_smp_mflags} all

%install
make install DESTDIR=%{buildroot}

%files
%doc README.md
%defattr(-,root,root,-)
/usr/lib/systemd/user/qubes-app-macchanger.service
%attr(0664,root,qubes) %config(noreplace) /usr/local/etc/qubes-macchanger/macchanger.conf
%attr(0774,root,qubes) /usr/local/libexec/qubes/change-mac.sh

%changelog

