page 50100 "Distribution Setup"
{
    PageType = Card;
    ApplicationArea = All;
    RefreshOnActivate = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    Editable = true;
    UsageCategory = Tasks;
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
                    Editable = true;
                    ToolTip = 'This is a custom field in the header.';
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
                            UpdateDistributionSetupLines(Rec."User ID")
                        end;
                    }
                    field("Month"; Rec.Month)
                    {
                        Caption = 'Month';
                        TableRelation = "Reference Data".Code where("Sorting Value" = filter(<> ''));
                        trigger OnValidate()
                        var
                        begin
                            UpdateDistributionSetupLines(Rec."User ID");
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
                begin
                    if ((Rec."Previous Year" = '') or (Rec.year = '') = true) then begin
                        Error(PreviousYearShouldNotBeEmpty);
                    end else
                        if ((Rec."Previous Month" = '') or (Rec.Month = '') = true) then
                            Error(PreviousMonthShouldNotBeEmpty);

                    DeletedDistribution.CopyFromPreviousDetails(Rec.year, Rec.Month, Rec."User ID")
                end;
            }

            action("Update Emp. Deltails")
            {
                Caption = 'Update Emp. Deltails';
                Image = UpdateDescription;

                trigger OnAction()
                begin
                    if ((Rec.year = '') = true) then
                        Error(YearShoulNotBeEmpty)
                    else
                        if ((Rec.Month = '') = true) then
                            Error(MonthShoulNotBeEmpty);

                    DeletedDistribution.CopyFromPreviousDetails(Rec.year, Rec.Month, Rec."User ID")
                end;
            }

        }
    }

    local procedure UpdateDistributionSetupLines(UserID: Code[20])
    var
        DistributionLine: Record "Distribution Line";
        DistributionLineCopy: Record "Distribution Line Copy";
    begin
        if (((Rec.year <> '') and (Rec.Month <> '')) = true) then begin
            DistributionLineCopy.Reset();
            DistributionLineCopy.SetRange(Year, Rec.Year);
            DistributionLineCopy.SetRange(Month, Rec.Month);
            if (DistributionLineCopy.FindSet(false) = true) then
                DistributionLine.SetRange("User ID", UserID);
            if (DistributionLine.FindSet(false) = true) then
                DistributionLine.DeleteAll();
            repeat
                DistributionLine.Init();
                Distributionline."User ID" := Rec."User ID";
                Distributionline.year := DistributionLineCopy.Year;
                Distributionline.Month := DistributionLineCopy.Month;
                Distributionline."Line No." := DistributionLineCopy."Line No.";
                Distributionline."Shortcut Dimension 1 Code" := DistributionLineCopy."Shortcut Dimension 1 Code";
                Distributionline."Shortcut Dimension 2 Code" := DistributionLineCopy."Shortcut Dimension 2 Code";
                Distributionline."Shortcut Dimension 3 Code" := DistributionLineCopy."Shortcut Dimension 3 Code";
                Distributionline."Shortcut Dimension 3 Two" := DistributionLineCopy."Shortcut Dimension 3 Two";
                Distributionline."Shortcut Dimension 3 Three" := DistributionLineCopy."Shortcut Dimension 3 Three";
                Distributionline."Percentage One" := DistributionLineCopy."Percentage One";
                Distributionline."Percentage Two" := DistributionLineCopy."Percentage Two";
                Distributionline."Percentage Three" := DistributionLineCopy."Percentage Three";
                DistributionLine.Insert();
            until DistributionLineCopy.Next() = 0;
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
        DistributionLine.SetRange("User ID", Rec."User ID");
        if (DistributionLine.FindSet() = true) then begin
            DistributionLineCopy.SetRange(Year, DistributionLine.Year);
            DistributionLineCopy.SetRange(Month, DistributionLine.Month);
            if (DistributionLineCopy.FindFirst() = true) then
                DistributionLineCopy.DeleteAll();
            repeat
                CopyDistributionLines(DistributionLine)
            until DistributionLine.Next() = 0;
        end;
    end;

    local procedure CopyDistributionLines(var DistributionLine: Record "Distribution Line")
    begin
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        PostMyDocument();
        DeleteDistributionData.DeleteDistributionHeaderData();
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CurrPage.Editable := (Rec."User ID" = '') or (Rec."User ID" <> '');
    end;

    // trigger OnOpenPage()
    // begin
    //     CurrPage.Editable(true);
    // end;

    var
        DistributionLineCopy: Record "Distribution Line Copy";
        DeletedDistribution: Codeunit DeleteDistributionData;
        MonthAlreadyExisted: Label '%1 Month Already Existed in the Distribution Setup ';
        PreviousMonthShouldNotBeEmpty: Label 'Previous Month Should Not be Empty in the Distribution Setup ';
        PreviousYearShouldNotBeEmpty: Label 'Previous Year Should Not be Empty in the Distribution Setup ';
        PrevYearAndYearMustNotBeSame: Label 'Previous Year and Year Must Not be Same';
        PrevMonthAndMonthMustNotBeSame: Label 'Previous Month and Month Must Not be Same';
        YearShoulNotBeEmpty: Label 'Year Should Not be Emprty';
        MonthShoulNotBeEmpty: Label 'Month Should Not be Emprty';
}