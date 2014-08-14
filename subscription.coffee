Meteor.publish "list", ->
  DATA.find({app_n_arr: "marathon"}, {fields: {_dt: 0}})
