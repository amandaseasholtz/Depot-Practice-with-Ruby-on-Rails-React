import React from "react";
import ReactDOM from "react-dom";
import App from './routes';

document.addEventListener("DOMContentLoaded", () => {
    const catalog = document.querySelector("#catalog");
    const cart_id = JSON.parse(catalog.getAttribute("cart_id"));
    const seller = JSON.parse(catalog.getAttribute("seller"));
    const name = (catalog.getAttribute("name"));
    const address = (catalog.getAttribute("address"));
    const email = (catalog.getAttribute("email"));
    const pay_type = (catalog.getAttribute("pay_type"));
    
    
    ReactDOM.render(<App cart_id={cart_id} seller={seller} name={name} address={address} email={email} pay_type={pay_type} />, catalog);
});
