Summary: compact
Name: compact
Version: 1.0.3
Release: 1%{?dist}
License: GPL
Group: Web
Source0: %{name}-%{version}.tar.gz
Packager: pinkra <jobezic@gmail.com>

BuildArch: noarch

AutoReq: no

%description
Compact https://github.com/pinkra/compact

%prep
%setup -q

%build

%install
make install DESTDIR=tmp_build
(cd tmp_build ; find . -depth -print | cpio -dump $RPM_BUILD_ROOT)

%post

%preun

%clean

%files
%defattr(-,root,root)
/usr/bin/compact.pl
/usr/share/docs/%{name}-%{version}/config.compact.sample
/usr/share/perl5/CSS/Minifier.pm
/usr/share/perl5/JavaScript/Minifier.pm



%changelog
* Tue May 12 2015 pinkra <jobezic@gmail.com> - 1.0.3-1.el6
- Fix css and js prefixes code.

* Tue May 12 2015 pinkra <jobezic@gmail.com> - 1.0.2-1.el6
- Fix regex.

* Wed Apr 15 2015 pinkra <jobezic@gmail.com> - 1.0.1-1.el6
- Add js and css prefix in config, fix comments

* Mon Feb 09 2015 Giacomo Sanchietti <giacomo.sanchietti@nethesis.it> - 1.0.0-1.ns6
- First public release

* Mon Jun 30 2014 pinkra <jobezic@gmail.com> - 1.0.0-1.el6
- First Version
