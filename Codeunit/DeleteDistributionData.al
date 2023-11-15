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
}
