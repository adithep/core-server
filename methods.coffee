Meteor.methods
  form_submit: (s_n, arr) ->
    if s_n and arr
      console.log arr
      switch s_n
        when 'inquiry'
          n = 0
          while n < arr.length
            if arr[n].key_n
              key = DATA.findOne(_s_n: "keys", key_n: arr[n].key_n)
              if key

            n++
