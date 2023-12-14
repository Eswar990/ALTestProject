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

    procedure CopyFromDistributionLine(year: Code[20]; Month: Code[20]; EmployeeCode: Code[20])
    var
        DistributionLine: Record "Distribution Line";
        DistributionCopy2: Record "Distribution Line Copy";
        DistributionCopy: Record "Distribution Line Copy";
        LineNo: Integer;
        Count: Integer;
        Count2: Integer;
    begin
        DistributionLine.Get(year, Month, EmployeeCode);
        DistributionLine.FindSet(false);

        repeat
            if (DistributionCopy.Get(year, month, EmployeeCode) <> true) then begin
                DistributionCopy.Init();
                DistributionCopy.Validate(Year, DistributionLine.year);
                DistributionCopy.Validate(Month, DistributionLine.Month);
                DistributionCopy.Validate("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
                LineNo := LineNo + 1000;
                DistributionCopy.Validate("Line No.", LineNo);
                DistributionCopy.Validate("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
                DistributionCopy.Validate("Shortcut Dimension 3 Code", DistributionLine."Shortcut Dimension 3 Code");
                DistributionCopy.Validate("Shortcut Dimension 3 Two", DistributionLine."Shortcut Dimension 3 Two");
                DistributionCopy.Validate("Shortcut Dimension 3 Three", DistributionLine."Shortcut Dimension 3 Three");
                DistributionCopy.Validate("Percentage One", DistributionLine."Percentage One");
                DistributionCopy.Validate("Percentage Two", DistributionLine."Percentage Two");
                DistributionCopy.Validate("Percentage Three", DistributionLine."Percentage Three");
                DistributionCopy.Insert(true);
                Count += 1;
            end else begin
                if (DistributionLine.FindFirst()) then
                    if ((DistributionCopy.Year <> DistributionLine.Year) or (DistributionCopy.Month <> DistributionLine.Month) or
                    (DistributionCopy."Shortcut Dimension 1 Code" <> DistributionLine."Shortcut Dimension 1 Code") or
                    (DistributionCopy."Shortcut Dimension 2 Code" <> DistributionLine."Shortcut Dimension 2 Code") or
                    (DistributionCopy."Shortcut Dimension 3 Code" <> DistributionLine."Shortcut Dimension 3 Code") or
                    (DistributionCopy."Shortcut Dimension 3 Two" <> DistributionLine."Shortcut Dimension 3 Two") or
                    (DistributionCopy."Shortcut Dimension 3 three" <> DistributionLine."Shortcut Dimension 3 three") or
                    (DistributionCopy."Percentage One" <> DistributionLine."Percentage One") or
                    (DistributionCopy."Percentage Two" <> DistributionLine."Percentage Two") or
                    (DistributionCopy."Percentage Three" <> DistributionLine."Percentage Three")) then begin

                        DistributionCopy.Init();
                        DistributionCopy.Validate(Year, DistributionLine.year);
                        DistributionCopy.Validate(Month, DistributionLine.Month);
                        DistributionCopy.Validate("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
                        LineNo := LineNo + 1000;
                        DistributionCopy.Validate("Line No.", LineNo);
                        DistributionCopy.Validate("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
                        DistributionCopy.Validate("Shortcut Dimension 3 Code", DistributionLine."Shortcut Dimension 3 Code");
                        DistributionCopy.Validate("Shortcut Dimension 3 Two", DistributionLine."Shortcut Dimension 3 Two");
                        DistributionCopy.Validate("Shortcut Dimension 3 Three", DistributionLine."Shortcut Dimension 3 Three");
                        DistributionCopy.Validate("Percentage One", DistributionLine."Percentage One");
                        DistributionCopy.Validate("Percentage Two", DistributionLine."Percentage Two");
                        DistributionCopy.Validate("Percentage Three", DistributionLine."Percentage Three");
                        DistributionCopy.Insert(true);
                        Count2 += 1;
                    end else
                        if (count = Count2) then
                            exit
            end;
        until DistributionLine.Next() = 0;
    end;
}
