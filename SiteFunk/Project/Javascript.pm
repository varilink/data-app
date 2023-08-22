package SiteFunk::Project::Javascript ;

=head1 SiteFunk::Project::Javascript

=cut

use strict ;
use Env qw / HOME / ;
use Cwd ;
use File::Basename ;
use File::Path qw / make_path / ;

use base qw / SiteFunk::Project::Asset / ;

sub load {

	my ( $self , $file ) = @_ ;

	my $pwd = cwd ;

	my ( $name , $path , $suffix ) = fileparse ( $pwd . '/' . $file , '.js' ) ;

	my $root = $HOME . '/Projects/' . $self -> sitename ;

	$path =~ /$root\/(.*)/ ;

	my $relpath = $1 ;

	open GULP , $file ;
	my @lines = <GULP> ;
	close GULP ;

	$self -> name ( $name ) ;
	$self -> path ( $relpath ) ;
	$self -> content ( \@lines ) ;

}

sub copy {

	my $self = shift ;

	my $name = $self -> name ;
	my $path = $self -> path ;
	my $sitename = $self -> sitename ;

	my $out = "$HOME/vhosts/$sitename/$path$name.js" ;
	my $dir = dirname ( $out ) ;

	make_path ( $dir ) ;

	open TT , '>' , $out ;

	print TT @{ $self -> content } ;
	
	close TT ;	

}

1 ;

__END__