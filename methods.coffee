Meteor.methods
  form_submit: (s_n, obj) ->
    if s_n and obj
      obj = Mu.sanatize_obj(obj)
      s_n_obj = DATA.findOne(_s_n: "_s", _s_n_for: s_n)
      switch s_n
        when 'inquiry'
          if obj.inquiry
            if obj.human_id
              nobj = {human_id: obj.human_id, inquiry: obj.inquiry}
            else if obj.email_main_arr
              nobj = {email_main: obj.email_main_arr, inquiry: obj.inquiry}
            else if obj.first_n
              nobj = {first_n: obj.first_n, inquiry: obj.inquiry}
            nobj._s_n = s_n
            nobj._dt = new Date()
            if @userId
              nobj._usr = @userId
            else
              nobj._usr = "form"
            console.log nobj
            DATA.insert(nobj)
