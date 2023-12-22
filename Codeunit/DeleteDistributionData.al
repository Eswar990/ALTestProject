codeunit 50100 DeleteDistributionData
{
    Procedure DeleteDistributionLineData()
    var
        DistributionLine: Record "Distribution Line";
    begin
        DistributionLine.Reset();
        if (DistributionLine.FindSet(false) = true) then begin
            DistributionLine.DeleteAll(false);
        end;
    end;

    procedure DeleteDistributionHeaderData()
    var
        DistributionHeader: Record "Distribution Header";
    begin
        DistributionHeader.Reset();
        if (DistributionHeader.FindSet(false) = true) then begin
            DistributionHeader.DeleteAll(false);
        end;
    end;


    procedure CopyFromPreviousDetails(year: Code[20]; Month: Code[20]; UserID: Code[20])
    var
        DistributionLineCopy: Record "Distribution Line Copy";
        Distributionline: Record "Distribution Line";
        Distributionheader: Record "Distribution Header";
    begin
        DistributionLineCopy.Reset();
        DistributionLineCopy.SetRange(Year, year);
        DistributionLineCopy.SetRange(Month, Month);
        if (DistributionLineCopy.FindSet(false) = true) then begin
            Distributionline.SetRange("User ID", UserID);
            if (Distributionline.FindFirst() = true) then
                exit;
            repeat
                Distributionline.Init();
                Distributionline."User ID" := UserID;
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
                Distributionline.Insert();
            until DistributionLineCopy.Next() = 0;
        end;
    end;
}
