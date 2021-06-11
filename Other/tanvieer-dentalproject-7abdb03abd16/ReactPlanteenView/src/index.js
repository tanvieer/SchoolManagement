import React from 'react';
import ReactDOM from 'react-dom';
import {HashRouter, Route, Switch} from 'react-router-dom';
import {createBrowserHistory} from 'history';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

// Styles
// Import Font Awesome Icons Set
import 'font-awesome/css/font-awesome.min.css';
  // Import Simple Line Icons Set
import 'simple-line-icons/css/simple-line-icons.css';
// Import Main styles for this application
import '../scss/style.scss'

// Containers
import Full from './containers/Full/'

// Views
import Login from './views/Pages/Login/'
import Register from './views/Pages/Register/'
import Page404 from './views/Pages/Page404/'
import Page500 from './views/Pages/Page500/'
import HomePage from './views/HomePage/'

const history = createBrowserHistory();

// const App = () => (
//   <MuiThemeProvider>
//     <MyAwesomeReactComponent />
//   </MuiThemeProvider>
// );


ReactDOM.render((
    <MuiThemeProvider>
    <HashRouter history={history}>
      <Switch>
        <Route exact path="/login" name="Login Page" component={Login}/>
        <Route exact path="/register" name="Register Page" component={Register}/>
        <Route exact path="/404" name="Page 404" component={Page404}/>
        <Route exact path="/500" name="Page 500" component={Page500}/>
        <Route exact path="/Homepage" name="Homepage" component={HomePage}/>
        <Route path="/" name="Home" component={Full}/>
      </Switch>
    </HashRouter>
    </MuiThemeProvider>
), document.getElementById('root'));


//
// import React from 'react';
// import ReactDOM from 'react-dom';
// import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
// import MyAwesomeReactComponent from './MyAwesomeReactComponent';
//
// const App = () => (
//   <MuiThemeProvider>
//     <MyAwesomeReactComponent />
//   </MuiThemeProvider>
// );
//
// ReactDOM.render(
//   <App />,
//   document.getElementById('app')
// );
