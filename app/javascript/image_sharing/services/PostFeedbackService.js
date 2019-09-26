import { post } from '../utils/helper';

class PostFeedbackService {
  static doPost(name, comment, postFunction = post) {
    return postFunction('/api/feedbacks', { name, comment });
  }
}

export default PostFeedbackService;
