import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';
import sinon from 'sinon';
import { Alert } from 'reactstrap';

import Form from '../../components/Form';
import PostFeedbackService from '../../services/PostFeedbackService';

const assert = require('assert');

describe('test my form', () => {
  const sandbox = sinon.createSandbox();
  let stores;

  // eslint-disable-next-line no-undef
  beforeEach(() => {
    stores = {
      feedbackStore: {
        name: 'Adam',
        comment: 'Good!',
        flashMessage: '',
        type: '',
        setName: sandbox.spy(),
        setComment: sandbox.spy(),
        doSuccess: sandbox.spy(),
        doFailure: sandbox.spy()
      }
    };
  });

  // eslint-disable-next-line no-undef
  afterEach(() => {
    sandbox.restore();
  });


  it('should have valid rows', () => {
    const component = shallow(<Form stores={stores} />).dive();

    let elements = component.find('h5');
    assert.strictEqual(elements.length, 2);
    assert.strictEqual(elements.at(0).text(), 'Your Name:');
    assert.strictEqual(elements.at(1).text(), 'Comments:');

    assert.strictEqual(component.find('input').length, 1);
    assert.strictEqual(component.find('textarea').length, 1);

    elements = component.find('button');
    assert.strictEqual(elements.length, 1);
    assert.strictEqual(elements.at(0).text(), 'Submit');
  });

  it('should call setName when name input changes', () => {
    const page = shallow(<Form stores={stores} />).dive();
    const nameRow = page.find('input');

    let event = { target: { value: 'Alice' } };
    nameRow.simulate('change', event);
    assert(stores.feedbackStore.setName.calledWith('Alice'));

    event = { target: { value: 'Bob' } };
    nameRow.simulate('change', event);
    assert(stores.feedbackStore.setName.calledWith('Bob'));
  });

  it('should call setComment when comment input changes', () => {
    const page = shallow(<Form stores={stores} />).dive();
    const commentRow = page.find('textarea');

    let event = { target: { value: 'Good!' } };
    commentRow.simulate('change', event);
    assert(stores.feedbackStore.setComment.calledWith('Good!'));

    event = { target: { value: 'Bad!' } };
    commentRow.simulate('change', event);
    assert(stores.feedbackStore.setComment.calledWith('Bad!'));
  });

  it('should do doSuccess when post is successful', () => {
    sandbox.stub(PostFeedbackService, 'doPost').resolves();
    const preventDefaultSpy = sandbox.spy();

    const page = shallow(<Form stores={stores} />).dive();
    const button = page.find('button');
    button.simulate('click', { preventDefault: preventDefaultSpy });

    PostFeedbackService.doPost()
      .then(() => {
        assert(stores.feedbackStore.doSuccess.calledOnce);
      })
      .catch(() => {
        assert(false);
      });
    assert(preventDefaultSpy.calledOnce);
  });

  it('should do doFailure when post is failed', () => {
    sandbox.stub(PostFeedbackService, 'doPost').rejects();
    const preventDefaultSpy = sandbox.spy();

    const page = shallow(<Form stores={stores} />).dive();
    const button = page.find('button');
    button.simulate('click', { preventDefault: preventDefaultSpy });

    PostFeedbackService.doPost()
      .then(() => {
        assert(false);
      })
      .catch(() => {
        assert(stores.feedbackStore.doFailure.calledOnce);
      });
    assert(preventDefaultSpy.calledOnce);
  });


  it('should have valid flash message', () => {
    let component = shallow(<Form stores={stores} />).dive();
    let elements = component.find(Alert);
    assert.strictEqual(elements.length, 0);

    stores.feedbackStore.flashMessage = 'Hello!';
    stores.feedbackStore.type = 'good!';

    component = shallow(<Form stores={stores} />).dive();
    elements = component.find(Alert);
    assert.strictEqual(elements.length, 1);
    assert.strictEqual(elements.at(0).prop('color'), 'good!');
    assert.strictEqual(elements.at(0).children().text(), 'Hello!');
  });
});
