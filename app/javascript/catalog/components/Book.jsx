import React from 'react';
import PropTypes from 'prop-types';

export default class Book extends React.Component {
  static propTypes = {
    title: PropTypes.string,
    description: PropTypes.string,
    image_url: PropTypes.string,
    price: PropTypes.number,
    popularity: PropTypes.number
  };
  // Add a new function to handle "Add to Cart"
  // All it does is that it calls the handleAddToCart function
  // in the BookList component.
  handleAddToCart = (e) => {   
    this.props.handleAddToCart(this.props.book.id); 
  }; 

  render = () => {
    return(
      <tr className="spa_entry">
        <td>
          <img src={this.props.book.image_url.url} />
        </td>      
        <td>{this.props.book.title}</td>
        <td dangerouslySetInnerHTML={{__html: this.props.book.description}}></td>
        <td>{this.props.book.price}</td>
        <td>{Number(this.props.book.popularity)}</td>      
        // Now, finally, add an "Add to Cat" button at the end 
        // of each book entry. A click on it will call the handleAddToCart
        // function above.
        <td>
          <a className="btn btn-success"
            onClick={this.handleAddToCart} >
            Add to Cart
          </a>
        </td>  
      </tr>
    )
  };
}