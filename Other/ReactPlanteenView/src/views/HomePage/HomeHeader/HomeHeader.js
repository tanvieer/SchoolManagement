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


        <Nav className="d-md-down-none" navbar>
          <NavItem className="px-3">
            <NavLink href="#">Dashboard</NavLink>
          </NavItem>
          <NavItem className="px-3">
            <NavLink href="#">Users</NavLink>
          </NavItem>
          <NavItem className="px-3">
            <NavLink href="#">Settings</NavLink>
          </NavItem>
        </Nav>

        <Nav className="ml-auto" navbar>
          <NavItem className="d-md-down-none">
            <NavLink href="#"><i className="icon-bell"></i><Badge pill color="danger">5</Badge></NavLink>
          </NavItem>
          <NavItem className="d-md-down-none">
            <NavLink href="#"><i className="icon-list"></i></NavLink>
          </NavItem>
          <NavItem className="d-md-down-none">
            <NavLink href="#"><i className="icon-location-pin"></i></NavLink>
          </NavItem>
          <NavItem>
  khjbj
          </NavItem>
        </Nav>

      </header>
    )
  }
}

export default Header;
