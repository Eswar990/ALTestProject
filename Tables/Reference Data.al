table 50101 "Reference Data"
{
    Caption = 'Reference Data';
    DrillDownPageID = "Reference Data List";
    LookupPageID = "Reference Data List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Year,Month;
        }
        field(2; "Code"; code[20])
        {
            Caption = 'Code';
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Sorting Value"; code[10])
        {
            Caption = 'Sorting Values';
        }
    }
    keys
    {
        key(PK; Type, Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}
