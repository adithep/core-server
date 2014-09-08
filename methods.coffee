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
              email_id = DATA.findOne(_id: obj.email_main_arr, _s_n: "emails")
              if email_id
                switch email_id.email_ty
                  when "personal"
                    arr = []
                    DATA.find(_s_n: "keys", key_ty: "email").forEach (doc) ->
                      dobj = {}
                      dobj[doc.key_n] = obj.email_main_arr
                      arr.push(dobj)
                    human = DATA.findOne($or: arr, _s_n: "humans")
                    if human
                      nobj = {human_id: human._id, inquiry: obj.inquiry}
                    else
                      nobj = {
                        email_main: obj.email_main_arr
                        inquiry: obj.inquiry
                      }
                  when "company"
                    arr = []
                    DATA.find(_s_n: "keys", key_ty: "email").forEach (doc) ->
                      dobj = {}
                      dobj[doc.key_n] = obj.email_main_arr
                      arr.push(dobj)
                    company = DATA.findOne($or: arr, _s_n: "companies")
                    if company
                      nobj = {company_id: company._id, inquiry: obj.inquiry}
                    else
                      nobj = {
                        email_main: obj.email_main_arr
                        inquiry: obj.inquiry
                      }
                  when "company_personal"
                    arr = []
                    DATA.find(_s_n: "keys", key_ty: "email").forEach (doc) ->
                      dobj = {}
                      dobj[doc.key_n] = obj.email_main_arr
                      arr.push(dobj)
                    employee = DATA.findOne($or: arr, _s_n: "employees")
                    if employee
                      nobj = {employee_id: employee._id, inquiry: obj.inquiry}
                    else
                      nobj = {
                        email_main: obj.email_main_arr
                        inquiry: obj.inquiry
                      }
                  else
                    nobj = {
                      email_main: obj.email_main_arr
                      inquiry: obj.inquiry
                    }
              else
                eobj = {
                  _id: obj.email_main_arr
                  email_ty: "personal"
                  _s_n: "emails"
                  _dt: new Date()
                }
                if @userId
                  eobj._usr = @userId
                else
                  eobj._usr = "form"
                DATA.insert(eobj)
                nobj = {
                  email_main: obj.email_main_arr
                  inquiry: obj.inquiry
                }
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
