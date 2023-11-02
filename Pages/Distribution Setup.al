page 50100 "Distribution Setup"
{
    PageType = Card;
    ApplicationArea = All;
    RefreshOnActivate = true;
    UsageCategory = Documents;
    Caption = 'Distribution Setup';
    SourceTable = "Distribution Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                group(From)
                {
                    Caption = 'From';
                    field("Previous Year"; Rec."Previous Year")
                    {
                        Caption = 'Previous Year';
                    }
                    field("Previous Month"; Rec."Previous Month")
                    {
                        Caption = 'Previous Month';
                    }
                }
                group(To)
                {
                    Caption = 'To';
                    field("year"; Rec.year)
                    {
                        Caption = 'Year';
                    }
                    field("Month"; Rec.Month)
                    {
                        Caption = 'Month';
                    }
                }
            }
            part(DistributionLine; "Distribution Subform")
            {
                Caption = 'Lines';
                Editable = true;
                Enabled = true;
                UpdatePropagation = Both;
                SubPageLink = Year = field("User ID");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        Sales: Page "Sales Order";
}