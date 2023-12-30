codeunit 50101 AccountCategoryinsertedGLentry
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertGLEntry', '', false, false)]
    Procedure OnAfterInitGLEntry(GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line")
    var
        SalesHeader: Record "Sales Header";
        AccountCategory: Enum "G/L Account Category";
        DistEntryNoApplied: Integer;
    begin

        // GLEntry.SetRange("Account Category", AccountCategory::Income);
        // GLEntry.SetRange("Document Type", GenJnlLine."Document Type");
        // GLEntry.SetRange("Document No.", GenJnlLine."Document No.");
        // if (GLEntry.FindFirst() = true) then
        //     DistEntryNoApplied := GLEntry."Entry No.";
        // // SalesHeader.SetRange("Document Type", GLEntry."Document Type");
        // // SalesHeader.SetRange("No.", GLEntry."Document No.");
        // // SalesHeader.FindFirst();
        // GLEntry.SetRange("Document No.", GenJnlLine."Document No.");
        // GLEntry.SetRange("Document Type", GenJnlLine."Document Type");
        // if (GLEntry.FindSet(false) = true) then
        //     repeat
        //         GLEntry."Dist. Entry No Applied" := DistEntryNoApplied;
        //         Commit();
        //         GLEntry.Modify();
        //     until GLEntry.Next() = 0
    end;
}