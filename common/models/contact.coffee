"use strict"

Hope    = require("zenserver").Hope
Schema  = require("zenserver").Mongoose.Schema
db      = require("zenserver").Mongo.connections.primary


Contact = new Schema
  name      : type: String
  avatar    : type: String
  phone     : type: Number
  updated_at: type: Date
  created_at: type: Date, default: Date.now

# -- Static methods ------------------------------------------------------------
Contact.statics.register = (parameters) ->
  promise = new Hope.Promise()
  today = new Date()
  parameters.avatar = "http://robohash.org/#{today.getMilliseconds()}.png"
  contact = db.model "Contact", Contact
  new contact(parameters).save (error, value) -> promise.done error, value
  promise

Contact.statics.search = (filter) ->
  promise = new Hope.Promise()
  @find(filter).sort("name").exec (error, value) -> promise.done error, value
  promise

# -- Static methods ------------------------------------------------------------
Contact.methods.parse = ->
  name      : @name
  avatar    : @avatar
  phone     : @phone
  updated_at: @updated_at
  created_at: @created_at

exports = module.exports = db.model "Contact", Contact
