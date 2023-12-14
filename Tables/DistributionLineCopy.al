table 50107 "Distribution Line Copy"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Code[20])
        {
            Caption = 'Year';
        }
        field(2; "Month"; Code[20])
        {
            Caption = 'Month';
        }
        field(3; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Employe Code';
        }
        field(4; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Branch Code';
        }
        field(5; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Project One';
        }
        field(6; "Shortcut Dimension 3 Two"; Code[20])
        {
            Caption = 'Project Two';
        }
        field(7; "Shortcut Dimension 3 Three"; Code[20])
        {
            Caption = 'Project Thee';
        }
        field(8; "Percentage One"; Decimal)
        {
            Caption = 'Percentage One';
        }
        field(9; "Percentage Two"; Decimal)
        {
            Caption = 'Percentage Two';
        }
        field(10; "Percentage Three"; Decimal)
        {
            Caption = 'Percentage Three';
        }
        field(11; "Line No."; Integer)
        {
            Caption = '"Line No."';
        }

    }

    keys
    {
        key(PK; Year, Month, "Shortcut Dimension 1 Code")
        {
            Clustered = true;
        }
    }
}