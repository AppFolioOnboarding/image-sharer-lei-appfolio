import React, { Component } from 'react';

import Header from './Header';
import Form from './Form';
import Footer from './Footer';

class App extends Component {
  render() {
    return (
      <div>
        <Header title='Tell us what you think' />
        <Form />
        <Footer />
      </div>
    );
  }
}

export default App;

