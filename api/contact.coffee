"use strict"

Contact = require "../common/models/contact"

module.exports = (server) ->

  server.get "/api/contact", (request, response) ->
    Contact.search().then (error, result) ->
      if error
        response.json message: error.message, error.code
      else
        response.json contacts: (contact.parse() for contact in result)


  server.post "/api/contact", (request, response) ->
    if request.required ["name", "phone"]
      Contact.register(request.parameters).then (error, result) ->
        if error
          response.json message: error.message, error.code
        else
          response.json contact: result.parse()

