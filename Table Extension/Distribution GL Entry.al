tableextension 50101 "Distribution GL Entry" extends "G/L Entry"
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
        field(50102; "Dist. Entry No Applied"; Boolean)
        {
            Caption = 'Dist. Entry No Applied';
        }
        field(50103; "Account Category"; Boolean)
        {
            Caption = 'Account Category';
        }
    }
}
