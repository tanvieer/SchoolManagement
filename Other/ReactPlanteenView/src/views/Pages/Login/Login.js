import React, {Component} from "react";
import {Container, Row, Col, CardGroup, Card, CardBlock, Button, Input, InputGroup, InputGroupAddon} from "reactstrap";
import TextField from 'material-ui/TextField';
import RaisedButton from 'material-ui/RaisedButton';
import {white500, blue500, red500, grey300} from 'material-ui/styles/colors';

const styles = {
  errorStyle: {
    color: red500,
  },
  underlineStyle: {
    borderColor: white500,
  },
  floatingLabelStyle: {
    color: white500,
  },
  floatingLabelFocusStyle: {
    color: white500,
  },
  hintStyle : {
    color: grey300,
  },
  loginButtonStyle: {
     marginLeft: 40,
     marginTop: 20,
     textTransform: 'uppercase',
  },
  linkStyle: {
    textDecorationLine: 'underline',
    marginLeft: 10,
    fontSize: 13,
  },
  customBackgroundImage:{
    backgroundImage: 'url(../../img/loginPageBackground.jpg)',
    backgroundSize: 'cover',
    overflow: 'hidden',
  },
};



class Login extends Component {
  render() {
    return (
      <div style={styles.customBackgroundImage} className="app flex-row align-items-center">
        <Container>
          <Row className="justify-content-center">
            <Col md="4">
              <CardGroup className="mb-0">
                <Card className="text-white bg-primary py-5 d-md-down-none">
                  <CardBlock className="card-body text-center">


                    <h1>ADMIN LOGIN</h1>
                    <TextField
                          floatingLabelText="EMAIL"
                          floatingLabelStyle={styles.floatingLabelStyle}
                          floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                          underlineFocusStyle={styles.underlineStyle}
                          floatingLabelFixed={true}
                          errorStyle={styles.errorStyle}
                          type="email"
                        />

                    <TextField
                         floatingLabelText="PASSWORD"
                         floatingLabelStyle={styles.floatingLabelStyle}
                         floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                         floatingLabelFixed={true}
                         underlineFocusStyle={styles.underlineStyle}
                         type="password"
                       />
                    <Row>
                      <Col xs="5">
                        <Button style={styles.linkStyle} color="primary" className="px-3">Forgot password?</Button>
                      </Col>
                      <Col xs="5" className="text-right">
                        <Button style={styles.linkStyle} color="primary" className="px-3">Go back to home</Button>
                      </Col>
                    </Row>
                  </CardBlock>

                  <Row>
                    <Col sm={{ size: 'auto', offset: 1 }}>
                          <RaisedButton label="Login" primary={true} style={styles.loginButtonStyle} />
                    </Col>
                  </Row>

                </Card>
              </CardGroup>
            </Col>
          </Row>
        </Container>
      </div>
    );
  }
}

export default Login;
