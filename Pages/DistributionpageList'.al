page 50109 "Distribution page List"
{
    Caption = 'Distribution page List';
    CardPageID = "Distribution Setup";
    ApplicationArea = All;
    PageType = List;
    UsageCategory = Lists;
    DataCaptionFields = year;
    SourceTable = "Distribution Header";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("User ID"; Rec."User ID")
                {

                }
                field(year; Rec.year)
                {

                }
                field(Month; Rec.Month)
                {

                }
            }
        }
    }
}
