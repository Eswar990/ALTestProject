tableextension 50102 "DimensionValues TableExe" extends "Dimension Value"
{
    fields
    {
        field(50100; "Year"; Code[20])
        {
            Caption = 'Year';
        }
        field(50101; "Month"; Code[20])
        {
            Caption = 'Month';
        }
        field(50103; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50104; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Project One';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50105; "Shortcut Dimension 3 Two"; Code[20])
        {
            Caption = 'Project Two';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50106; "Shortcut Dimension 3 Three"; Code[20])
        {
            Caption = 'Project Thee';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50107; "Percentage One"; Decimal)
        {
            Caption = 'Percentage One';
        }
        field(50108; "Percentage Two"; Decimal)
        {
            Caption = 'Percentage Two';
        }
        field(50109; "Percentage Thee"; Decimal)
        {
            Caption = 'Percentage Three';
        }
        field(50102; "Distribute Enable"; Boolean)
        {
            Caption = 'Distribute Enable';
        }
    }
}
