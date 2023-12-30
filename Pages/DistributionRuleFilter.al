page 50104 "Distribution Rule Filter"
{
    Caption = 'Distribution Rule Filter';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // LinksAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Distribution Rule Filter";
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field("Dimension Filter"; Rec."Dimension Filter")
                {
                }
                field("Dimension Value"; Rec."Dimension Value")
                {
                    Editable = false;
                }
                field("Distribution Method"; Rec."Distribution Method")
                {
                    Editable = false;
                }
                field("Distribution Amount"; Rec."Distribution Amount")
                {
                    Editable = false;
                }
            }
            group("Branch Distribution")
            {
                Caption = 'Branch Distribution';
                field("Dimension Value One"; Rec."Dimension Value One")
                {
                }
                field("Distrubution Amount One"; Rec."Distrubution Amount One")
                {
                }
                field("Dimension Value Two"; Rec."Dimension Value Two")
                {
                }
                field("Distrubution Amount Two"; Rec."Distrubution Amount Two")
                {
                }
                field("Dimension Value Three"; Rec."Dimension Value Three")
                {
                }
                field("Distrubution Amount Three"; Rec."Distrubution Amount Three")
                {
                }
                field("Dimension Value Four"; Rec."Dimension Value Four")
                {
                }
                field("Distrubution Amount Four"; Rec."Distrubution Amount Four")
                {
                }
                field("Dimension Value Five"; Rec."Dimension Value Five")
                {
                }
                field("Distrubution Amount Five"; Rec."Distrubution Amount Five")
                {
                }
            }
            part(DistributionProject; "Distribution Project")
            {
                Caption = 'Project Line';
                Editable = true;
                Enabled = true;
                UpdatePropagation = Both;
                SubPageLink = "Entry No." = field("Entry No.");
            }
            part(DistributionRule; "Distribution Rule")
            {
                Caption = 'Lines';
                Editable = true;
                Enabled = true;
                UpdatePropagation = Both;
                SubPageLink = "Entry No." = field("Entry No.");
            }
        }
    }
}
