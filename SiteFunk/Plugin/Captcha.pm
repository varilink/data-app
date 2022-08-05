package SiteFunk::Plugin::Captcha ;

=head1 SiteFunk::Plugin::Captcha

CGI:Application integration with Google's reCAPTCHA

=cut

use strict ;

use base qw / Exporter / ;

sub verify {

=head2 verify

Verify's a user's reCAPTCHA response

=cut

   my $self = shift ;

   my $query = $self -> query ;

   my $captcha = $query -> param ( 'g-recaptcha-response' ) ;

   # HTTP client
   use LWP::UserAgent ;

   my $user_agent = new LWP::UserAgent (

      # Ensure valid certificate
      ssl_opts => { verify_hostname => 1 }

   ) ;

   my $response = $user_agent -> post (

      'https://www.google.com/recaptcha/api/siteverify' ,

      {
         secret => '6LcreBcTAAAAAGX1e7pY8Hv6ayKJbshxW_JoZ3rn' ,
         response => $captcha ,
      } ,

   ) ;

   my $json_text = $response -> content ;

}

sub import {

   my $caller = scalar caller ;

   $caller -> add_callback (

      'init' , \&_init

   ) ;

   goto &Exporter::import ;

}

1 ;

__END__
