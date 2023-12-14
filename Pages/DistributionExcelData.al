page 50107 "Distribution Excel Data"
{
    ApplicationArea = All;
    Caption = 'Distribution Excel Data';
    PageType = Worksheet;
    SourceTable = "Distribution Excel Buffer Data";
    UsageCategory = Tasks;
    AutoSplitKey = true;
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    SaveValues = true;
    SourceTableView = sorting("Line No.", "Invoice Month");
    layout
    {
        area(content)
        {
            field(InvcMonthName; InvcMonthName)
            {
                Caption = 'Invoice Month';
            }
            repeater(General)
            {
                field("Invoice Month"; Rec."Invoice Month")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("IV_ Group"; Rec."IV_ Group")
                {

                }
                field(Projects; Rec.Projects)
                {

                }
                field("Employee Name"; Rec."Employee Name")
                {

                }
                field("Employee ID"; Rec."Employee ID")
                {

                }
                field("Project Code"; Rec."Project Code")
                {

                }
                field(Percentage; Rec.Percentage)
                {

                }
                field(Income; Rec.Income)
                {

                }
                field(Branch; Rec.Branch)
                {

                }
                field(FileName; FileName)
                {
                }
                field("Sheet Name"; Rec."Sheet Name")
                {
                }
                field("Imported Date"; Rec."Imported Date")
                {
                }
                field("Time Imported"; Rec."Time Imported")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Import")
            {
                Caption = 'Import';
                Image = ImportExcel;
                ToolTip = 'Import Data From Excel';

                trigger OnAction()
                begin
                    if ((InvcMonthName = '') = true) then
                        Error(BatachIsBlank);

                    ReadExcelSheet();
                    ImportExcelData();
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

    local procedure ImportExcelData()
    var
        DistributionExcelBufferData: Record "Distribution Excel Buffer Data";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRow: Integer;
        PercentageValue: Decimal;
        RoundingValue: Decimal;
        SecondRoundingValue: Decimal;
    begin
        DistributionExcelBufferData.Reset();
        if (DistributionExcelBufferData.FindLast() = true) then
            LineNo := DistributionExcelBufferData."Line No.";

        TempExcelBuffer.Reset();
        if (TempExcelBuffer.FindLast() = true) then
            MaxRow := TempExcelBuffer."Row No.";

        for RowNo := 3 to MaxRow do begin
            LineNo := LineNo + 1000;

            DistributionExcelBufferData.Init();
            Evaluate(DistributionExcelBufferData."Invoice Month", InvcMonthName);
            DistributionExcelBufferData."Line No." := LineNo;
            Evaluate(DistributionExcelBufferData."IV_ Group", GetValueAtCell(RowNo, 1));
            Evaluate(DistributionExcelBufferData.Projects, GetValueAtCell(RowNo, 2));
            Evaluate(DistributionExcelBufferData."Employee Name", GetValueAtCell(RowNo, 3));
            Evaluate(DistributionExcelBufferData."Employee ID", GetValueAtCell(RowNo, 4));
            Evaluate(DistributionExcelBufferData."Project Code", GetValueAtCell(RowNo, 5));
            PercentageValue := GetDecimal(RowNo, 6);
            if (PercentageValue = 1) then begin
                RoundingValue := Round(PercentageValue, 100, '>');
                DistributionExcelBufferData.Percentage := RoundingValue;
            end else begin
                RoundingValue := Round(PercentageValue, 0.01, '<');
                SecondRoundingValue := (RoundingValue * 100);
                DistributionExcelBufferData.Percentage := SecondRoundingValue;
            end;

            DistributionExcelBufferData.Income := GetDecimal(RowNo, 7);
            Evaluate(DistributionExcelBufferData.Branch, GetValueAtCell(RowNo, 8));
            DistributionExcelBufferData."Sheet Name" := SheetName;
            DistributionExcelBufferData."File Name" := FileName;
            DistributionExcelBufferData."Imported Date" := Today;
            DistributionExcelBufferData."Time Imported" := Time;
            InvcMonthName := SheetName;
            DistributionExcelBufferData.Insert();
        end;
        Message(ExcelImportSucces);
    end;

    var
        InvcMonthName: Text[10];
        FileName: Text[100];
        SheetName: text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadMsg: Label 'Please Choose The Excel File';
        NoFileMsg: Label 'No Excel file Found';
        BatachIsBlank: Label 'Invoice Month Name is Blank';
        ExcelImportSucces: Label 'Excel Imported Succesfully';
}
