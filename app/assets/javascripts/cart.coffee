Loadding = {}
Loadding.open = ->
	body = $ 'body'
	has_loading = body.hasClass 'open'
	if !has_loading
		body.addClass 'open'
	else
		body.removeClass 'open'

jQuery ->
	$ '.loading'
		.click ->
			body = $ 'body'
			has_loading = body.hasClass 'open'
			if has_loading
				body.removeClass 'open'

	$ '.form_add_cart'
		.each ->
			v = $(this)
			v.submit ->
				$.ajax v.attr('action'),
				type: 'POST'
				data: v.serialize()
				dataType: 'json'
				beforeSend: ->
					Loadding.open()
				error: (e) ->
					Loadding.open()
					alert('Request not success')
					console.log(e.responseText)
				success: (data, textStatus, jqXHR) ->
					console.log(data)
					alert(data.message)
					Loadding.open()
	$ '.form_update_cart'
		.each ->
			v = $(this)
			v.submit ->
				$.ajax v.attr('action'),
				type: 'POST'
				data: v.serialize()
				dataType: 'json'
				beforeSend: ->
					Loadding.open()
				error: (e) ->
					Loadding.open()
					alert('Not update cart')
					console.log(e.responseText)
				success: (data, textStatus, jqXHR) ->
					if(data.refresh)
						location.reload()
					Loadding.open()