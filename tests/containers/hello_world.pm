# SUSE's openQA tests
#
# Copyright 2023-2024 SUSE LLC
# SPDX-License-Identifier: FSFAP

# Package: podman network
# Summary: Test podman network
# Maintainer: QE-C team <qa-c@suse.de>

use Mojo::Base 'containers::basetest';
use testapi;
use serial_terminal 'select_serial_terminal';
use utils;
use containers::common;
use containers::utils;
use containers::container_images;

sub run {
    my ($self, $args) = @_;
    die('You must define a engine') unless ($args->{runtime});
    $self->{runtime} = $args->{runtime};
    select_serial_terminal;

    my $engine = $self->containers_factory($self->{runtime});

    assert_script_run("$engine run $image");

}
1;
