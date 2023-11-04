page 50105 "Distribution Project"
{
    ApplicationArea = All;
    Caption = 'Distribution Project';
    PageType = ListPart;
    SourceTable = "Distribution Project";

    layout
    {
        area(content)
        {
            repeater("Project Line")
            {
                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {

                }
                field("Emp.Count"; Rec."Emp.Count")
                {

                }
                field("Project Amount"; Rec."Project Amount")
                {
                    Caption = 'Amount To Be Allocated';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {

                }
            }
        }
    }
}
