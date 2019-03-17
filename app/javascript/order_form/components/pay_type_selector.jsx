import React from 'react'

import NoPayType from './NoPayType';
import CreditCardPayType from './CreditCardPayType';
import CheckPayType from './CheckPayType';
import PurchaseOrderPayType from './PurchaseOrderPayType';

export default class pay_type_selector extends React.Component {
  constructor(props) {
    super(props);
    this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
    this.state = { selectedPayType: this.props.pay_type };
    console.log(this.state);
    console.log(this.state.selectedPayType);
  }

  componentDidMount = () => {
    this.setState({ selectedPayType: this.props.pay_type ? this.props.pay_type : "" });
  };

  onPayTypeSelected(event) {
    this.setState({ selectedPayType: event.target.value });
    if (this.props.handleSelectPayType) {
      this.props.handleSelectPayType(event.target.value);
    }
  }

  render() {
    let PayTypeCustomComponent = NoPayType;
    if (this.state.selectedPayType == "Credit card" || this.state.selectedPayType ==0) {
      PayTypeCustomComponent = CreditCardPayType;
    } else if (this.state.selectedPayType == "Check"|| this.state.selectedPayType == 1) {
      PayTypeCustomComponent = CheckPayType;
    } else if (this.state.selectedPayType == "Purchase order"|| this.state.selectedPayType == 2) {
      PayTypeCustomComponent = PurchaseOrderPayType;
    }
    return (
      <div>
        <div className="field">
          <label htmlFor="order_pay_type">Pay type</label>
          <select className="form-control form-control-lg" id="pay_type" onChange={this.onPayTypeSelected} 
            name="order[pay_type]">
            <option value="">Select a payment method</option>
            <option value="Check">Check</option>
            <option value="Credit card">Credit card</option>
            <option value="Purchase order">Purchase order</option>
          </select>
        </div>
        <PayTypeCustomComponent />
      </div>
    );
  }
}
