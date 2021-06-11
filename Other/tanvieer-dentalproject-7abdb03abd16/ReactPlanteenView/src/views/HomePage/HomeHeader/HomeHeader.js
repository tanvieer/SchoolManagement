import React, {Component} from 'react';
import {
  Badge,
  Dropdown,
  DropdownMenu,
  DropdownItem,
  Nav,
  NavItem,
  NavLink,
  NavbarToggler,
  NavbarBrand
} from 'reactstrap';

import FlatButton from 'material-ui/FlatButton';

class Header extends Component {

  constructor(props) {
    super(props);
    document.body.classList.add('sidebar-hidden');
    document.body.classList.add('aside-menu-hidden');
    document.body.classList.remove('sidebar-minimized');
  }



  render() {
    return (
      <header className="app-header navbar">
        <NavbarBrand href="#"></NavbarBrand>
        <h3>PLANTEEN DENTAL CARE</h3>



        <Nav className="ml-auto" navbar>
          <NavItem>
            <NavLink href="#/login">
              <FlatButton {...this.props} label="Login" />
            </NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="#">
              <FlatButton {...this.props} label="Show Location" />
            </NavLink>
          </NavItem>
        </Nav>

      </header>
    )
  }
}

export default Header;
