table 50105 "Distribution Rule"
{
    Caption = 'Distribution Rule';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Shortcut Dimension2 Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(4; "Shortcut Dimension3 Code"; Code[20])
        {
            Caption = 'Project Code';
        }
        field(5; "Shortcut Dimension1 Code"; Code[20])
        {
            Caption = 'Employee Code';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        Field(7; "G/L Account No."; Code[10])
        {
            Caption = 'G/L Account No.';
        }
        field(8; "Ammount Allocated"; Decimal)
        {
            Caption = 'Ammount Allocated';
        }
        field(9; "Emp. Project Count"; Integer)
        {
            Caption = 'Emp. Project Count';
        }
        field(10; "Emp. Project Percentage"; Decimal)
        {
            Caption = 'Emp. Project Percentage';
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(12; Amount; Decimal)
        {

        }
        field(13; "Remaining Amount"; Decimal)
        {

        }
    }
    keys
    {
        key(PK; "Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
