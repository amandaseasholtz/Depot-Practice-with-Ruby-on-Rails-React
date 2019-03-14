import React from 'react';
import Book from './Book';
import SortColumn from './SortColumn';


export default class BookList extends React.Component {
  // Add a new function to handle "Add to Cart"
  // All it does is that it calls the handleAddToCart function
  // in the Catalog component above.
  handleAddToCart = (id) =>{
    this.props.handleAddToCart(id);
  };

  handleRemoveFromCart = (id) =>{
    this.props.handleRemoveFromCart(id);
  };


  handleSortColumn = (name, order) => {
    this.props.handleSortColumn(name, order);
  };

  render = () => {
    var self = this;
    var books = [];
    this.props.books.forEach(function(book) {
      books.push(<Book book={book}
                       key={'book' + book.id}
                       seller={self.props.seller}
                       handleAddToCart={self.handleAddToCart}/>);
      }
    );
    { this.props.seller ?  <th /> : <th scope="col">Actions</th> }



    return(
      <table className="table table-striped" width="auto">
        <thead>
          <tr>
            <th scope="col">Image url</th>
            <th scope="col" className="sortable">
               <SortColumn
                     name="title"
                     text="Title"
                     sort={this.props.sort}
                     order={this.props.order}
                     handleSortColumn={this.handleSortColumn}
               />
            </th>
            <th scope="col">Description</th>
            <th scope="col" className="sortable">
               <SortColumn
                     name="price"
                     text="Price"
                     sort={this.props.sort}
                     order={this.props.order}
                     handleSortColumn={this.handleSortColumn}
               />
            </th>
            <th scope="col" className="sortable">
               <SortColumn
                     name="popularity"
                     text="Popularity"
                     sort={this.props.sort}
                     order={this.props.order}
                     handleSortColumn={this.handleSortColumn}
               />
            </th>
            <th scope="col">Actions</th>
          </tr>
        </thead>
        <tbody>
          {books}
        </tbody>
      </table>
    )
  };
}
