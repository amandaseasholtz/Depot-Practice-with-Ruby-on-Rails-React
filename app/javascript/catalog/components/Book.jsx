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
  state = {
    popularity : 0
  };

  handleAddToCart = (e) => {
    let temp = parseInt(this.props.book.popularity);
    temp += 1;
    this.props.book.popularity = temp.toString();
    this.props.handleAddToCart(this.props.book.id);
    this.setState({popularity: temp});
  };

  handleRemoveFromCart = (e) => {
    console.log('\n\nthis guy 2:\n\n'); console.log(this);
    console.log('pre-popularity ' + this.props.book.popularity);
    let temp = parseInt(this.props.book.popularity);
    temp === 0 ? temp-1 : 0;
    this.props.book.popularity = temp.toString();
    this.props.handleRem(this.props.book.id);
    this.setState({popularity: temp});
    console.log('\n\tREMOVEpost-popularity ' + this.props.book.popularity);
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
        {this.props.seller ? <td /> :
        <td>
           <a className="btn btn-success" onClick={this.handleAddToCart} >
              Add to Cart
           </a>
        </td>
      }
      </tr>
    )
  };
}
