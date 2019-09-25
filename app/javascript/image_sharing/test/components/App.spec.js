import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import App from '../../components/App';
import Header from '../../components/Header';
import Footer from '../../components/Footer';
import Form from '../../components/Form';
import FeedbackStore from '../../stores/FeedbackStore';

const assert = require('assert');

describe('test my App', () => {
  it('App should have header and footer', () => {
    const stores = {
      feedbackStore: new FeedbackStore()
    };
    const app = shallow(<App stores={stores} />);
    const header = app.find(Header);
    assert.strictEqual(header.length, 1);
    assert.strictEqual(header.props().title, 'Tell us what you think');

    assert.strictEqual(app.find(Footer).length, 1);
  });

  it('App should have Form', () => {
    const stores = {
      feedbackStore: new FeedbackStore()
    };
    const app = shallow(<App stores={stores} />);
    const header = app.find(Form);
    assert.strictEqual(header.length, 1);
  });
});
