package Alpaca::Types;
use Type::Library -base,
  -declare => qw( AlpacaField AlpacaFieldList );

use Type::Utils -all;
use Types::Standard -types;
use Safe::Isa;

class_type AlpacaField => { class => 'Alpaca::Field' };

declare AlpacaFieldList, as ArrayRef[AlpacaField];

my $get_package_name = sub {
  my $fieldType = shift;

  my $fieldTypeMap = {
    ckeditor     => 'CKEditor',
    datetime     => 'DateTime',
    ipv4         => 'IPv4',
    json         => 'JSON',
    personalname => 'PersonalName',
    url          => 'URL',
    zipcode      => 'ZipCode'
  };

  return exists $fieldTypeMap->{ $fieldType } ?
    $fieldTypeMap->{ $fieldType } : ucfirst( $fieldType );
};

coerce AlpacaFieldList, from ArrayRef[ AlpacaField | Str | HashRef ], via {
  my @items = @$_;
  my @fields;
 ITEM:
  while ( my $spec = shift @items ) {
    if ( AlpacaField->check( $spec ) ) {
      push @fields, $spec;
      next ITEM;
    }

    my $name = $spec;
    die "Invalid field spec, $name is not a field name"
      if ref $name;

    $spec = shift @items;
    die "Invalid field spec: $spec is not a hashref"
      unless ref $spec eq 'HASH';

    my $field_type = delete $spec->{type}
      or die "Invalid field spec: missing field type for $name";

    my $field_class = $get_package_name->( $field_type );

    my $create_field = eval{ $field_class->can('new') }
      or die "Invalid field spec: unknown field type $field_type";

    push @fields, $create_field->( $field_class, $spec );
  }

  return \@fields;
};
