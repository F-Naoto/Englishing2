window.addEventListener("load", function() {
	const stars = document.querySelector(".ratings").children;
	const ratingValue = document.getElementById("rating-value");
	const ratingValueDisplay = document.getElementById("rating-value-display");
	let index;

	for(let i=0; i<stars.length; i++){
		stars[i].addEventListener("mouseover",function(){
			for(let j=0; j<stars.length; j++){
				stars[j].classList.remove("fa-solid");
				stars[j].classList.add("fa-light");
			}
			for(let j=0; j<=i; j++){
				stars[j].classList.remove("fa-light");
				stars[j].classList.add("fa-solid");
			}
		})
		stars[i].addEventListener("click",function(){
			ratingValue.value = i+1;
			ratingValueDisplay.textContent = ratingValue.value;
			index = i;
		})
		stars[i].addEventListener("mouseout",function(){
			for(let j=0; j<stars.length; j++){
				stars[j].classList.remove("fa-solid");
				stars[j].classList.add("fa-light");
			}
			for(let j=0; j<=index; j++){
				stars[j].classList.remove("fa-light");
				stars[j].classList.add("fa-solid");
			}
		})
	}
})
