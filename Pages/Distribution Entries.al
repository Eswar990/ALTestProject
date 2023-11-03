page 50103 "Distribution Entries"
{
    ApplicationArea = All;
    Caption = 'Distribution Entries';
    PageType = List;
    SourceTable = "G/L Entry";
    Editable = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Distributio Rule Applied"; Rec."Distributio Rule Applied")
                {
                }
                field("Distribution Required"; Rec."Distribution Required")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                }
                field("Dist. Entry No Applied"; Rec."Dist. Entry No Applied")
                {
                }
                field("Account Category"; Rec."Account Category")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Distribution Rule")
            {
                Image = Allocate;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}
