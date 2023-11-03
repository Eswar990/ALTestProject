table 50102 "Distribution Line"
{
    Caption = 'Distribution Line';
    DrillDownPageId = Dimensions;
    LookupPageId = Dimensions;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Code[20])
        {
            Caption = 'Year';
            TableRelation = "Reference Data".Code where(Code = field(Year), "Sorting Value" = filter(= ''));
        }
        field(2; "Month"; Code[20])
        {
            Caption = 'Month';
            TableRelation = "Reference Data".Code where("Sorting Value" = filter(<> ''));
        }
        field(3; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Employe Code';
            // TableRelation = "Dimension Value".Code where();
            TableRelation = Dimension.Code; // where(Code = field("Shortcut Dimension 1 Code"));
        }
        field(4; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code;
        }
        field(5; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Project One';
            TableRelation = "Dimension Value".Code;
        }
        field(6; "Shortcut Dimension 3 Two"; Code[20])
        {
            Caption = 'Project Two';
            TableRelation = "Dimension Value".Code;
        }
        field(7; "Shortcut Dimension 3 Three"; Code[20])
        {
            Caption = 'Project Thee';
            TableRelation = "Dimension Value".Code;
        }
        field(8; "Percentage One"; Decimal)
        {
            Caption = 'Percentage One';
        }
        field(9; "Percentage Two"; Decimal)
        {
            Caption = 'Percentage Two';
        }
        field(10; "Percentage Thee"; Decimal)
        {
            Caption = 'Percentage Three';
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
