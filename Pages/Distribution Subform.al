page 50102 "Distribution Subform"
{
    ApplicationArea = All;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Distribution Line";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    AutoSplitKey = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    SaveValues = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Year; Rec.Year)
                {
                    trigger OnValidate()
                    var
                        DistributionHeader: Record "Distribution Header";
                        LineNo: Integer;
                    begin
                        DistributionHeader.SetRange("User ID", Rec."User ID");
                        DistributionHeader.FindFirst();
                        if (Rec.Year <> DistributionHeader.year) then
                            Error(HeaderAndLineYearMustBeSame);
                    end;
                }
                field(Month; Rec.Month)
                {
                    trigger OnValidate()
                    var
                        DistributionHeader: Record "Distribution Header";
                    begin
                        DistributionHeader.SetRange("User ID", Rec."User ID");
                        DistributionHeader.FindFirst();
                        if (Rec.Month <> DistributionHeader.Month) then
                            Error(HeaderAndLineMonthMustBeSame);
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    // trigger OnValidate()
                    // begin
                    //     SetFilterProcedure(Rec."Shortcut Dimension 1 Code")
                    // end;
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
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
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
        Distributionline.Reset();
        DistributionHeader.SetRange("User ID", Rec."User ID");
        if (DistributionHeader.FindLast() = true) then
            Distributionline.SetRange("User ID", DistributionHeader."User ID");
        if (Distributionline.FindLast() = true) then begin
            if ((Distributionline."Line No." <> 0) and ((Distributionline.Month = '') or (Distributionline.Year = '')) = true) then
                Distributionline.DeleteAll();
            LineNo := Distributionline."Line No.";
        end;

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
            DistributionHeader.SetRange(year, Distributionline.Year);
            DistributionHeader.SetRange(Month, Distributionline.Month);
            DistributionHeader.FindLast();
            Distributionline.Validate("User ID", DistributionHeader."User ID");
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


    procedure SetFilterProcedure(EmployeeCode: Code[20])
    var
        Count: Integer;
        EmployeeCodeIsExisted: Label ' %1 Employee Code Is Existed';
    begin
        Rec.SetRange("Shortcut Dimension 1 Code", EmployeeCode);
        if (Rec.FindSet(false) = true) then
            repeat
                Count += 1;
                if (Count > 0) then
                    Error(EmployeeCodeIsExisted, EmployeeCode);
            until Rec.Next() = 0
    end;

    trigger OnClosePage()
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        // DeleteDistributionData.DeleteDistributionLineData();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DeleteDistributionData: Codeunit DeleteDistributionData;
    begin
        // if ((Rec.Year = '') or (Rec.Month = '') or (Rec."Shortcut Dimension 1 Code" = '')) then
        //     exit;
        // DeleteDistributionData.CopyFromDistributionLinetwo(Rec.Year, Rec.Month, Rec."Shortcut Dimension 1 Code", Rec."User ID");
    end;

    var
        FileName: Text[100];
        SheetName: text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadMsg: Label 'Please Choose The Excel File';
        NoFileMsg: Label 'No Excel file Found';
        ExcelImportSucces: Label 'Excel Imported Succesfully';
        MonthMustBeSame: Label 'Month Must be Same';
        YearMustBeSame: Label 'Year Must be Same';
        HeaderAndLineYearMustBeSame: Label 'Header and Line Year Must be Same';
        HeaderAndLineMonthMustBeSame: Label 'Header and Line Month Must be Same';
}

