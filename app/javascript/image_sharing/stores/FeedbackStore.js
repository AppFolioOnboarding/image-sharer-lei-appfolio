import { action, observable } from 'mobx';

class FeedbackStore {
  @observable name;
  @observable comment;

  @observable type = '';
  @observable flashMessage = '';

  constructor() {
    this.name = '';
    this.comment = '';

    this.type = '';
    this.flashMessage = '';
  }

  @action setName(name) {
    this.name = name;
  }

  @action setComment(comment) {
    this.comment = comment;
  }

  @action doSuccess() {
    this.type = 'success';
    this.flashMessage = 'Thank you for submitting';

    this.name = '';
    this.comment = '';
  }

  @action doFailure() {
    this.type = 'danger';
    this.flashMessage = 'Please try again';
  }
}

export default FeedbackStore;
