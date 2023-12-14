table 50106 "Distribution Excel Buffer Data"
{
    Caption = 'Excel Buffer Data';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee Name"; Code[50])
        {
            Caption = 'Employee Name';
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
        }
        field(3; "IV_ Group"; Code[20])
        {
            Caption = 'IV_ Group';
        }
        field(4; Projects; Code[50])
        {
            Caption = 'Projects';
        }
        field(5; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
        }
        field(7; "Percentage"; Decimal)
        {
            Caption = 'Percentage';
        }
        field(8; "Income"; Decimal)
        {
            Caption = 'Income';
        }
        field(9; Branch; Code[20])
        {
            Caption = 'Branch';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(11; "Invoice Month"; Code[20])
        {
            Caption = 'Invoice Month';
        }
        field(13; "File Name"; Text[50])
        {
            Caption = 'File Name';
        }

        field(14; "Sheet Name"; Text[50])
        {
            Caption = 'Sheet Name';
        }

        field(15; "Imported Date"; Date)
        {
            Caption = 'Imported Date';
            Editable = false;
        }

        field(16; "Time Imported"; Time)
        {
            Caption = 'Time Imported';
            Editable = false;
        }

    }
    keys
    {
        key(Key1; "Line No.", "Invoice Month")
        {
            Clustered = true;
        }
    }
}
