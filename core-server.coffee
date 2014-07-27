Accounts.validateNewUser ->
  true
DATA.find({}).observeChanges({
  added: (id, user) ->
    console.log id

})


Meteor.startup ->
  #json_control.js.seed_json_detail()
  #json_control.js.reseed_json('_tri')
