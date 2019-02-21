// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Hello = props => {
  return (
    <div>{props.data.length} books in the catalog.</div>
  );
};

Hello.defaultProps = {
  name: 'Savon Jackson'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  const hello_react = document.querySelector("#num_books");
  const data = JSON.parse(hello_react.getAttribute("data"));
  ReactDOM.render(<Hello data={data} />, hello_react);
})
