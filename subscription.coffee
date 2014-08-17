Meteor.publish "list", (app) ->
  app = DATA.findOne(_s_n: "app_server", app_server_n: app)
  if app and app.app_n
    DATA.find({app_n_arr: app.app_n}, {fields: {_dt: 0}})
