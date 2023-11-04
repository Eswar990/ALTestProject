table 50104 "Distribution Project"
{
    Caption = 'Distribution Project';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = '';
        }
        field(3; "Project Amount"; Decimal)
        {
            Caption = '';
        }
        field(4; "Project Line"; Boolean)
        {
            Caption = '';
        }
        field(5; "Line No."; Integer)
        {
            Caption = '';
        }
        field(6; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = '';
        }
        field(7; "Emp.Count"; Integer)
        {
            Caption = '';
        }
        field(8; "G/L Account No."; Code[20])
        {

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
