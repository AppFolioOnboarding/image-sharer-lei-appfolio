import { action, observable } from 'mobx';

class FeedbackStore {
  @observable name;
  @observable comment;

  constructor() {
    this.name = '';
    this.comment = '';
  }

  @action setName(name) {
    this.name = name;
  }

  @action setComment(comment) {
    this.comment = comment;
  }
}

export default FeedbackStore;
