// codeunit 50101 AccountCategoryinsertedGLentry
// {
//     // [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterInsertEvent', '', false, false)]
//     // local procedure GenJnlLineOnAfterPostGLAcc(var Rec: Record "G/L Entry"; RunTrigger: Boolean)
//     // var
//     //     GlAccount: Record "G/L Account";
//     // begin
//     //     GlAccount.Get(Rec."G/L Account No.");
//     //     Rec."Account Category" := GlAccount."Account Category";
//     //     Rec.Modify(true);
//     // end;
//     [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnBeforeInsertEvent', '', false, false)]
//     local procedure GenJnlLineOnAfterPostGLAcc(var Rec: Record "G/L Entry"; RunTrigger: Boolean)
//     var
//         GlAccount: Record "G/L Account";
//     begin
//         GlAccount.Get(Rec."G/L Account No.");
//         Rec."Account Category" := GlAccount."Account Category";
//     end;
// }
