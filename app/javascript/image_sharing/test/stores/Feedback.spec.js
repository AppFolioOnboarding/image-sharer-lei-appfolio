import { describe, it } from 'mocha';

import FeedbackStore from '../../stores/FeedbackStore';

const assert = require('assert');

describe('test my FeedbackStore', () => {
  it('should have correct initialization', () => {
    const store = new FeedbackStore();
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, '');
    assert.strictEqual(store.type, '');
    assert.strictEqual(store.flashMessage, '');
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

  it('should doSuccess correctly', () => {
    const store = new FeedbackStore();

    store.setName('Adam');
    store.setComment('Hello!');
    store.doSuccess();

    assert.strictEqual(store.type, 'success');
    assert.strictEqual(store.flashMessage, 'Thank you for submitting');
    assert.strictEqual(store.name, '');
    assert.strictEqual(store.comment, '');
  });

  it('should doFailure correctly', () => {
    const store = new FeedbackStore();

    store.setName('Adam');
    store.doFailure();

    assert.strictEqual(store.type, 'danger');
    assert.strictEqual(store.flashMessage, 'Please try again');
    assert.strictEqual(store.name, 'Adam');
    assert.strictEqual(store.comment, '');

    const store2 = new FeedbackStore();

    store2.setComment('Hello!');
    store2.doFailure();

    assert.strictEqual(store2.type, 'danger');
    assert.strictEqual(store2.flashMessage, 'Please try again');
    assert.strictEqual(store2.name, '');
    assert.strictEqual(store2.comment, 'Hello!');
  });
});
