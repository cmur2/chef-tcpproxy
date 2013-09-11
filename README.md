# chef-tcpproxy

[![Build Status](https://travis-ci.org/cmur2/chef-tcpproxy.png)](https://travis-ci.org/cmur2/chef-tcpproxy)

## Description

Configures the IPv4/IPv6 connection proxy - tcpproxy - from [http://spreadspace.org/tcpproxy/}(http://spreadspace.org/tcpproxy/) via */etc/tcpproxy.conf*. But it does **not** install it since there are multiple ways.

## Usage

Use `recipe[tcpproxy::default]` for configuring from the information in `node['tcpproxy']`.

## Requirements

### Platform

As long as the configuration for tcpproxy is located at */etc/tcpproxy.conf* it works with any installation forms.

For supported Chef/Ruby version see [Travis](https://travis-ci.org/cmur2/chef-tcpproxy).

## Recipes

[A### default

Uses name => hash entries from `node['tcpproxy']['listen']` to generate a configuration like [this](https://svn.spreadspace.org/tcpproxy/trunk/contrib/example.conf):

	node['tcpproxy']['listen']['example1'] = {
		"local" => "* 8000",
		"resolv" => "ipv4",
		"remote" => "www.google.at 80",
		"remote-resolv" => "ipv6",
		"source" => "2a02:3e0:2002:1:218:deff:fe03:ed"
	}

*example1* is an internal name not expressed in the configuration for distinguishing the different listen entries. The above example produces:

	listen * 8000 {
	  resolv: ipv4;
	  remote: www.google.at 80;
	  remote-resolv: ipv6;
	  source: 2a02:3e0:2002:1:218:deff:fe03:ed;
	};

## License

chef-tcpproxy is licensed under the Apache License, Version 2.0. See LICENSE for more information.
