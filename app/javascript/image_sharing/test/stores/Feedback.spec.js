import { describe, it } from 'mocha';

import FeedbackStore from '../../stores/FeedbackStore';

const assert = require('assert');

describe('test my FeedbackStore', () => {
  it('should have correct initialization', () => {
    const store = new FeedbackStore();
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, '');
  });

  it('should setName correctly', () => {
    const store = new FeedbackStore();

    store.setName('Adam');
    assert.strictEqual(store.name, 'Adam');
    assert.strictEqual(store.comment, '');

    store.setName('');
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, '');
  });

  it('should setComment correctly', () => {
    const store = new FeedbackStore();

    store.setComment('Hello!');
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, 'Hello!');

    store.setComment('');
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, '');
  });
});
