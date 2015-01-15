Summary: compact
Name: compact
Version: 1.0.0
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
* Mon Jun 30 2014 pinkra <jobezic@gmail.com> - 1.0.0-1.el6
- First Version
