table 50104 "Distribution Project"
{
    Caption = 'Distribution Project';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Project';
        }
        field(3; "Project Amount"; Decimal)
        {
            Caption = 'Project Amount';
        }
        field(4; "Project Line"; Boolean)
        {
            Caption = 'Project Line';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(7; "Emp.Count"; Integer)
        {
            Caption = 'Emp.Count';
        }
        field(8; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code")
        {
            Clustered = true;
        }
    }
}
