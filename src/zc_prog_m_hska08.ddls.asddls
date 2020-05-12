@EndUserText.label: 'Projektionview für Sprachen - Processor'
@AccessControl.authorizationCheck: #CHECK
@UI: {
 headerInfo: { typeName: 'Language', typeNamePlural: 'Languages', title: { type: #STANDARD, value: 'LanguageID' } } }

@Search.searchable: true

define root view entity ZC_PROG_M_HSKA08
  as projection on ZI_PROG_M_HSKA08
{

      @UI.facet: [ { id:              'Language',
                      purpose:         #STANDARD,
                      type:            #IDENTIFICATION_REFERENCE,
                      label:           'Programmiersprachen',
                      position:        10 } ]
      @UI.hidden: true

  key mykey           as LanguageUUID,

      @UI: {
              lineItem:       [ { position: 10, importance: #HIGH } ],
              identification: [ { position: 10, label: 'Language ID [1,...,99999999]' } ] }
      @Search.defaultSearchElement: true
      language_id     as LanguageID,

      @UI.lineItem: [{position:20 , label: 'Sprache'}]
      @UI.identification: [ { position: 20, label: 'Sprache' } ]
      language_name   as Name,
      
      @UI.lineItem: [{position:30 }]
      @UI.identification: [ { position: 30, label: 'Codebeispiel' } ]
      snippet         as Beispiel,

      @UI.lineItem: [{position:40 }]
      @UI.identification: [ { position: 40, label: 'Beschreibung' } ]
      description     as Beschreibung,
      
      @UI.lineItem: [{position: 50, type:#AS_DATAPOINT }]
      @UI.dataPoint: { title: 'Rating',
                        visualization: #RATING,
                        targetValue: 5}
      @UI.identification: [{position: 50, label: 'Rating [0-5]'}]
      rating          as Sterne,
      
      @UI: {
         lineItem:       [ { position: 50, importance: #HIGH },
                           { type: #FOR_ACTION, dataAction: 'acceptFavorite', label: 'Favorisieren' } ],
       identification: [ { position: 50, label: 'Status [F(Favorit)]' } ]  }
      favourite        as Favorit,
      
      @UI: {
         lineItem:       [ { position: 60, importance: #HIGH },
                           { type: #FOR_ACTION, dataAction: 'unFavorite', label: 'Aus Favoriten entfernen' } ] }
   

      @UI.hidden: false
      last_changed_at as Geaendert
}
