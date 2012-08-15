package WebService::SendGrid::Newsletter;
use utf8;
use Moose;
use MooseX::Method::Signatures;
BEGIN { extends 'WebService::SendGrid'; }

# use WWW::Curl::Simple;
use HTTP::Request;
use JSON::XS;

=head1 See SendGrid Documentation
See http://docs.sendgrid.com/documentation/api/newsletter-api/newsletter/
=cut

method add (Str :$identity, Str :$name, Str :$subject, Str :$text, Str :$html) {
    my %data;
    $data{identity} = $identity;
    $data{name} = $name;
    $data{subject} = $subject;
    $data{text} = $text;
    $data{html} = $html;

    my $req = $self->_generate_request('/api/newsletter/add.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method get (Str :$name) {
    my %data;
    $data{name} = $name;

    my $req = $self->_generate_request('/api/newsletter/get.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 401);
    return decode_json $res->content;
}

method edit (Str :$name, Str :$newname, Str :$identity, Str :$subject, Str :$text, Str :$html) {
    my %data;
    $data{name} = $name;
    $data{newname} = $newname;
    $data{identity} = $identity;
    $data{subject} = $subject;
    $data{text} = $text;
    $data{html} = $html;

    my $req = $self->_generate_request('/api/newsletter/edit.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method list (Str :$name?) {
    my %data;
    $data{name} = $name if ($name);

    my $req = $self->_generate_request('/api/newsletter/list.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method delete (Str :$name) {
    my %data;
    $data{name} = $name;
    my $req = $self->_generate_request('/api/newsletter/delete.json', \%data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

1;
