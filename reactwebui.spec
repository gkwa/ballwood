Name        : streambox_react_webui
Version     : 1.8.0
Release     : 1
BuildArch   : noarch
Group       : Applications/Multimedia
License     : Streambox SL
Vendor      : Streambox, Inc.
Packager    : info@streambox.com
URL         : https://www.streambox.com
Summary     : Streambox React-based webUI

%define _source_payload w0.gzdio
%define _binary_payload w0.gzdio

Source0: streambox-react-webui.tgz

%description
	React-based webUI for Streambox Encoder/Decoder
	w/ REST API

%prep
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

%build
echo Building %{name}-%{version}-%{release}
mkdir -p "%{buildroot}"

%install
install -d -m 0755 %{buildroot}
tar -x -p -z -f %{SOURCE0} -C %{buildroot}

%pre

%post
if [ -e /var/www/html/index.html ]; then
	DATET=$(date +%y%m%d_%H%M)
	mv /var/www/html/index.html /var/www/html/index.${DATET}.html
fi

%preun

%postun

%files
%attr(-,root,root) /var/www/html/*
%attr(-,root,root) /var/local/WebData/templates/*

%changelog

* Fri Aug 5 2022 Heiichiro NAKAMURA <heiichiro.nakamura@streambox.com> 0.0.2
- updated

* Fri Aug 5 2022 Heiichiro NAKAMURA <heiichiro.nakamura@streambox.com> 0.0.1
- initial package
