import React, {Component} from 'react';
import {Switch, Route, Redirect} from 'react-router-dom';
import {Container} from 'reactstrap';
import Header from './HomeHeader/HomeHeader';
import Footer from './HomeFooter/HomeFooter';

class Home extends Component {
  render() {
    return (
      <div className="app">
        <Header />
        <div className="app-body">
          <main className="main">


          </main>
        </div>
        <Footer />
      </div>
    );
  }
}
export default Home;
