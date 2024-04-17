use strict;
use warnings;
use needle;
use File::Basename;
use scheduler 'load_yaml_schedule';
use Carp;
BEGIN {
    unshift @INC, dirname(__FILE__) . '/../../lib';
}
use utils;
use testapi;
use main_common qw(init_main is_updates_test_repo unregister_needle_tags join_incidents_to_repo);
use main_micro_alp;
use DistributionProvider;

init_main();

my $distri = testapi::get_required_var('CASEDIR') . '/lib/susedistribution.pm';
require $distri;
testapi::set_distribution(susedistribution->new());


