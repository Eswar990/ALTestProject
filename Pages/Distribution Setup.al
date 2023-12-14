page 50100 "Distribution Setup"
{
    PageType = Card;
    ApplicationArea = All;
    RefreshOnActivate = true;
    UsageCategory = Tasks;
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
                        TableRelation = "Reference Data".Code where("Sorting Value" = filter(= ''));
                        Caption = 'Previous Year';
                        Visible = true;

                    }
                    field("Previous Month"; Rec."Previous Month")
                    {
                        TableRelation = "Reference Data".Code where("Sorting Value" = filter(<> ''));
                        Caption = 'Previous Month';
                        Visible = true;
                    }
                }
                group(To)
                {
                    Caption = 'To';
                    field("year"; Rec.year)
                    {
                        Caption = 'Year';
                        TableRelation = "Reference Data".Code where("Sorting Value" = filter(= ''));
                        trigger OnValidate()
                        begin
                            UpdateDistributionSetupLines()
                        end;
                    }
                    field("Month"; Rec.Month)
                    {
                        Caption = 'Month';
                        TableRelation = "Reference Data".Code where("Sorting Value" = filter(<> ''));
                        trigger OnValidate()
                        begin
                            UpdateDistributionSetupLines();
                        end;
                    }
                }
            }
            part(DistributionLine; "Distribution Subform")
            {
                Caption = 'Lines';
                Editable = true;
                Enabled = true;
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Cpoy From pre. Deltails")
            {
                Caption = 'Cpoy From pre. Deltails';
                Image = Copy;

                trigger OnAction()
                begin

                end;
            }

            action("Update Emp. Deltails")
            {
                Caption = 'Update Emp. Deltails';
                Image = UpdateDescription;

                trigger OnAction()
                begin

                end;
            }

        }
    }

    local procedure UpdateDistributionSetupLines()
    var
        DistributionLine: Record "Distribution Line";
        DimensionValue: Record "Dimension Value";
    begin
        if (((Rec.year <> '') and (Rec.Month <> '')) = true) then begin
            DimensionValue.Reset();
            DimensionValue.SetRange(Year, Rec.Year);
            DimensionValue.SetRange(Month, Rec.Month);

            if (DimensionValue.FindSet(false)) then
                repeat
                    DistributionLine.Init();
                    DistributionLine.Year := DimensionValue.Year;
                    DistributionLine.Month := DimensionValue.Month;
                    DistributionLine."Shortcut Dimension 1 Code" := DimensionValue.Code;
                    DistributionLine."Shortcut Dimension 2 Code" := DimensionValue."Shortcut Dimension 2 Code";
                    DistributionLine."Shortcut Dimension 3 Code" := DimensionValue."Shortcut Dimension 3 Code";
                    DistributionLine."Shortcut Dimension 3 Two" := DimensionValue."Shortcut Dimension 3 Two";
                    DistributionLine."Shortcut Dimension 3 Three" := DimensionValue."Shortcut Dimension 3 Three";
                    DistributionLine."Percentage One" := DimensionValue."Percentage One";
                    DistributionLine."Percentage Two" := DimensionValue."Percentage Two";
                    DistributionLine."Percentage Three" := DimensionValue."Percentage Three";
                    DistributionLine.Insert(false);
                until DimensionValue.Next() = 0;
        end;
        if ((Rec.year = '') or (Rec.Month = '')) then begin
            DistributionLine.DeleteAll();
        end;
    end;



    trigger OnClosePage()
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        // MyProcedure();
        DeleteDistributionData.DeleteDistributionHeaderData();
    end;

    // trigger OnQueryClosePage()
    // begin

    // end;
    trigger OnOpenPage()
    begin
        CurrPage.Editable(true);
    end;

    var
        SalesInvoice: Record "Sales Header";
        SalesOrder: Page "Sales Order";
}