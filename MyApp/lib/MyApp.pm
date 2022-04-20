package MyApp;
use Moose;
use namespace::autoclean;
use utf8;
use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple

    StackTrace
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in myapp.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

#__PACKAGE__->config(
#    name => 'MyApp',
    # Disable deprecated behavior needed by old applications
#    disable_component_resolution_regex_fallback => 1,
#    enable_catalyst_header => 1, # Send X-Catalyst header
#    encoding => 'UTF-8', # Setup request decoding and response encoding
#);

__PACKAGE__->config(
    name => 'MyApp',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
	'View::HTML' => {
        ENCODING => 'UTF-8',
        #Set the location for TT files
        INCLUDE_PATH => [
            __PACKAGE__->path_to( 'root', 'src' ),
        ],
    },
);

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

MyApp - Catalyst based application

=head1 SYNOPSIS

    script/myapp_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<MyApp::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Ileasevici Victor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
