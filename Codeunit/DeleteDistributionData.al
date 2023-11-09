codeunit 50100 DeleteDistributionData
{
    Procedure DeleteData()
    var
        DistributionLine: Record "Distribution Line";
    begin
        DistributionLine.Reset();
        if (DistributionLine.FindSet(false) = true) then begin
            DistributionLine.DeleteAll(false);
        end;
    end;
}
