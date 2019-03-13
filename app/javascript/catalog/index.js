import React from "react";
import ReactDOM from "react-dom";
import App from './routes';

document.addEventListener("DOMContentLoaded", () => {
    const catalog = document.querySelector("#catalog");
    const cart_id = JSON.parse(catalog.getAttribute("cart_id"));
    const seller = JSON.parse(catalog.getAttribute("seller"));
    ReactDOM.render(<App cart_id={cart_id} seller={seller} />, catalog);
});