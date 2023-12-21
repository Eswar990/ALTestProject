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

    // procedure CopyFromDistributionLine(year: Code[20]; Month: Code[20]; EmployeeCode: Code[20])
    // var
    //     DistributionLine: Record "Distribution Line";
    //     DistributionCopy2: Record "Distribution Line Copy";
    //     DistributionCopy: Record "Distribution Line Copy";
    //     DistributionHeaderder: Record "Distribution Header";
    //     LineNo: Integer;
    //     Count: Integer;
    //     Count2: Integer;
    // begin
    //     DistributionLine.Get(year, Month, EmployeeCode);
    //     DistributionLine.FindSet(false);
    //     if (DistributionCopy.Get(year, month, EmployeeCode) = true) then
    //         if ((DistributionLine.Year = DistributionCopy.Year) and (DistributionLine.Month = DistributionCopy.Month)) then begin
    //             DistributionCopy.SetRange(Year, year);
    //             DistributionCopy.SetRange(Month, Month);
    //             DistributionCopy.FindSet(false);
    //         end;
    //     repeat
    //         DistributionCopy.Init();
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate(Year, DistributionLine.year);
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate(Month, DistributionLine.Month);
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then begin
    //             LineNo := LineNo + 1000;
    //             DistributionCopy.Validate("Line No.", LineNo);
    //         end;
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Shortcut Dimension 3 Code", DistributionLine."Shortcut Dimension 3 Code");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Shortcut Dimension 3 Two", DistributionLine."Shortcut Dimension 3 Two");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Shortcut Dimension 3 Three", DistributionLine."Shortcut Dimension 3 Three");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Percentage One", DistributionLine."Percentage One");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Percentage Two", DistributionLine."Percentage Two");
    //         if (MyProcedure(DistributionLine, DistributionCopy) = true) then
    //             DistributionCopy.Validate("Percentage Three", DistributionLine."Percentage Three");
    //         DistributionCopy.Insert(true);
    //         Count += 1;
    // end else begin
    //     if (DistributionLine.FindFirst()) then
    //         if ((DistributionCopy.Year <> DistributionLine.Year) or (DistributionCopy.Month <> DistributionLine.Month) or
    //         (DistributionCopy."Shortcut Dimension 1 Code" <> DistributionLine."Shortcut Dimension 1 Code") or
    //         (DistributionCopy."Shortcut Dimension 2 Code" <> DistributionLine."Shortcut Dimension 2 Code") or
    //         (DistributionCopy."Shortcut Dimension 3 Code" <> DistributionLine."Shortcut Dimension 3 Code") or
    //         (DistributionCopy."Shortcut Dimension 3 Two" <> DistributionLine."Shortcut Dimension 3 Two") or
    //         (DistributionCopy."Shortcut Dimension 3 three" <> DistributionLine."Shortcut Dimension 3 three") or
    //         (DistributionCopy."Percentage One" <> DistributionLine."Percentage One") or
    //         (DistributionCopy."Percentage Two" <> DistributionLine."Percentage Two") or
    //         (DistributionCopy."Percentage Three" <> DistributionLine."Percentage Three")) then begin

    //             DistributionCopy.Init();
    //             DistributionCopy.Validate(Year, DistributionLine.year);
    //             DistributionCopy.Validate(Month, DistributionLine.Month);
    //             DistributionCopy.Validate("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
    //             LineNo := LineNo + 1000;
    //             DistributionCopy.Validate("Line No.", LineNo);
    //             DistributionCopy.Validate("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
    //             DistributionCopy.Validate("Shortcut Dimension 3 Code", DistributionLine."Shortcut Dimension 3 Code");
    //             DistributionCopy.Validate("Shortcut Dimension 3 Two", DistributionLine."Shortcut Dimension 3 Two");
    //             DistributionCopy.Validate("Shortcut Dimension 3 Three", DistributionLine."Shortcut Dimension 3 Three");
    //             DistributionCopy.Validate("Percentage One", DistributionLine."Percentage One");
    //             DistributionCopy.Validate("Percentage Two", DistributionLine."Percentage Two");
    //             DistributionCopy.Validate("Percentage Three", DistributionLine."Percentage Three");
    //             DistributionCopy.Insert(true);
    //             Count2 += 1;
    //         end else
    //             if (count = Count2) then
    //                 exit
    //     // end;
    //     until DistributionLine.Next() = 0;
    // end;

    // procedure MyProcedure(var
    //                           DistributionLine: Record "Distribution Line";
    //                           DistributionCopy: Record "Distribution Line Copy"): Boolean
    // var
    //     myInt: Integer;
    // begin
    //     if ((DistributionCopy.Year <> DistributionLine.Year) or (DistributionCopy.Month <> DistributionLine.Month) or
    //     (DistributionCopy."Shortcut Dimension 1 Code" <> DistributionLine."Shortcut Dimension 1 Code") or
    //     (DistributionCopy."Shortcut Dimension 2 Code" <> DistributionLine."Shortcut Dimension 2 Code") or
    //     (DistributionCopy."Shortcut Dimension 3 Code" <> DistributionLine."Shortcut Dimension 3 Code") or
    //     (DistributionCopy."Shortcut Dimension 3 Two" <> DistributionLine."Shortcut Dimension 3 Two") or
    //     (DistributionCopy."Shortcut Dimension 3 three" <> DistributionLine."Shortcut Dimension 3 three") or
    //     (DistributionCopy."Percentage One" <> DistributionLine."Percentage One") or
    //     (DistributionCopy."Percentage Two" <> DistributionLine."Percentage Two") or
    //     (DistributionCopy."Percentage Three" <> DistributionLine."Percentage Three")) then begin
    //         exit(true);
    //     end else
    //         exit(false);
    // end;


    // procedure CopyFromDistributionLinetwo(year: Code[20]; Month: Code[20]; EmployeeCode: Code[20]; UserID: Code[20])
    // var
    //     DistributionLine: Record "Distribution Line";
    //     DistributionCopy2: Record "Distribution Line Copy";
    //     DistributionCopy: Record "Distribution Line Copy";
    //     LineNo: Integer;
    //     Count: Integer;
    //     Count2: Integer;
    // begin
    //     DistributionLine.Reset();
    //     DistributionLine.SetRange("User ID", UserID);
    //     DistributionLine.SetRange(Year, year);
    //     DistributionLine.SetRange(Month, Month);
    //     DistributionLine.SetRange("Shortcut Dimension 1 Code", EmployeeCode);
    //     if (DistributionLine.FindSet(false) = true) then
    //         repeat
    //             if (DistributionCopy.Get(year, month, EmployeeCode) <> true) then begin
    //                 DistributionCopy.Init();
    //                 DistributionCopy.Validate(Year, DistributionLine.year);
    //                 DistributionCopy.Validate(Month, DistributionLine.Month);
    //                 DistributionCopy.Validate("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
    //                 LineNo := LineNo + 1000;
    //                 DistributionCopy.Validate("Line No.", LineNo);
    //                 DistributionCopy.Validate("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
    //                 DistributionCopy.Validate("Shortcut Dimension 3 Code", DistributionLine."Shortcut Dimension 3 Code");
    //                 DistributionCopy.Validate("Shortcut Dimension 3 Two", DistributionLine."Shortcut Dimension 3 Two");
    //                 DistributionCopy.Validate("Shortcut Dimension 3 Three", DistributionLine."Shortcut Dimension 3 Three");
    //                 DistributionCopy.Validate("Percentage One", DistributionLine."Percentage One");
    //                 DistributionCopy.Validate("Percentage Two", DistributionLine."Percentage Two");
    //                 DistributionCopy.Validate("Percentage Three", DistributionLine."Percentage Three");
    //                 DistributionCopy.Insert(true);
    //             end
    //         until DistributionLine.Next() = 0;
    // end;

    procedure CopyFromPreviousDetails(year: Code[20]; Month: Code[20]; UserID: Code[20])
    var
        DistributionLineCopy: Record "Distribution Line Copy";
        Distributionline: Record "Distribution Line";
    begin
        DistributionLineCopy.Reset();
        DistributionLineCopy.SetRange(Year, year);
        DistributionLineCopy.SetRange(Month, Month);
        DistributionLineCopy.SetRange("User ID", UserID);
        if (DistributionLineCopy.FindSet(false) = true) then begin
            repeat
                Distributionline.SetRange("User ID", UserID);
                Distributionline.FindFirst();
                if (Distributionline."User ID" = UserID) then
                    Distributionline.DeleteAll();
                Distributionline.Init();
                Distributionline."User ID" := DistributionLineCopy."User ID";
                Distributionline.year := DistributionLineCopy.Year;
                Distributionline.Month := DistributionLineCopy.Month;
                Distributionline."Line No." := DistributionLineCopy."Line No.";
                Distributionline.Insert();
            until DistributionLineCopy.Next() = 0;
        end;
    end;
}
