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
        }
        field(50104; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Project One';
        }
        field(50105; "Shortcut Dimension 3 Two"; Code[20])
        {
            Caption = 'Project Two';
        }
        field(50106; "Shortcut Dimension 3 Three"; Code[20])
        {
            Caption = 'Project Thee';
        }
        field(50107; "Percentage One"; Decimal)
        {
            Caption = 'Percentage One';
        }
        field(50108; "Percentage Two"; Decimal)
        {
            Caption = 'Percentage Two';
        }
        field(50109; "Percentage Three"; Decimal)
        {
            Caption = 'Percentage Three';
        }
        field(50102; "Distribute Enable"; Boolean)
        {
            Caption = 'Distribute Enable';
            Editable = false;
        }
    }
}
