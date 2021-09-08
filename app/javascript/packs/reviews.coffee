$(document).on "page:change", ->
	$('#reviews-link').click (event) ->
		event.preventDefault()
		$('#reviews-section').fadeToggle()