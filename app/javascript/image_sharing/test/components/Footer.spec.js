import React from 'react';
import { shallow } from 'enzyme';
import { describe, it } from 'mocha';

import Footer from '../../components/Footer';

const assert = require('assert');

describe('test my footer', () => {
  it('should have valid footer text', () => {
    const component = shallow(<Footer />);
    const div = component.find('#footer');
    assert.strictEqual(div.text(), 'Copyright: Appfolio Inc. Onboarding');
  });
});
