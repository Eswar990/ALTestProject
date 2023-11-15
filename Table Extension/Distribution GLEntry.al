tableextension 50101 "Distribution GLEntry" extends "G/L Entry"
{
    fields
    {
        field(50100; "Distributio Rule Applied"; Boolean)
        {
            Caption = 'Distribution Rule Applied';
        }
        field(50101; "Distribution Required"; Boolean)
        {
            Caption = 'Distribution Required';
        }
        field(50102; "Dist. Entry No Applied"; Integer)
        {
            Caption = 'Dist. Entry No Applied';
        }
        field(50103; "Account Category"; Enum "G/L Account Category")
        {
            BlankZero = true;
            Caption = 'Account Category';
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Account"."Account Category" where("No." = field("G/L Account No.")));
        }
    }
    procedure DistributionNoApplied()
    begin
        DuplicateNumber1 := Rec."Entry No.";
        if (Duplicatenumber2 = Iterator) then begin
            Duplicatenumber2 := DuplicateNumber1;
            Iterator := (Iterator + 1);
            Commit();
        end;
        Rec."Dist. Entry No Applied" := Duplicatenumber2;
    end;

    var
        Iterator: Integer;
        DuplicateNumber1: Integer;
        Duplicatenumber2: Integer;
        DistributionRuleFilter: Record "Distribution Rule Filter";
}
