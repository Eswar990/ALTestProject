pageextension 50103 "Dim Values PageExe" extends "Dimension Values"
{
    layout
    {
        addafter("Dimension Value Type")
        {
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
            field("Percentage Thee"; Rec."Percentage Thee")
            {
            }
        }
        addafter(Blocked)
        {
            field(Year; Rec.Year)
            {
            }
            field(Month; Rec.Month)
            {
            }
            field("Distribute Enable"; Rec."Distribute Enable")
            {
            }
        }
    }
}
