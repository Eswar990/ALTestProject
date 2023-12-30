pageextension 50103 "Dim Values PageExe" extends "Dimension Values"
{
    layout
    {
        addafter("Dimension Value Type")
        {
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                Editable = EditableField;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                Editable = EditableField;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            }
            field("Percentage One"; Rec."Percentage One")
            {
                Editable = EditableField;
            }
            field("Shortcut Dimension 3 Two"; Rec."Shortcut Dimension 3 Two")
            {
                Editable = EditableField;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            }
            field("Percentage Two"; Rec."Percentage Two")
            {
                Editable = EditableField;
            }
            field("Shortcut Dimension 3 Three"; Rec."Shortcut Dimension 3 Three")
            {
                Editable = EditableField;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            }
            field("Percentage Three"; Rec."Percentage Three")
            {
                Editable = EditableField;
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
        EditableField := false;
        if (Rec."Dimension Code" = 'EMPLOYEE') then
            EditableField := true;
    end;

    var
        EditableField: Boolean;
        genledgsetup: Record "General Ledger Setup";
        genledgset: Page "General Ledger Setup";
}
