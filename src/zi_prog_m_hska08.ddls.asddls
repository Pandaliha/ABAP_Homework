@AbapCatalog.sqlViewName: 'ZI_PROG_M_08'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Datenmodel für Sprachen'
define root  view ZI_PROG_M_HSKA08 
as select from zprog_hska08 as Language {
    key mykey,
    language_id,
    language_name,
    description,
    snippet,
    rating,
    favorite,
    favourite,
    
    /*-- Admin data --*/
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
}
