Meteor.methods
  form_submit: (fobj, obj) ->
    if fobj and obj
      obj = Mu.sanatize_obj(obj)
      s_n_obj = DATA.findOne(_s_n: "_s", _s_n_for: fobj._s_n)
      switch fobj._s_n
        when 'inquiry'
          if obj.inquiry
            nobj = {}
            nobj.inquiry = obj.inquiry
            if obj.email_main_arr
              nobj.email_main = obj.email_main_arr
              email_id = DATA.findOne(_id: obj.email_main_arr, _s_n: "emails")
              unless email_id
                eobj = {
                  _id: obj.email_main_arr
                  email_ty: "personal"
                  verfied: false
                  _s_n: "emails"
                  _dt: new Date()
                }
                if fobj.app_n
                  eobj._app = fobj.app_n
                if @userId
                  eobj._usr = @userId
                else
                  eobj._usr = "form"
                DATA.insert(eobj)
            if obj.human_id or obj.employee_id or obj.company_id
              nobj.human_id = obj.human_id if obj.human_id
              nobj.employee_id = obj.employee_id if obj.employee_id
              nobj.company_id = obj.company_id if obj.company_id
            else if email_id
              if email_id.email_ty in [
                "personal", "company", "company_personal"
              ]
                switch email_id.email_ty
                  when "personal"
                    str_s = "humans"
                    str_k = "human_id"
                  when "company"
                    str_s = "companies"
                    str_k = "company_id"
                  when "company_personal"
                    str_s = "employees"
                    str_k = "employee_id"
                arr = []
                DATA.find(_s_n: "keys", key_ty: "email").forEach (doc) ->
                  dobj = {}
                  dobj[doc.key_n] = obj.email_main_arr
                  arr.push(dobj)
                hobj = DATA.findOne($or: arr, _s_n: str_s)
                if hobj
                  nobj[str_k] = hobj._id

            else if obj.first_n
              nobj.first_n = obj.first_n
            if fobj.form_auto_add and fobj.form_auto_add.inquiry
              for key of fobj.form_auto_add.inquiry
                nobj[key] = fobj.form_auto_add.inquiry[key]
            nobj._s_n = fobj._s_n
            nobj._dt = new Date()
            if fobj.app_n
              nobj._app = fobj.app_n
            if @userId
              nobj._usr = @userId
            else
              nobj._usr = "form"
            console.log nobj
            DATA.insert(nobj)
        when 'email_subscription'
          if obj.email_main_arr
            nobj = {}
            nobj.email_main = obj.email_main_arr
            email_id = DATA.findOne(_id: obj.email_main_arr, _s_n: "emails")
            unless email_id
              eobj = {
                _id: obj.email_main_arr
                email_ty: "personal"
                verfied: false
                _s_n: "emails"
                _dt: new Date()
              }
              if fobj.app_n
                eobj._app = fobj.app_n
              if @userId
                eobj._usr = @userId
              else
                eobj._usr = "form"
              DATA.insert(eobj)
            if obj.first_n
              nobj.first_n = obj.first_n
            if fobj.form_auto_add and fobj.form_auto_add.email_subscription
              for key of fobj.form_auto_add.email_subscription
                nobj[key] = fobj.form_auto_add.email_subscription[key]
            nobj._s_n = fobj._s_n
            nobj._dt = new Date()
            if fobj.app_n
              nobj._app = fobj.app_n
            if @userId
              nobj._usr = @userId
            else
              nobj._usr = "form"
            console.log nobj
            DATA.insert(nobj)
