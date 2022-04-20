package MyApp::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

MyApp::Controller::Root - Root Controller for MyApp

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

our $update_id;

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    $c->stash(books => [$c->model('DB::Book')->all]);
    $c->stash(template => 'list.tt2');
}

sub base :Chained('/') :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(resultset => $c->model('DB::Book'));
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

sub add_contact :Chained('base') :PathPart('add_contact') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'add_contact.tt2');
}
 
sub create_contact :Chained('base') :PathPart('create_contact') :Args(0) {
    my ($self, $c) = @_;
 
    my $first_name = $c->request->params->{first_name} || 'N/A';
    my $last_name = $c->request->params->{last_name} || 'N/A';
    my $phone = $c->request->params->{phone} || 'N/A';
 
    my $book = $c->model('DB::Book')->create({
            first_name => $first_name,
            last_name  => $last_name,
            phone      => $phone,
    });

    $c->response->redirect($c->uri_for($self->action_for('list'),
        {status_msg => "Контакт создан!"}));
}

sub update :Chained('object') :PathPart('update') :Args(0) {
    my ($self, $c) = @_;

    $update_id = $c->stash->{object};
    $c->stash(template => 'edit_contact.tt2');
}

sub change_contact :Chained('base') :PathPart('change_contact') :Args(0) {
    my ($self, $c) = @_;

    my $first_name = $c->request->params->{first_name} || 'N/A';
    my $last_name = $c->request->params->{last_name} || 'N/A';
    my $phone = $c->request->params->{phone} || 'N/A';

    $update_id->update ({
        first_name => $first_name,
        last_name  => $last_name,
        phone      => $phone,
    });

    $c->response->redirect($c->uri_for($self->action_for('list'),
        {status_msg => "Контакт изменен!"}));
}
 
sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;
 
    $c->stash(object => $c->stash->{resultset}->find($id));

    die "Контакт $id не найден!" if !$c->stash->{object};
 
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{object}->delete;
    $c->response->redirect($c->uri_for($self->action_for('list'),
        {status_msg => "Контакт удален!"}));
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Страница не найдена' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Ileasevici Victor,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
