codeunit 50101 AccountCategoryinsertedGLentry
{
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure MyProcedure()
    begin

    end;
}
