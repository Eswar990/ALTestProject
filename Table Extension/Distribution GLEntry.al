tableextension 50101 "Distribution GLEntry" extends "G/L Entry"
{
    fields
    {
        field(50100; "Distributio Rule Applied"; Boolean)
        {
            Caption = 'Distribution Rule Applied';
        }
        field(50101; "Distribution Required"; Boolean)
        {
            Caption = 'Distribution Required';
        }
        field(50102; "Dist. Entry No Applied"; Integer)
        {
            Caption = 'Dist. Entry No Applied';
        }
        field(50103; "Account Category"; Enum "G/L Account Category")
        {
            BlankZero = true;
            Caption = 'Account Category';
            // trigger OnValidate()
            // begin
            //     if "Account Category" = "Account Category"::" " then
            //         exit;

            //     if "Account Category" in ["Account Category"::Income, "Account Category"::"Cost of Goods Sold", "Account Category"::Expense] then
            //         "Income/Balance" := "Income/Balance"::"Income Statement"
            //     else
            //         "Income/Balance" := "Income/Balance"::"Balance Sheet";
            //     if "Account Category" <> xRec."Account Category" then
            //         "Account Subcategory Entry No." := 0;

            //     UpdateAccountCategoryOfSubAccounts();
            // end;
        }
    }
}
