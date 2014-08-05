Meteor.publish "list", ->
  DATA.find({
    _s_n: {$in: [
      "keys"
      "countries"
      "titles"
      "currencies"
      "companies"
      "input_forms"
      "service_n"
      "_tri"
      "_ctl"
      "def_tem"
      "templates"
      "paths"
    ]}
  }, {fields: {_dt: 0}})
