use strict;
use warnings;
use HTTP::Daemon;
use HTTP::Status;

my $d = HTTP::Daemon->new(LocalPort => 3000, ReuseAddr => 1) || die;
print "Servidor en: ", $d->url, "\n";

while (my $c = $d->accept) {
    while (my $r = $c->get_request) {
        if ($r->method eq 'GET' and $r->uri->path eq "/") {
            $c->send_response(HTTP::Response->new(RC_OK, undef, ['Content-Type' => 'text/plain'], "Hola desde Perl en Docker"));
        } else {
            $c->send_error(RC_FORBIDDEN);
        }
    }
    $c->close;
    undef($c);
}
