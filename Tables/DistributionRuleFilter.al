table 50103 "Distribution Rule Filter"
{
    // Caption = 'Distribution Rule Filter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Dimension Filter"; Code[20])
        {
            Caption = 'Dimension Filter';
        }
        field(3; "Dimension Value"; Code[20])
        {
            Caption = 'Dimension Value';
        }
        field(4; "Distribution Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionMembers = ,Equally,propotion,,maually;
        }
        field(5; "Negative Allocation"; Boolean)
        {
            Caption = 'Negative allocation';
        }
        field(6; "Sales Invoice"; Boolean)
        {
            Caption = 'Sales Invoice';
        }
        field(7; "G/L Amount"; Decimal)
        {
            Caption = 'G?L Amount';
        }
        field(8; "Distribution Amount"; Decimal)
        {
            Caption = 'Distribution Amount';
        }
        field(9; "Dimension Filter Exsist"; Boolean)
        {
            Caption = 'Dimension Filter Exsist';
        }
        field(10; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }
        field(11; "Dimension Value One"; Code[20])
        {
            Caption = 'Dimension Value One';
        }
        field(12; "Distrubution Amount One"; Decimal)
        {
            Caption = 'Dimension Amount One';
        }
        field(13; "Dimension Value Two"; Code[20])
        {
            Caption = 'Dimension Value Two';
        }
        field(14; "Distrubution Amount Two"; Decimal)
        {
            Caption = 'Dimension Amount Two';
        }
        field(15; "Dimension Value Three"; Code[20])
        {
            Caption = 'Dimension Value Three';
        }
        field(16; "Distrubution Amount Three"; Decimal)
        {
            Caption = 'Dimension Amount Three';
        }
        field(17; "Dimension Value Four"; Code[20])
        {
            Caption = 'Dimension Value Four';
        }
        field(18; "Distrubution Amount Four"; Decimal)
        {
            Caption = 'Dimension Amount Four';
        }
        field(19; "Dimension Value Five"; Code[20])
        {
            Caption = 'Dimension Value Five';
        }
        field(20; "Distrubution Amount Five"; Decimal)
        {
            Caption = 'Dimension Amount Five';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
