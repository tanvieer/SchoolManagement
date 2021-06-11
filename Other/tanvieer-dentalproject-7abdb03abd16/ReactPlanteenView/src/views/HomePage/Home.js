import React, {Component} from 'react';
import {Switch, Route, Redirect} from 'react-router-dom';
import {Container} from 'reactstrap';
import Header from './HomeHeader/HomeHeader';
import Footer from './HomeFooter/HomeFooter';
import Image from 'material-ui-image'   //https://www.npmjs.com/package/material-ui-image

const styles = {
  customBackgroundImage:{
    backgroundImage: 'url(../../img/loginPageBackground.jpg)',
    backgroundSize: 'cover',
    overflow: 'hidden',
  },
};


class Home extends Component {
  render() {
    return (
      <div className="app">
        <Header />
        <div className="app-body">
          <main className="main">
          <Image 
            src="../../img/loginPageBackground.jpg"
          />

          </main>
        </div>
        <Footer />
      </div>
    );
  }
}
export default Home;
