#!/usr/bin/env perl

use Carp;
use JSON::XS;
use Getopt::Long qw(GetOptions);
use Data::Dumper;
use feature 'say';

=doc Script para puesta en marcha del proyecto

    He usado perl pues viene por defecto en casi todas las distribuciones de Linux al menos en las variantes de debian y es el lenguaje al que estoy acostumbrado.

    Podemos automatizar todo el proceso y mantener un inventario con los deply , la idea es que si esto fuera de servicios a desplegar a distintos clientes
    tan solo se tendria que clonar el repositorio y cada cliente tendria su deploy preparado.

     > git clone https://github.com/nm2971119x/ansible-terraform proyecto-cliente-1/
     > ./Install init

=cut

my $config;

my $Opt = {
    init    => { arg => 'Init' },
    test    => { arg => 'Test' },
    ansible => { arg => 'Ansible Playbooks', extra => 's' },
    roles   => { arg => 'Muestra los roles disponibles' },
};

sub Uso {
    say qq{\nMaster DevOP : Practica 2\n};
    map {
	my $pad = length($_) > 9 ? "\t" : "\t\t"; $pad = "\t\t\t" if length($_) < 5;
	say qq{ --$_$pad$Opt->{$_}->{arg}} 
    } sort keys %{$Opt};
    say "";
    exit;
}

sub LoadConfig {
    my $file = shift;
    
    my $content = do {
	local $/ = undef;
	open my $fh, "<", $file or die "Error: $!";
	<$fh>;
    };
    
    return decode_json $content;
}

sub Init {
    my $init_file = "secrets/.init";
    
    ## Si esta el fichero secrets/init ya se han generado este paso y omitimos
    return if -e $init_file;

    ## Generamos las clave publica
    qx{ssh-keygen -t rsa -b 4096 -f secrets/key-ssh -q -N ""};

    ## Damos por creado todo Ok
    qx{touch secrets/.init};    
}

sub Test {

    Ansible();
    TerraForm();
}

sub Ansible {

    my $Checks = {
	'ansible-playbook' => '/usr/bin/ansible-playbook'
    };

    for my $Check ( keys %{$Checks} ) {
	croak "[ERROR] $Check => $Checks->{$Check}" unless -e $Checks->{$Check};
    }

}

sub TerraForm {

    ## Se ha iniciado ya terraform , fichero : .terraform.lock.hcl
    return if -e "terraform/.terraform.lock.hcl";
    
    ## Terraform binary
    qx{wget $config->{terraform_bin} -O bin/terraform_1.1.7_linux_amd64.zip};
    qx{unzip bin/terraform_1.1.7_linux_amd64.zip};
}

sub Roles {
    opendir(my $dh, 'ansible/roles') || die "Error: $!";
    while (readdir $dh) {
	next if $_ =~ /^\./;
	say qq{$_};
    }
    closedir $dh;
}

sub AnsibleExec {

}

GetOptions(
    'init'      => \$Opt->{init}->{val},
    'test'      => \$Opt->{test}->{val},
    'ansible=s' => \$Opt->{ansible}->{val},
    'roles'     => \$Opt->{roles}->{val},
    ) or die Uso($Opt);

## MAIN

Uso() unless $ARGV[0];

$config = LoadConfig('config.json');

if ( $Opt->{init}->{val} ) {
    Init();
} elsif ( $Opt->{roles}->{val} ) {
    Roles();
} elsif (  $Opt->{ansible}->{val} ) {
    AnsibleExec();
}
