window.addEventListener("turbolinks:load", function() {
	const stars = document.querySelector(".ratings").children;
	const ratingValue = document.getElementById("rating-value");
	const ratingValueDisplay = document.getElementById("rating-value-display");
	let index;

	console.log(stars)
	console.log(ratingValue)
	console.log(ratingValueDisplay)

	for(let i=0; i<stars.length; i++){
		stars[i].addEventListener("mouseover",function(){
			for(let j=0; j<stars.length; j++){
				stars[j].classList.remove("text-yellow-400");
				stars[j].classList.add("text-gray-200");
			}
			for(let j=0; j<=i; j++){
				stars[j].classList.remove("text-gray-200");
				stars[j].classList.add("text-yellow-400");
			}
		})
		stars[i].addEventListener("click",function(){
			ratingValue.value = i+1;
			ratingValueDisplay.textContent = ratingValue.value;
			index = i;
		})
		stars[i].addEventListener("mouseout",function(){
			for(let j=0; j<stars.length; j++){
				stars[j].classList.remove("text-yellow-400");
				stars[j].classList.add("text-gray-200");
			}
			for(let j=0; j<=index; j++){
				stars[j].classList.remove("text-gray-200");
				stars[j].classList.add("text-yellow-400");
			}
		})
	}
})
