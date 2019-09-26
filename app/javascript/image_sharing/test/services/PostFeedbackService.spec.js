import { describe, it } from 'mocha';
import sinon from 'sinon';


import PostFeedbackService from '../../services/PostFeedbackService';

const assert = require('assert');

describe('test my PostFeedbackService', () => {
  it('should call post function', () => {
    const sandbox = sinon.createSandbox();
    const postFuntion = sandbox.spy();

    const name = 'Adam';
    const comment = 'This is excellent!';
    PostFeedbackService.doPost(name, comment, postFuntion);

    assert(postFuntion.calledOnce);

    const params = { name: 'Adam', comment: 'This is excellent!' };
    assert(postFuntion.calledWith('/api/feedbacks', params));
  });
});
