# SUSE's openQA tests
#
# Copyright 2023-2024 SUSE LLC
# SPDX-License-Identifier: FSFAP

# Package: podmansh
# Summary: Test podmansh
# Maintainer: QE-C team <qa-c@suse.de>

use Mojo::Base 'containers::basetest';
use testapi;
use utils qw(script_retry systemctl zypper_call);
use serial_terminal 'select_serial_terminal';
use version_utils qw(package_version_cmp);
use containers::utils qw(container_ip);
use containers::utils qw(get_podman_version);

sub run{
    my ($self, $args) = @_;

    select_serial_terminal;
    my $podman = $self->containers_factory('podman');
    $podman->cleanup_system_host();

    zypper_call("--quiet in podmansh", timeout => 300);

    record_info('Setup', 'Change the default shell');
    assert_script_run("usermod -s /usr/bin/podmansh $testapi::username");
    validate_script_output();
    my $uid = script_output("id -u $testapi::username");
    my $podmansh_unit = <<_EOF_;
[Unit]
Description=The podmansh container
After=local-fs.target

[Container]
Image=registry.opensuse.org/opensuse/busybox:latest
ContainerName=podmansh
RemapUsers=keep-id
RunInit=yes
DropCapability=all
NoNewPrivileges=true
Environment=CONTAINER_NAME=%n

Exec=sleep infinity

[Install]
RequiredBy=default.target
_EOF_



}

1;
