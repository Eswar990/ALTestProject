page 50101 "Reference Data List"
{
    ApplicationArea = All;
    Caption = 'Reference Data List';
    PageType = List;
    SourceTable = "Reference Data";
    RefreshOnActivate = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Sorting Value"; Rec."Sorting Value")
                {

                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Sorting Value");
        Rec.Ascending(true)
    end;
}
