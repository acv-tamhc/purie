$.rails = {}
$.rails.form_build = (url = '#', method = 'get', opts = {}) ->
  _method = ''
  method  = method.toLowerCase()
  # csrf
  csrf_token = $('meta[name=csrf-token]').attr('content')
  csrf_param = $('meta[name=csrf-param]').attr('content')
  # build options
  _opts  = ''
  _opts += " #{k}=#{v}" for k, v of opts
  # method addons
  if ['post', 'patch', 'put', 'update', 'delete'].indexOf(method) > -1
    if method isnt 'post'
      _method = "<input type='hidden' value='#{method}' name='_method'>"
      method  = 'post'
  else
    method = 'get'
  # view
  $ """
  <form action='#{url}' method='#{method}' #{_opts} accept-charset='UTF-8'>
    <div style='margin:0;padding:0;display:inline'>
      #{ _method }
      <input type='hidden' value='✓' name='utf8'>
      <input type='hidden' value='#{ csrf_token }' name='#{ csrf_param }'>
    </div>
  </form>
  """

$.rails.form_submit = (f) -> f.hide().appendTo('body').submit()

jQuery ->
  $ '.list-scroll'
    .owlCarousel ->({
      pagination: false,
      dots: false,
      dotEach: false,
      nav: false,
      loop: true,
      margin: 10,
      responsive: {
        0: {
          items: 2
        },
        600: {
          items: 3
        },
        1000: {
          items: 4
        }
      }
    })