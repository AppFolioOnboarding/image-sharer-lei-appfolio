import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import Header from '../../components/Header';

const assert = require('assert');

describe('test my header', () => {
  it('should have valid header text', () => {
    const component = shallow(<Header title='Hello Lei!' />);
    const div = component.find('h3');
    assert.strictEqual(div.text(), 'Hello Lei!');
  });
});
