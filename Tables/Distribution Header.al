table 50100 "Distribution Header"
{
    Caption = 'Distribution Header';
    // DrillDownPageId = "Reference Data List";
    // LookupPageId = "Reference Data List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; year; Code[20])
        {
            TableRelation = "Reference Data".Code;
        }
        field(3; Month; Code[20])
        {
            TableRelation = "Reference Data".Code;
        }
        field(4; "Previous Year"; Code[20])
        {
            TableRelation = "Reference Data".Code;
        }
        field(5; "Previous Month"; Code[20])
        {
            TableRelation = "Reference Data".Code;
        }

    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        so: Record "Sales Line";
        So1: Record "Sales Header";
        Soo: page "Sales Order";
        sop: Page "Sales Order Subform";
        Customer: Record Customer;
}