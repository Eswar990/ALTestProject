page 50101 "Reference Data List"
{
    ApplicationArea = All;
    Caption = 'Reference Data List';
    PageType = List;
    SourceTable = "Reference Data";
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
}
