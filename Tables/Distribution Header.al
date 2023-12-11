table 50100 "Distribution Header"
{
    Caption = 'Distribution Header';
    DataClassification = ToBeClassified;

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
        field(4; "Previous Year"; Code[20])
        {

        }
        field(5; "Previous Month"; Code[20])
        {

        }
    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }

    var
}