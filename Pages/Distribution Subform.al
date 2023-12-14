page 50102 "Distribution Subform"
{
    ApplicationArea = All;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Distribution Line";
    // AutoSplitKey = true;
    // DelayedInsert = true;
    // InsertAllowed = true;
    // ModifyAllowed = true;
    // SaveValues = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Year; Rec.Year)
                {
                }
                field(Month; Rec.Month)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Percentage One"; Rec."Percentage One")
                {
                }
                field("Shortcut Dimension 3 Two"; Rec."Shortcut Dimension 3 Two")
                {
                }
                field("Percentage Two"; Rec."Percentage Two")
                {
                }
                field("Shortcut Dimension 3 Three"; Rec."Shortcut Dimension 3 Three")
                {
                }
                field("Percentage Thee"; Rec."Percentage Three")
                {
                }

            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Update From Excel")
            {
                Caption = 'Update From Excel';
                Image = Excel;
                ToolTip = 'Import Data From Excel';

                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportExcelData();
                    // MyProcedure();
                end;
            }

        }
    }

    local procedure ReadExcelSheet()
    var
        FileManagement: Codeunit "File Management";
        Istream: InStream;
        FromFile: text[100];
    begin
        UploadIntoStream(UploadMsg, '', '', FromFile, Istream);
        if ((FromFile <> '') = true) then begin
            FileName := FileManagement.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(Istream);
        end else
            Error(NoFileMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(Istream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportExcelData()
    var
        DistributionHeader: Record "Distribution Header";
        Distributionline: Record "Distribution Line";
        DistributionHeaderyear: Code[20];
        DistributionHeaderMonth: Code[20];
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRow: Integer;
    begin
        Distributionline.DeleteAll();
        Distributionline.Reset();
        if (Distributionline.FindLast() = true) then
            LineNo := Distributionline."Line No.";

        TempExcelBuffer.Reset();
        if (TempExcelBuffer.FindLast() = true) then
            MaxRow := TempExcelBuffer."Row No.";

        for RowNo := 2 to MaxRow do begin
            LineNo := LineNo + 1000;

            Distributionline.Init();
            Distributionline."Line No." := LineNo;
            Evaluate(Distributionline.Year, GetValueAtCell(RowNo, 1));
            Evaluate(Distributionline.Month, GetValueAtCell(RowNo, 2));
            Evaluate(Distributionline."Shortcut Dimension 1 Code", GetValueAtCell(RowNo, 3));
            Evaluate(Distributionline."Shortcut Dimension 2 Code", GetValueAtCell(RowNo, 4));
            Evaluate(Distributionline."Shortcut Dimension 3 Code", GetValueAtCell(RowNo, 5));
            Distributionline."Percentage One" := GetDecimal(RowNo, 6);
            Evaluate(Distributionline."Shortcut Dimension 3 Two", GetValueAtCell(RowNo, 7));
            Distributionline."Percentage Two" := GetDecimal(RowNo, 8);
            Evaluate(Distributionline."Shortcut Dimension 3 Three", GetValueAtCell(RowNo, 9));
            Distributionline."Percentage Three" := GetDecimal(RowNo, 10);
            DistributionHeader.Get();
            if (DistributionHeader.year <> Distributionline.Year) then
                Error(YearMustBeSame)
            else
                if (DistributionHeader.Month <> Distributionline.Month) then
                    Error(MonthMustBeSame);

            Distributionline.Insert();
        end;
        Message(ExcelImportSucces);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if (TempExcelBuffer.Get(RowNo, ColNo)) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    local procedure GetDecimal(Row: Integer; Coloumn: Integer): Decimal
    var
        DecimalValue: Decimal;
    begin
        TempExcelBuffer.Reset();
        if (TempExcelBuffer.Get(Row, Coloumn)) then begin
            Evaluate(DecimalValue, TempExcelBuffer."Cell Value as Text");
            exit(DecimalValue);
        end;
    end;

    local procedure MyProcedure()
    var
        FirstLineNo: Integer;
        LastLineNo: Integer;
        CopyLineno: Integer;
        Count: Integer;
        Distributionline: Record "Distribution Line";
        DistributionlineCopy: Record "Distribution Line Copy";
    begin
        Distributionline.Reset();
        if (Distributionline.FindFirst() = true) then
            FirstLineNo := Distributionline."Line No.";

        if (Distributionline.FindLast() = true) then
            LastLineNo := Distributionline."Line No.";

        DistributionlineCopy.Reset();
        if (DistributionlineCopy.FindLast() = true) then
            CopyLineno := DistributionlineCopy."Line No."
        else begin
            DistributionlineCopy.DeleteAll();
            CopyLineno := 0;
        end;


        for Count := FirstLineNo to LastLineNo do begin
            CopyLineno := CopyLineno + 1000;

            DistributionlineCopy.Init();
            DistributionlineCopy."Line No." := CopyLineno;
            // DistributionlineCopy.Year := Distributionline.Year;
            // DistributionlineCopy.Month := Distributionline.Month;

            DistributionlineCopy.Insert(false);
        end;

    end;

    trigger OnClosePage()
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        DeleteDistributionData.DeleteDistributionLineData();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        if ((Rec.Year = '') or (Rec.Month = '') or (Rec."Shortcut Dimension 1 Code" = '')) then
            exit;
        DeleteDistributionData.CopyFromDistributionLine(Rec.Year, Rec.Month, Rec."Shortcut Dimension 1 Code");
    end;

    var
        FileName: Text[100];
        SheetName: text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadMsg: Label 'Please Choose The Excel File';
        NoFileMsg: Label 'No Excel file Found';
        ExcelImportSucces: Label 'Excel Imported Succesfully';
        MonthMustBeSame: Label 'Month Must Be Same';
        YearMustBeSame: Label 'Year Must be Same';

}

