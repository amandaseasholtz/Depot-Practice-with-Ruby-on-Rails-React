import React from 'react'

class CreditCardPayType extends React.Component {
  render() {
    return (
      <div>
        <div className="field">
          <label htmlFor="order_credit_card_number">CC #</label>
          <input type="password"
                 name="order[routing_number]" 
                 id="order_routing_number"
                 className="form-control form-control-lg" />

        </div>
        <div className="field">
          <label htmlFor="order_expiration_date">Expiry</label>
          <input type="text"
                 name="order[account_number]" 
                 id="order_account_number"
                 className="form-control form-control-lg" />
        </div>
      </div>
    );
  }
}
export default CreditCardPayType