table 50100 "Distribution Header"
{
    Caption = 'Distribution Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {

        }
        field(2; year; Code[20])
        {

        }
        field(3; Month; Code[20])
        {

        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if (Rec."User ID" = '') then begin
            NoSeriesMgt.InitSeries('DNS', xRec."No. Series", 0D, "User ID", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
}