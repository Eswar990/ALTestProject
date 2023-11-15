codeunit 50101 AccountCategoryinsertedGLentry
{
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure MyProcedure()
    begin

    end;

    procedure CreateCorrectionFromSelection(var GLEntry: Record "G/L Entry"; var DistributionRuleFilter: Record "Distribution Rule Filter")
    var
        LastDistributionRuleFilter: Record "Distribution Rule Filter";
        DimCorrectSelectionCriteria: Record "Dim Correct Selection Criteria";
        GLEntryRecordRef: RecordRef;
        NewEntryNo: Integer;
    begin
        NewEntryNo := 1;
        if LastDistributionRuleFilter.FindLast() then
            NewEntryNo := LastDistributionRuleFilter."Entry No." + 1;

        DistributionRuleFilter."Entry No." := NewEntryNo;
        DistributionRuleFilter.Insert(true);
        TransferSelectionFilterToRecordRef(GLEntry, GLEntryRecordRef);
        // InsertNewDimCorrectSelectionCriteria(GLEntryRecordRef, DimCorrectSelectionCriteria."Filter Type"::Manual, DimCorrectSelectionCriteria, NewEntryNo);
        // ReloadDimensionChangesTable(NewEntryNo);
    end;

    procedure TransferSelectionFilterToRecordRef(var GLEntry: Record "G/L Entry"; var GLEntryRecordRef: RecordRef)
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        EntryNoFieldRef: FieldRef;
        FilteredText: Text;
    begin
        GLEntryRecordRef.GetTable(GLEntry);
        FilteredText := SelectionFilterManagement.GetSelectionFilter(GLEntryRecordRef, GLEntry.FieldNo("Entry No."));
        GLEntryRecordRef.ClearMarks();
        EntryNoFieldRef := GLEntryRecordRef.Field(GLEntry.FieldNo("Entry No."));
        EntryNoFieldRef.SetFilter(FilteredText);
    end;

}
