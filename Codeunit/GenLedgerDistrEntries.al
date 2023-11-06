codeunit 50100 GenLedgDistriEntries
{
    [EventSubscriber(ObjectType::Page, page::"General Ledger Entries", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure GeneralLedgerEntriesOnAfterGetCurrRecordEvent()
    var
        GLEntry: Record "G/L Entry";
        DistributionEntries: Page "Distribution Entries";
    begin

    end;

    var
        myInt: Integer;
}
