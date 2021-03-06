use Test::Nginx::Socket 'no_plan';
use JSON;

no_root_location;

run_tests();

sub j {
	my @keys = @_;

	return sub {
		my ($resp) = @_;
		my $result = decode_json( $resp );

		my @values = ();
		foreach my $key (@keys) {
			push @values, eval '$result->' . $key;
		}

		return join("|", @values);
	}
}

__DATA__

=== TEST 1: hello, world
--- http_config
include ../../../conf/http.conf;
--- config
include ../../../conf/server.conf;
--- request
GET /hello
--- response_body
hello! this is Mio.
--- error_code: 200
