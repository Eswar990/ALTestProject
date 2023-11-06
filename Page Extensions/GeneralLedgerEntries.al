pageextension 50102 GeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Distributio Rule Applied"; Rec."Distributio Rule Applied")
            {

            }
        }
        addafter("VAT Reporting Date")
        {
            field("Dist. Entry No Applied"; Rec."Dist. Entry No Applied")
            {

            }
        }
    }
}