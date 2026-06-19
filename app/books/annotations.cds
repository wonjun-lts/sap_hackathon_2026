using CloversFioriService as service from '../../srv/service';
annotate service.Books with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'BOOK_ID',
                Value : BOOK_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SAP_PRODUCT_ID',
                Value : SAP_PRODUCT_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ISBN',
                Value : ISBN,
            },
            {
                $Type : 'UI.DataField',
                Label : 'TITLE',
                Value : TITLE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'AUTHOR_NAME',
                Value : AUTHOR_NAME,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PUBLISHER',
                Value : PUBLISHER,
            },
            {
                $Type : 'UI.DataField',
                Label : 'GENRE',
                Value : GENRE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'RELEASE_DATE',
                Value : RELEASE_DATE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'UNIT_PRICE',
                Value : UNIT_PRICE,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CURRENCY',
                Value : CURRENCY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'INITIAL_PRINT_QTY',
                Value : INITIAL_PRINT_QTY,
            },
            {
                $Type : 'UI.DataField',
                Label : 'BOOK_STATUS',
                Value : BOOK_STATUS,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SOURCE_SYSTEM',
                Value : SOURCE_SYSTEM,
            },
            {
                $Type : 'UI.DataField',
                Label : 'UPDATED_AT',
                Value : UPDATED_AT,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'BOOK_ID',
            Value : BOOK_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'SAP_PRODUCT_ID',
            Value : SAP_PRODUCT_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ISBN',
            Value : ISBN,
        },
        {
            $Type : 'UI.DataField',
            Label : 'TITLE',
            Value : TITLE,
        },
        {
            $Type : 'UI.DataField',
            Label : 'AUTHOR_NAME',
            Value : AUTHOR_NAME,
        },
    ],
);

