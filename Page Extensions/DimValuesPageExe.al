pageextension 50103 "Dim Values PageExe" extends "Dimension Values"
{
    layout
    {
        addafter("Dimension Value Type")
        {
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                Editable = Editable2;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                Editable = Editable2;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            }
            field("Percentage One"; Rec."Percentage One")
            {
                Editable = Editable2;
            }
            field("Shortcut Dimension 3 Two"; Rec."Shortcut Dimension 3 Two")
            {
                Editable = Editable2;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            }
            field("Percentage Two"; Rec."Percentage Two")
            {
                Editable = Editable2;
            }
            field("Shortcut Dimension 3 Three"; Rec."Shortcut Dimension 3 Three")
            {
                Editable = Editable2;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            }
            field("Percentage Three"; Rec."Percentage Three")
            {
                Editable = Editable2;
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
    trigger OnAfterGetCurrRecord()
    begin
        Editable2 := false;
        if (Rec."Dimension Code" = 'EMPLOYEE') then
            Editable2 := true;
    end;

    var
        Editable2: Boolean;
}
