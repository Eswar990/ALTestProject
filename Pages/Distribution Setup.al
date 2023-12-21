page 50100 "Distribution Setup"
{
    PageType = Card;
    ApplicationArea = All;
    // RefreshOnActivate = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    Caption = 'Distribution Setup';
    SourceTable = "Distribution Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';

                }
                group(From)
                {
                    Caption = 'From';
                    field("Previous Year"; Rec."Previous Year")
                    {
                        TableRelation = "Reference Data".Code where("Sorting Value" = filter(= ''));
                        Caption = 'Previous Year';
                        Visible = true;

                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if (Rec."Previous Year" = Rec.year) then
                                Error(PrevYearAndYearMustNotBeSame);
                        end;
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
                            if ((Rec.Month = xRec.Month) or (Rec.Month = '')) then
                                Error(MonthAlreadyExisted, Rec.Month);
                            UpdateDistributionSetupLines();
                        end;
                    }
                }
            }
            part(DistributionLine; "Distribution Subform")
            {
                Caption = 'Lines';
                Editable = Rec."User ID" <> '';
                Enabled = true;
                SubPageLink = "User ID" = field("User ID");
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
                var
                    DistributionLineCopy: Record "Distribution Line Copy";
                begin
                    if ((Rec."Previous Year" = '') and (Rec.year = '') = true) then begin
                        Error(PreviousYearShouldNotBeEmpty);
                    end else
                        if ((Rec."Previous Month" = '') and (Rec.Month = '') = true) then
                            Error(PreviousMonthShouldNotBeEmpty);
                    DeletedDistribution.CopyFromPreviousDetails(Rec.year, Rec.Month, Rec."User ID")
                end;
            }

            action("Update Emp. Deltails")
            {
                Caption = 'Post';
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

    local procedure PostMyDocument()
    var
        DistributionLine: Record "Distribution Line";
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        // if (ConfirmManagement.GetResponse('Please Select Post', false)) then begin
        DistributionLine.SetRange("User ID", rec."User ID");
        if (DistributionLine.FindSet() = true) then
            repeat
                CopyDistributionLines(DistributionLine)
            until DistributionLine.Next() = 0;
        // end;
    end;

    local procedure CopyDistributionLines(var DistributionLine: Record "Distribution Line")
    var
        DistributionLineCopy: Record "Distribution Line Copy";
    begin
        DistributionLineCopy.SetRange(Year, DistributionLine.Year);
        DistributionLineCopy.SetRange(Month, DistributionLine.Month);
        DistributionLineCopy.SetRange("User ID", DistributionLine."User ID");
        DistributionLineCopy.SetRange("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
        if (DistributionLineCopy.IsEmpty = false) then
            exit;

        DistributionLineCopy.Init();
        DistributionLineCopy.Validate(Year, Rec.year);
        DistributionLineCopy.Validate(Month, Rec.Month);
        DistributionLineCopy.Validate("User ID", Rec."User ID");
        DistributionLineCopy.Validate("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
        DistributionLineCopy.Validate("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
        DistributionLineCopy.Validate("Shortcut Dimension 3 Code", DistributionLine."Shortcut Dimension 3 Code");
        DistributionLineCopy.Validate("Shortcut Dimension 3 Two", DistributionLine."Shortcut Dimension 3 Two");
        DistributionLineCopy.Validate("Shortcut Dimension 3 Three", DistributionLine."Shortcut Dimension 3 Three");
        DistributionLineCopy.Validate("Percentage One", DistributionLine."Percentage One");
        DistributionLineCopy.Validate("Percentage Two", DistributionLine."Percentage Two");
        DistributionLineCopy.Validate("Percentage Three", DistributionLine."Percentage Three");
        DistributionLineCopy.Validate("Line No.", DistributionLine."Line No.");
        DistributionLineCopy.Insert();


    end;

    trigger OnClosePage()
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        // MyProcedure();
        // DeleteDistributionData.DeleteDistributionHeaderData();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        PostMyDocument();
    end;

    trigger OnOpenPage()
    begin
        // Rec.InsertIfNotExists();
    end;

    var
        DeletedDistribution: Codeunit DeleteDistributionData;
        MonthAlreadyExisted: Label '%1 Month Already Existed in the Distribution Setup ';
        PreviousMonthShouldNotBeEmpty: Label 'Previous Month Should Not be Empty in the Distribution Setup ';
        PreviousYearShouldNotBeEmpty: Label 'Previous Year Should Not be Empty in the Distribution Setup ';
        PrevYearAndYearMustNotBeSame: Label 'Previous Year and Year Must Not be Same';
        PrevMonthAndMonthMustNotBeSame: Label 'Previous Month and Month Must Not be Same';
        SalesInvoice: Record "Sales Header";
        SalesOrder: Page "Sales Order";
        SalesLine: Record "Sales Line";
        Salessubform: Page "Sales Order Subform";
}