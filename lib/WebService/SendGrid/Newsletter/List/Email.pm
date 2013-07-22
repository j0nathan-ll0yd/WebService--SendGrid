package WebService::SendGrid::Newsletter::List::Email;
use utf8;
use Moose;
use MooseX::Method::Signatures;
use JSON::XS;

BEGIN { extends 'WebService::SendGrid::Newsletter'; }

=head1 See SendGrid Documentation
See http://docs.sendgrid.com/documentation/api/newsletter-api/lists/email/

Note that this module is List::Email, not Lists::Email.
=cut

method add (Str :$list, ArrayRef :$data) {
    my %request_data;
    $request_data{list} = $list;
    if (ref($data) eq 'ARRAY') {
	my @data = map { encode_json($_) } @$data;
	$request_data{data} = \@data;
    } else {
	$request_data{data} = $data;
    }

    my $req = $self->_generate_request('/api/newsletter/lists/email/add.json', \%request_data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method get (Str :$list, ArrayRef|Str :$email?) {
    my %request_data;
    $request_data{list} = $list if $list;    
    $request_data{email} = $email;

    my $req = $self->_generate_request('/api/newsletter/lists/email/get.json', \%request_data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

method delete (Str :$list, ArrayRef|Str :$email?) {
    my %request_data;
    $request_data{list} = $list if $list;    
    $request_data{email} = $email;

    my $req = $self->_generate_request('/api/newsletter/lists/email/delete.json', \%request_data);
    my $res = $self->_dispatch_request($req);
    return $self->_process_error($res) if ($res->code != 200 and $res->code != 100);
    return decode_json $res->content;
}

1;
