let numStarRunk = 0
const starContainer = document.querySelector('.star-container')

starContainer.addEventListener('mouseout', handleMouseOutStarContainer)

Object.keys(starContainer.children).forEach((key, index) => {
  starContainer.children[key].addEventListener('click', handleClickStar)
  starContainer.children[key].addEventListener('mouseover', handleMouseOverStar)
})


function handleClickStar() {
  numStarRunk = parseInt(this.dataset.num)
}

function handleMouseOverStar() {
  const numCurrentStar = parseInt(this.dataset.num)
  const starElements = this.parentNode.children

  Object.keys(starElements).forEach((key, index) => {
    if(index >= numCurrentStar) return
    starElements[key].classList.remove('fa-regular')
    starElements[key].classList.add('fa-solid')
  })
}

function handleMouseOutStarContainer() {
  Object.keys(this.children).forEach((key, index) => {
    this.children[key].classList.remove('fa-solid')
    this.children[key].classList.add('fa-regular')
  })

  Object.keys(this.children).forEach((key, index) => {
    if(index >= numStarRunk) return
    this.children[key].classList.remove('fa-regular')
    this.children[key].classList.add('fa-solid')
  })
}





