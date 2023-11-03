table 50100 "Distribution Header"
{
    Caption = 'Distribution Header';
    DrillDownPageId = "Reference Data List";
    LookupPageId = "Reference Data List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; year; Code[20])
        {
            TableRelation = "Reference Data".Code where(Code = field(Year), "Sorting Value" = filter(= ''));
        }
        field(3; Month; Code[20])
        {
            TableRelation = "Reference Data".Code where("Sorting Value" = filter(<> ''));
        }
        field(4; "Previous Year"; Code[20])
        {
            TableRelation = "Reference Data".Code where("Sorting Value" = filter(= ''));
        }
        field(5; "Previous Month"; Code[20])
        {
            TableRelation = "Reference Data".Code where("Sorting Value" = filter(<> ''));
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
        Dimensions: Record Dimension;
        Dimensionsvalue: Record "Dimension Value";
        DimensionPage: page "Dimension Values";
        GLEntry: Record "G/L Entry";
        GLEntryPAGE: Page "General Ledger Entries";
}