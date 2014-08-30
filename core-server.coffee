Accounts.validateNewUser ->
  true


DATA.find(_s_n: 'keys').observe

  added: (doc) ->
    if doc.key_n
      key_obj[doc.key_n] = doc

  changed: (doc) ->
    if doc.key_n
      key_obj[doc.key_n] = doc

  removed: (doc) ->
    if doc.key_n and key_obj[doc.key_n]
      delete key_obj[doc.key_n]

Meteor.startup ->
  #json_control.js.seed_json_detail()
  #json_control.js.reseed_json('_tri')
