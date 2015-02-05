"use strict"

class __.Entity.Contact extends Atoms.Class.Entity

  @fields "name", "phone", "avatar", "created_at"

  parse: ->
    image       : @avatar
    text        : @name
    description : @phone
