document.addEventListener('DOMContentLoaded', () => {
	let button = document.querySelector('show-reviews');

	button.addEventListener('click', function(event) {
	  console.log(event.type + ' event detected!');
	});
});