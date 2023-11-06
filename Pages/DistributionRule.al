page 50106 "Distribution Rule"
{
    ApplicationArea = All;
    Caption = 'Distribution Rule';
    PageType = ListPart;
    SourceTable = "Distribution Rule";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Shortcut Dimension1 Code"; Rec."Shortcut Dimension1 Code")
                {

                }
                field("Shortcut Dimension2 Code"; Rec."Shortcut Dimension2 Code")
                {

                }
                field("Shortcut Dimension3 Code"; Rec."Shortcut Dimension3 Code")
                {

                }
                field("Ammount Allocated"; Rec."Ammount Allocated")
                {

                }
                field("Entry No."; Rec."Entry No.")
                {

                }
                field("Line No."; Rec."Line No.")
                {

                }
                field("G/L Account No."; Rec."G/L Account No.")
                {

                }
            }
            group(Group)
            {
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amout';
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                }
            }
        }
    }
}
