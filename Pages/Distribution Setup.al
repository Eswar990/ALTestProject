page 50100 "Distribution Setup"
{
    PageType = Card;
    ApplicationArea = All;
    RefreshOnActivate = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    Editable = true;
    UsageCategory = Administration;
    Caption = 'Distribution Setup';
    SourceTable = "Distribution Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
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
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    Editable = true;
                    Visible = false;
                    ToolTip = 'This is a custom field in the header.';
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


    local procedure UpdateDistributionSetupLines(UserID: Code[20]): Boolean
    var
        DistributionLine: Record "Distribution Line";
        DistributionLineCopy: Record "Distribution Line Copy";
        IsBoolean: Boolean;
    begin
        if (((Rec.year <> '') and (Rec.Month <> '')) = true) then begin
            DistributionLineCopy.Reset();
            DistributionLineCopy.SetRange(Year, Rec.Year);
            DistributionLineCopy.SetRange(Month, Rec.Month);
            if (DistributionLineCopy.FindSet(false) = true) then begin
                DistributionLine.SetRange("User ID", UserID);
                IsBoolean := true;
                Error(MonthAlreadyExisted, Rec.Month);
            end else
                if (DistributionDataSetupCdut.UpdatePreviousEmployeeDeatils(Rec.Month, UserID) = true) then
                    exit;
            if (DistributionDataSetupCdut.CheckDistributionLinesInsertOrNot(DistributionLine, IsBoolean) = true) then
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
                    DistributionLine."Sorting Value" := DistributionLineCopy."Sorting Value";
                    DistributionLine.Insert();
                until DistributionLineCopy.Next() = 0;
        end;

        if ((Rec.year = '') or (Rec.Month = '')) then begin
            DistributionLine.DeleteAll();

        end;
    end;

    local procedure CloseDistributionSetup()
    var
        DistributionLine: Record "Distribution Line";
    begin
        DistributionLine.SetRange("User ID", Rec."User ID");
        if (DistributionLine.FindSet(false) = true) then begin
            DistributionLineCopy.SetRange(Year, DistributionLine.Year);
            DistributionLineCopy.SetRange(Month, DistributionLine.Month);
            if (DistributionLineCopy.FindFirst() = true) then
                DistributionLineCopy.DeleteAll();
            repeat
                CopyDistributionLines(DistributionLine)
            until DistributionLine.Next() = 0;
        end;
    end;

    local procedure CheckAndDeleteEmptyLines(): Boolean
    var
        DistributionLine: Record "Distribution Line";
        Count: Integer;
    begin
        DistributionLine.SetRange("User ID", Rec."User ID");
        if (DistributionLine.FindSet(false) = true) then
            repeat
                Count += 1;
            until DistributionLine.Next() = 0;
        if (Count > 1) then
            exit
        else
            if ((DistributionLine.Year = '') and (DistributionLine.Month = '') and
            (DistributionLine."Shortcut Dimension 1 Code" = '') and
            (DistributionLine."Shortcut Dimension 2 Code" = '') and
            (DistributionLine."Shortcut Dimension 3 Code" = '') and
            (DistributionLine."Shortcut Dimension 3 Three" = '') and
            (DistributionLine."Shortcut Dimension 3 Two" = '') and
            (DistributionLine."Percentage One" = 0) and (DistributionLine."Percentage Two" = 0) and
            (DistributionLine."Percentage Three" = 0)) then
                DistributionLine.DeleteAll();
        DistributionDataSetupCdut.DeleteDistributionHeaderData();
        exit(true);
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
        DistributionLineCopy.Validate("Sorting Value", DistributionLine."Sorting Value");
        DistributionLineCopy.Insert();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CheckAndDeleteEmptyLines() = true) then
            exit;
        CloseDistributionSetup();
        DistributionDataSetupCdut.DeleteDistributionHeaderData();
    end;

    var
        DistributionLineCopy: Record "Distribution Line Copy";
        DistributionDataSetupCdut: Codeunit DistributionDataSetupCdut;
        MonthAlreadyExisted: Label '%1 Month Already Existed in the Distribution Copy Setup ';
}