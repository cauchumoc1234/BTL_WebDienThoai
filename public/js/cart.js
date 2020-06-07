var all_btn = document.getElementsByClassName("add-to-cart");
//var fetchUrl = require("fetch").fetchUrl;
for(var i = 0;i < all_btn.length ; i++){
    addEvent(all_btn[i] , all_btn[i].getAttribute("name"))
}
function addEvent(button ,id){
    button.addEventListener('click',function(){
        if(document.cookie.search("customerID") >=0){
            axios.post("/customer/cart/add/"+id).then(function(res){
            })
        }
        else window.location.href ="/customer"
    })
}
var all_del_btn = document.getElementsByClassName("del-btn")
var all_amount = document.getElementsByClassName("amount");
console.log(all_amount);
for(var i = 0;i < all_amount.length ; i++){
    addAmountEvent(all_amount[i] , all_amount[i].getAttribute("name"))
}
function addAmountEvent(amount ,id){
    amount.addEventListener('change',function(){
        axios.post("/customer/cart/edit/"+id,{amount: amount.value}).then(function(res){
        })
        console.log(id);
        console.log(amount.value);
    })

}