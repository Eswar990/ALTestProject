pageextension 50103 "Dim Values PageExe" extends "Dimension Values"
{
    layout
    {
        addafter("Dimension Value Type")
        {
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                Editable = false;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                Editable = false;
            }
            field("Percentage One"; Rec."Percentage One")
            {
                Editable = false;
            }
            field("Shortcut Dimension 3 Two"; Rec."Shortcut Dimension 3 Two")
            {
                Editable = false;
            }
            field("Percentage Two"; Rec."Percentage Two")
            {
                Editable = false;
            }
            field("Shortcut Dimension 3 Three"; Rec."Shortcut Dimension 3 Three")
            {
                Editable = false;
            }
            field("Percentage Three"; Rec."Percentage Three")
            {
                Editable = false;
            }
        }
        addafter(Blocked)
        {
            field(Year; Rec.Year)
            {
                Editable = false;
            }
            field(Month; Rec.Month)
            {
                Editable = false;
            }
            field("Distribute Enable"; Rec."Distribute Enable")
            {
                Editable = false;
            }
        }
    }
}
