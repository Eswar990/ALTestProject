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
    var
        GeneralLedgerEntry: record "G/L Entry";
        Count: Integer;
    begin
        // GeneralLedgerEntry.Reset();
        // GeneralLedgerEntry.SetRange("Entry No.", "Entry No.");
        // GeneralLedgerEntry.SetRange("Document No.", "Document No.");
        // GeneralLedgerEntry.SetRange("Document Type", "Document Type"::Invoice);
        // GeneralLedgerEntry.SetRange("Account Category", AccountType::Income);
        // if (GeneralLedgerEntry.FindSet()) then begin
        //     repeat
        //         Count += 1;
        //         if (GeneralLedgerEntry.FindLast()) then
        //             GeneralLedgerEntry."Dist. Entry No Applied" := GeneralLedgerEntry."Entry No.";
        //     until GeneralLedgerEntry.Next() = 0
        // end;


        // end;
        // if (Duplicatenumber2 = Iterator) then begin
        //     Duplicatenumber2 := DuplicateNumber1;
        //     Iterator := (Iterator + 1);
        //     Commit();
        // end;
        Rec."Dist. Entry No Applied" := Rec."Entry No.";
    end;

    trigger OnBeforeInsert()
    begin
        DistributionNoApplied();
    end;

    var
        Iterator: Integer;
        DuplicateNumber1: Integer;
        Duplicatenumber2: Integer;
        AccountType: Enum "G/L Account Category";
        DistributionRuleFilter: Record "Distribution Rule Filter";
        SalesInvoice: page "Sales Invoice";
        SalHe: Record "Sales Header";
}
