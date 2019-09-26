import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { inject, observer } from 'mobx-react';
import { Alert } from 'reactstrap';

import PostFeedbackService from '../services/PostFeedbackService';

@inject('stores')
@observer
class Form extends Component {
  static propTypes = {
    stores: PropTypes.object,
  };

  constructor(props) {
    super(props);
    this.doSubmit = this.doSubmit.bind(this);
  }

  doSubmit(e) {
    e.preventDefault();

    const store = this.props.stores.feedbackStore;

    PostFeedbackService.doPost(store.name, store.comment)
      .then(() => {
        store.doSuccess();
      })
      .catch(() => {
        store.doFailure();
      });
  }

  render() {
    const store = this.props.stores.feedbackStore;
    return (
      <form>
        {store.flashMessage && <Alert color={store.type}>{store.flashMessage}</Alert>}
        <h5>Your Name:</h5>
        <input value={store.name} onChange={(e) => { store.setName(e.target.value); }} />
        <h5>Comments:</h5>
        <textarea value={store.comment} onChange={(e) => { store.setComment(e.target.value); }} />
        <button onClick={this.doSubmit}>Submit</button>
      </form>
    );
  }
}

export default Form;
