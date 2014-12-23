# This is an autogenerated file. Do not modify!

package Alpaca::Field::URL;

use Moose;
use Types::Standard qw(:all);
BEGIN { extends 'Alpaca::Field' };

has title => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Short description of the property.',
  isa => Str,
);

has description => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Detailed description of the property.',
  isa => Str,
);

has readonly => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Property will be readonly if true.',
  isa => Bool,
);

has required => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Property value must be set if true.',
  isa => Bool,
);

has default => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Default value of the property.',
  isa => Any,
);

has type => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Data type of the property.',
  isa => Str,
  default => 'string',
);

has format => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Data format of the property.',
  isa => Str,
);

has disallow => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'List of disallowed values for the property.',
  isa => ArrayRef,
);

has dependencies => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'List of property dependencies.',
  isa => ArrayRef,
);

has enum => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'List of specific values for this property',
  isa => ArrayRef,
);

has minLength => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Minimal length of the property value.',
  isa => Num,
);

has maxLength => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Maximum length of the property value.',
  isa => Num,
);

has pattern => (
  is => 'ro',
  traits => [qw/ AlpacaSchema /],
  description => 'Regular expression for the property value.',
  isa => Str,
);

has form => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Options for rendering the FORM tag.',
  isa => Object,
);

has id => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Unique field id. Auto-generated if not provided.',
  isa => Str,
);

has type => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field type.',
  isa => Str,
  default => 'url',
);

has validate => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field validation is required if true.',
  isa => Bool,
  default => 1,
);

has showMessages => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Display validation messages if true.',
  isa => Bool,
  default => 1,
);

has disabled => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field will be disabled if true.',
  isa => Bool,
);

has readonly => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field will be readonly if true.',
  isa => Bool,
);

has hidden => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field will be hidden if true.',
  isa => Bool,
);

has label => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field label.',
  isa => Str,
);

has helper => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field help message.',
  isa => Str,
);

has fieldClass => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Specifies one or more CSS classes that should be applied to the dom element for this field once it is rendered.  Supports a single value, comma-delimited values, space-delimited values or values passed in as an array.',
  isa => Str,
);

has hideInitValidationError => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Hide initial validation errors if true.',
  isa => Bool,
);

has focus => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'If true, the initial focus for the form will be set to the first child element (usually the first field in the form).  If a field name or path is provided, then the specified child field will receive focus.  For example, you might set focus to \'name\' (selecting the \'name\' field) or you might set it to \'client/name\' which picks the \'name\' field on the \'client\' object.',
  default => 1,
);

has optionLabels => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'An array of string labels for items in the enum array',
  isa => ArrayRef,
);

has view => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Allows for this field to be rendered with a different view (such as \'display\' or \'create\')',
  isa => Str,
);

has name => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field Name.',
  isa => Str,
);

has size => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field size.',
  isa => Num,
  default => '40',
);

has maskString => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Expression for the field mask. Field masking will be enabled if not empty.',
  isa => Str,
);

has placeholder => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Field placeholder.',
  isa => Str,
);

has typeahead => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Provides configuration for the $.typeahead plugin if it is available.  For full configuration options, see: https://github.com/twitter/typeahead.js',
);

has allowOptionalEmpty => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Allows this non-required field to validate when the value is empty',
);

has inputType => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Allows for the override of the underlying HTML5 input type.  If not specified, an assumed value is provided based on the kind of input control (i.e. \'text\', \'date\', \'email\' and so forth)',
  isa => Str,
);

has data => (
  is => 'ro',
  traits => [qw/ AlpacaOption /],
  description => 'Allows you to specify a key/value map of data attributes that will be added as DOM attribuets for the underlying input control.  The data attributes will be added as data-{name}=\'{value}\'.',
  isa => Object,
);



__PACKAGE__->meta->make_immutable;
no Moose;

1;
