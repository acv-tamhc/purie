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

	paypal.Button.render({
		env: 'sandbox',
		client: {
	    sandbox:    'AZDxjDScFpQtjWTOUtWKbyN_bDt4OgqaF4eYXlewfBP4-8aqX3PiV8e1GWU6liB2CUXlkA59kJXE7M6R',
	    production: '<insert production client id>'
		},
		commit: true,
		payment: (data, actions) -> 
			return actions.payment.create({
				payment: {
					transactions: [
						{
							amount: { total: $('#order_total').val(), currency: 'USD' }
						}
					]
				}
			})
		,
		onAuthorize: (data, actions) -> 
			return actions.payment.execute().then ->
				# window.alert('Payment Complete!')
				$('.form_checkout').submit()
	}, '#paypal-button-container')