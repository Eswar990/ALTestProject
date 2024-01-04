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
                    trigger OnValidate()
                    begin
                        case Rec.Code of
                            'JAN':
                                Rec."Sorting Value" := '1';
                            'FEB':
                                Rec."Sorting Value" := '2';
                            'MAR':
                                Rec."Sorting Value" := '3';
                            'APR':
                                Rec."Sorting Value" := '4';
                            'MAY':
                                Rec."Sorting Value" := '5';
                            'JUN':
                                Rec."Sorting Value" := '6';
                            'JUL':
                                Rec."Sorting Value" := '7';
                            'AUG':
                                Rec."Sorting Value" := '8';
                            'SEP':
                                Rec."Sorting Value" := '9';
                            'OCT':
                                Rec."Sorting Value" := '10';
                            'NOV':
                                Rec."Sorting Value" := '11';
                            'DEC':
                                Rec."Sorting Value" := '12';
                        end;
                        Sortingvalue()
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field("Sorting Value"; Rec."Sorting Value")
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }
    local procedure Sortingvalue()
    var
        Type: Option Year,Month;
    begin
        if (Rec."Sorting Value" <> '') then
            Rec.Type := Type::Month;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Sorting Value");
        Rec.Ascending(true)
    end;
}
