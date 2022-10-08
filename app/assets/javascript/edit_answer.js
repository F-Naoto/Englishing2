edit_btn = document.querySelector("#edit_answer");
test = edit_btn.value
edit_modal = document.querySelector("#edit_modal");


edit_btn.addEventListener("click", ()=>{
 edit_modal.classList.remove("hidden");
 edit_modal.classList.add("block");
})
