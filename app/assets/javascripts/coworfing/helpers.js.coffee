#Truncates string
Handlebars.registerHelper "truncate", (str, len) ->
  if str.length > len
    new_str = str.substr(0, len + 1)
    while new_str.length
      ch = new_str.substr(-1)
      new_str = new_str.substr(0, -1)
      break  if ch is " "
    new_str = str.substr(0, len)  if new_str is ""
    return new Handlebars.SafeString(new_str + "...")
  str
