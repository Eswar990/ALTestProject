page 50108 "Distribution Line Copy"
{
    ApplicationArea = All;
    Caption = 'Distribution Line Copy';
    PageType = List;
    SourceTable = "Distribution Line Copy";
    UsageCategory = Tasks;
    Editable = false;
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
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Sorting Value");
        Rec.SetAscending("Sorting Value", true);
    end;
}
