class Atoms.Organism.Contact extends Atoms.Organism.Article

  @scaffold "assets/scaffold/contact.json"


  # -- Children bubble events --------------------------------------------------
  onButtonTouch: (event, dispatcher, hierarchy...) ->
    # Your code...

  fetch: ->
    __.proxy("GET", "contact").then (error, value) ->
      __.Entity.Contact.create contact for contact in (value.contacts or [])

  onAdd: (event, dispatcher, hierarchy...) ->
    @form.new.clean()
    Atoms.Url.path "contact/form"

  onFormSubmit: (event, dispatcher, hierarchy...) ->
    __.proxy("POST", "contact", dispatcher.value()).then (error, value) ->
      if value
        __.Entity.Contact.create value.contact
        Atoms.Url.path "contact/list"

  onSearchChange: (event, dispatcher, hierarchy...) ->
    contact = dispatcher.value()
    if contact
      @list.contacts.select (entity) -> entity if entity.name.match contact
    else
      @list.contacts.all()

  onSearchSubmit: (event, dispatcher, hierarchy...) ->
    console.log @list.contacts
    @list.contacts.findBy "name", dispatcher.value()


new Atoms.Organism.Contact()
