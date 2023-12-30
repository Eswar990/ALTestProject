page 50103 "Distribution Entries"
{
    ApplicationArea = All;
    Caption = 'Distribution Entries';
    PageType = List;
    SourceTable = "G/L Entry";
    Editable = false;
    UsageCategory = Tasks;

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
                var
                    GLEntry: Record "G/L Entry";
                    DistributionRuleFilter: Record "Distribution Rule Filter";
                    AccountCategoryinsertedGLentry: Codeunit AccountCategoryinsertedGLentry;
                begin
                    CurrPage.SetSelectionFilter(GLEntry);
                    DistributionRuleFilter.SetRange("Entry No.", Rec."Entry No.");

                    if (DistributionRuleFilter.FindFirst() = false) then begin
                        DistributionRuleFilter.Init();
                        DistributionRuleFilter."Entry No." := Rec."Entry No.";
                        DistributionRuleFilter."Distribution Method" := DistributionRuleFilter."Distribution Method"::maually;
                        if (Rec."Credit Amount" = 0) then begin
                            DistributionRuleFilter."Distribution Amount" := Rec."Debit Amount";
                        end else begin
                            DistributionRuleFilter."Distribution Amount" := Rec."Credit Amount";
                        end;
                        DistributionRuleFilter.Insert(true);
                    end;
                    Page.Run(Page::"Distribution Rule Filter", DistributionRuleFilter);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        AccountCategory: Enum "G/L Account Category";
    begin
        Rec.SetCurrentKey("Entry No.");
        Rec.Ascending(false);
        Rec.SetRange(Rec."Account Category", AccountCategory::Income);
        Rec.FindSet(false);
    end;

    var
        AccountCategoryinsertedGLentry: Codeunit AccountCategoryinsertedGLentry;
        Distribution: Record "Distribution Rule Filter";
        GLEntry: Record "G/L Entry";
        DocumentEntry: Record "Document Entry";
        Navigate: Page Navigate;
        Distributions: Page "Distribution Rule Filter";
        generalledgerenr: Page "General Ledger Entries";
        SalesPage: Page "Sales Order";
        SalesQuote: Page "Sales Quote";
        Codeunit: Codeunit 80;
        Codeunit2: Codeunit 90;
        Codeunit3: Codeunit 12;
        table: Record 81;
        TooManyGLEntriesSelectedErr: Label 'You have selected too many G/L entries. Split the change to select fewer entries, or go to the Dimension Correction page and use filters to select the entries.';

}
