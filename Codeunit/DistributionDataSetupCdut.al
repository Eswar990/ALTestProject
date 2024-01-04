codeunit 50100 DistributionDataSetupCdut
{
    procedure DeleteDistributionHeaderData()
    var
        DistributionHeader: Record "Distribution Header";
    begin
        DistributionHeader.Reset();
        if (DistributionHeader.FindSet(false) = true) then begin
            DistributionHeader.DeleteAll(false);
        end;
    end;

    procedure CheckDistributionLinesInsertOrNot(var DistributionLine: Record "Distribution Line"; IsBoolean: Boolean): Boolean
    begin
        if (DistributionLine.FindSet(false) = true) then begin
            DistributionLine.DeleteAll();
            exit(true)
        end else
            if (IsBoolean = true) then
                exit(true);
    end;

    procedure UpdatePreviousEmployeeDeatils(Month: Code[20]; UserID: Code[20]): Boolean
    var
        ReferenceData: Record "Reference Data";
        DistributionLineCopy: Record "Distribution Line Copy";
        DistributionLine: Record "Distribution Line";
        ReferenceDataSortingValue: Code[10];
        ReferenceDataSortingValueTwo: Code[10];
        Type: Option Year,Month;
        SortingValue: Integer;
        SortingValueData: Integer;
        ReferenceDataSortingvalueTxte: Text[20];
        Count: Integer;
        IsBoolean: Boolean;
        SelectMonthLbl: Label 'You Should Select %1 Month';
    begin
        ReferenceData.SetRange(Type, Type::Month);
        ReferenceData.SetRange(Code, Month);
        ReferenceData.FindFirst();
        ReferenceDataSortingValue := ReferenceData."Sorting Value";
        Evaluate(SortingValue, ReferenceDataSortingValue);
        SortingValueData := SortingValue - 1;
        ReferenceDataSortingvalueTxte := Format(SortingValueData);

        case ReferenceDataSortingvalueTxte of
            '1':
                ReferenceDataSortingValueTwo := 'JAN';
            '2':
                ReferenceDataSortingValueTwo := 'FEB';
            '3':
                ReferenceDataSortingValueTwo := 'MAR';
            '4':
                ReferenceDataSortingValueTwo := 'APR';
            '5':
                ReferenceDataSortingValueTwo := 'MAY';
            '6':
                ReferenceDataSortingValueTwo := 'JUN';
            '7':
                ReferenceDataSortingValueTwo := 'JUL';
            '8':
                ReferenceDataSortingValueTwo := 'AUG';
            '9':
                ReferenceDataSortingValueTwo := 'SEP';
            '10':
                ReferenceDataSortingValueTwo := 'OCT';
            '11':
                ReferenceDataSortingValueTwo := 'NOV';
            '12':
                ReferenceDataSortingValueTwo := 'DEC';
        end;

        DistributionLineCopy.SetRange(Month, ReferenceDataSortingValueTwo);
        if (DistributionLineCopy.FindSet(false) = true) then begin
            DistributionLine.SetRange("User ID", UserID);
            IsBoolean := true;
        end;
        if (DistributionLine.FindSet(false) = true) then
            DistributionLine.DeleteAll();

        repeat
            if ((ReferenceDataSortingValueTwo = '') = true) then
                exit
            else
                if ((ReferenceDataSortingValueTwo <> '') = true and (IsBoolean = false)) then
                    Error(SelectMonthLbl, ReferenceDataSortingValueTwo);

            DistributionLine.Init();
            Distributionline."User ID" := UserID;
            Distributionline.year := DistributionLineCopy.Year;
            Distributionline.Month := ReferenceData.Code;
            Distributionline."Line No." := DistributionLineCopy."Line No.";
            Distributionline."Shortcut Dimension 1 Code" := DistributionLineCopy."Shortcut Dimension 1 Code";
            Distributionline."Shortcut Dimension 2 Code" := DistributionLineCopy."Shortcut Dimension 2 Code";
            Distributionline."Shortcut Dimension 3 Code" := DistributionLineCopy."Shortcut Dimension 3 Code";
            Distributionline."Shortcut Dimension 3 Two" := DistributionLineCopy."Shortcut Dimension 3 Two";
            Distributionline."Shortcut Dimension 3 Three" := DistributionLineCopy."Shortcut Dimension 3 Three";
            Distributionline."Percentage One" := DistributionLineCopy."Percentage One";
            Distributionline."Percentage Two" := DistributionLineCopy."Percentage Two";
            Distributionline."Percentage Three" := DistributionLineCopy."Percentage Three";
            DistributionLine."Sorting Value" := ReferenceData."Sorting Value";
            DistributionLine.Insert();
        until DistributionLineCopy.Next() = 0;
        exit(true);
    end;
}