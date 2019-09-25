import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { inject, observer } from 'mobx-react';

@inject('stores')
@observer
class Form extends Component {
  static propTypes = {
    stores: PropTypes.object,
  };

  render() {
    const store = this.props.stores.feedbackStore;

    return (
      <form>
        <h5>Your Name:</h5>
        <input onChange={(e) => { store.setName(e.target.value); }} />
        <h5>Comments:</h5>
        <textarea onChange={(e) => { store.setComment(e.target.value); }} />
        <button>Submit</button>
      </form>
    );
  }
}

export default Form;
