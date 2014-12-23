var fs   = require("fs");
var gulp = require("gulp");
var pkg  = require("./package.json");
var path = require("path");
var handlebars  = require("gulp-handlebars");
var wrench = require("wrench");

gulp.task("build-site", function(cb)
{
    console.log("build-site start");

    applyFieldAnnotations("./site/docs/fields", function() {
        console.log("Annotations Completed");
        cb();
    });

});

gulp.task("default", [ "build-site" ]);


function getPackageBaseName( fieldType ) {
    var pkgBaseName;

    var fieldTypeMap = {
        'ckeditor':     'CKEditor',
        'datetime':     'DateTime',
        'ipv4':         'IPv4',
        'json':         'JSON',
        'personalname': 'PersonalName',
        'url':          'URL',
        'zipcode':      'ZipCode'
    };

    if ( fieldTypeMap[ fieldType ] ) {
        pkgBaseName = fieldTypeMap[ fieldType ];
    } else {
        pkgBaseName = fieldType.charAt(0).toUpperCase() + fieldType.slice(1);
    }
    return pkgBaseName;
}

function getPackageName( fieldType ) {
    return [
        'Alpaca', 'Field', getPackageBaseName( fieldType )
    ].join('::');
}

function getPerlType( type ) {
    return {
        'object':   'Object',
        'string':   'Str',
        'text':     'Str',
        'number':   'Num',
        'integer':  'Int',
        'boolean':  'Bool',
        'array':    'ArrayRef',
        'any':      'Any',

        'checkbox': undefined,
    }[ type ] || console.log( "Unknown type " + type );
}

function getPerlValue( type ) {
    return {
        'true': 1,
        'false': 0,
    }[ type ] || "'" + ( typeof type == 'string' ? type.replace( /'/g, "\\'" ) : type ) + "'";
}

var generateAttribute = function( schema, traitName  )
{
    var attr = "";

    for (var name in schema.properties)
    {
        var property = schema.properties[name];

        attr += "has " + name + " => (\n";
        attr += "  is => 'ro',\n";
        attr += "  traits => [qw/ " + traitName + " /],\n";
        if ( property.description ) {
            var description = property.description.replace( /'/g, "\\'" );
            attr += "  description => '" + description  + "',\n";
        }

        if ( property.type && getPerlType( property.type ) )
            attr += "  isa => " + getPerlType( property.type ) + ",\n";
        if ( property.default )
            attr += "  default => " + getPerlValue( property.default + '' ) + ",\n";
        attr += ");\n\n";
    }

    return attr;
};

var applyFieldAnnotationsToFile = function(filePath, Alpaca)
{
    var text = "" + fs.readFileSync(filePath);

    var c1 = text.indexOf("<!-- INCLUDE_API_DOCS:");
    if (c1 > -1)
    {
        var c2 = text.indexOf("-->", c1 + 1);
        if (c2 > -1)
        {
            var type = text.substring(c1 + 22, c2);
            type = type.trim();

            console.log(" -> Annotating type: " + type + " in file: " + filePath);

            var constructor = Alpaca.fieldClassRegistry[type];
            if (constructor)
            {
                var instance = new constructor();
                //domEl, data, options, schema, viewId, connector, errorCallback

                // schema
                var schemaSchema = instance.getSchemaOfSchema();
                //var schemaOptions = instance.getOptionsForSchema();

                // options
                var optionsSchema = instance.getSchemaOfOptions();
                //var optionsOptions = instance.getOptionsForOptions();

                // general
                var stampFunction = function(name, value, link)
                {
                    var x = "";
                    x += "<tr>";
                    x += "<td>" + name + "</td>";
                    x += "<td>";
                    if (link)
                    {
                        x += "<a href='" + link + "'>";
                    }
                    x += value;
                    if (link)
                    {
                        x += "</a>";
                    }
                    x += "</td>";
                    x += "</tr>";

                    return x;
                };
                var title = instance.getTitle();
                var description = instance.getDescription();
                var type = instance.getType();
                var fieldType = instance.getFieldType();
                var baseFieldType = instance.getBaseFieldType();

                var gen = "";
                gen += "<h3>Properties</h3>";

                gen += "<table class='table table-bordered table-responsive table-hover table-condensed'>";
                gen += "<tbody>";
                gen += stampFunction("Title", title);
                gen += stampFunction("Description", description);
                gen += stampFunction("JSON Schema Type(s)", type);
                gen += stampFunction("Field Type", fieldType, "/docs/fields/" + fieldType + ".html");
                if (baseFieldType)
                {
                    gen += stampFunction("Base Field Type", baseFieldType, "/docs/fields/" + baseFieldType + ".html");
                }
                else
                {
                    gen += stampFunction("Base Field Type", "None");
                }
                gen += "</tbody>";
                gen += "</table>";


                text = text.substring(0, c1) + gen + text.substring(c2 + 3);

                // fs.writeFileSync(filePath, text);


                var p5libPath = '.';
                var p5PathCmp = [ 'perl5', 'lib', 'Alpaca', 'Field' ];
                while ( p5PathCmp.length ) {
                    p5libPath = path.join( p5libPath, p5PathCmp.shift() );
                    if ( ! fs.existsSync( p5libPath ) )
                        fs.mkdirSync( p5libPath );
                }

                var source = "# This is an autogenerated file. Do not modify!\n\n"
                source += "package " + getPackageName( fieldType ) + ";\n\n";
                source += "use Moose;\n";
                source += "use Types::Standard qw(:all);\n";
                source += "BEGIN { extends 'Alpaca::Field' };\n\n"

                source += generateAttribute( schemaSchema, 'AlpacaSchema' );
                source += generateAttribute( optionsSchema, 'AlpacaOption' );

                source += "\n\n";
                source += "__PACKAGE__->meta->make_immutable;\n";
                source += "no Moose;\n\n1;\n";

                fs.writeFileSync(
                    path.join( p5libPath, getPackageBaseName( fieldType ) + '.pm' ),
                    source
                );
            }
            else
            {
                console.log(" -> Could not find field type: " + type);
            }
        }
    }
};

var applyFieldAnnotations = function(basePath, callback)
{
    var env = require('jsdom').env;
    var html = '<html><body><div id="form"></div></html>';

    var jQuerySrc = fs.readFileSync("./lib/jquery/dist/jquery.js", "utf-8");
    var alpacaSrc = fs.readFileSync("./build/alpaca/web/alpaca.js", "utf-8");
    var handlebarsSrc = fs.readFileSync("./lib/handlebars/handlebars.js", "utf-8");


    // first argument can be html string, filename, or url
    env(html, {
        src: [jQuerySrc, handlebarsSrc, alpacaSrc]
    }, function (errors, window) {

        global.$ = window.$;
        global.Alpaca = window.Alpaca;
        global.jQuery = window.$;
        global.Base = window.Base;
        global.Handlebars = window.Handlebars;

        $("#form").alpaca({
            "data": "",
            "view": "web-edit",
            "postRender": function(control)
            {
                var all = wrench.readdirSyncRecursive(basePath);

                var files = [];
                for (var i = 0; i < all.length; i++)
                {
                    if (all[i].indexOf(".md") > -1)
                    {
                        files.push(path.join(basePath, all[i]));
                    }
                }

                for (var i = 0; i < files.length; i++)
                {
                    applyFieldAnnotationsToFile(files[i], Alpaca);
                }

                callback();
            }
        });

    });
};
